locals {
  nat_gateway_count = var.single_nat_gateway ? 1 : var.one_nat_gateway_per_az ? length(var.azs) : 0
  vpce_tags = merge(
    var.tags,
    var.vpc_endpoint_tags,
  )
  vpc_name = format("%s%s", var.resource_name_prefix,var.resource_names["vpc_name"])
}

######
# VPC
######
resource "aws_vpc" "this" {
  count = var.create_vpc ? 1 : 0

  cidr_block           = var.cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    {
      "Name" = local.vpc_name
    },
    var.tags,
    var.vpc_tags,
  )
}

###################
# DHCP Options Set
###################
resource "aws_vpc_dhcp_options" "this" {
  count = var.create_vpc && var.enable_dhcp_options ? 1 : 0

  domain_name         = var.dhcp_options_domain_name
  domain_name_servers = var.dhcp_options_domain_name_servers

  tags = merge(
    {
      "Name" = format("%s%s%s", local.vpc_name,"_",var.resource_names["dhcp_options_name"])
    },
    var.tags,
    var.dhcp_options_tags,
  )
}

###############################
# DHCP Options Set Association
###############################
resource "aws_vpc_dhcp_options_association" "this" {
  count = var.create_vpc && var.enable_dhcp_options ? 1 : 0

  vpc_id          = aws_vpc.this[0].id
  dhcp_options_id = aws_vpc_dhcp_options.this[0].id
}

###################
# Public Subnets
###################
resource "aws_subnet" "public" {
  count             = var.create_vpc && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0
  vpc_id            = aws_vpc.this[0].id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
    {
      "Name" = format("%s%s%s", var.resource_name_prefix,var.resource_names["public_subnet_name"],upper(element(split("-",var.azs[count.index]),2)))
    },
    var.tags,
    var.public_subnet_tags,
  )
}

###################
# Internet Gateway
###################
resource "aws_internet_gateway" "this" {
  count = var.create_vpc && var.create_igw && length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.this[0].id

  tags = merge(
    {
      "Name" = format("%s%s%s", local.vpc_name,"_",var.resource_names["igw_name"])
    },
    var.tags,
    var.igw_tags,
  )
}

################
# Publiс routes
################
resource "aws_route_table" "public" {
  count = var.create_vpc && length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.this[0].id

  tags = merge(
    {
      "Name" = format("%s%s%s", local.vpc_name,"_",var.resource_names["pubic_rt_name"])
    },
    var.tags,
    var.public_route_table_tags,
  )
}

resource "aws_route" "public_internet_gateway" {
  count = var.create_vpc && var.create_igw && length(var.public_subnets) > 0 ? 1 : 0

  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id

  timeouts {
    create = "5m"
  }
}

##########################
# Route table association
##########################

resource "aws_route_table_association" "public" {
  count = var.create_vpc && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public[0].id
}

##############
# NAT Gateway
##############


resource "aws_eip" "nat" {
  count = var.create_vpc && var.enable_nat_gateway ? local.nat_gateway_count : 0

  vpc = true

  tags = merge(
    {
      "Name" = format("%s%s%s", local.vpc_name,"_",var.resource_names["nat_eip_name"])  
    },
    var.tags,
    var.nat_eip_tags,
  )
}

resource "aws_nat_gateway" "this" {
  count = var.create_vpc && var.enable_nat_gateway ? local.nat_gateway_count : 0

  allocation_id = element(
    aws_eip.nat.*.id,
    var.single_nat_gateway ? 0 : count.index,
  )
  subnet_id = element(
    aws_subnet.public.*.id,
    var.single_nat_gateway ? 0 : count.index,
  )

  tags = merge(
    {
      "Name" = format("%s%s%s", var.resource_name_prefix,var.resource_names["nat_gateway_name"],upper(element(split("-",var.azs[count.index]),2)))
    },
    var.tags,
    var.nat_gateway_tags,
  )

  depends_on = [aws_internet_gateway.this]
}

################################
# Application Subnets 
################################
resource "aws_subnet" "application" {
  count             = var.create_vpc && length(var.application_subnets) > 0 ? length(var.application_subnets) : 0
  vpc_id            = aws_vpc.this[0].id
  cidr_block        = var.application_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
    {
      "Name" = format("%s%s%s", var.resource_name_prefix,var.resource_names["app_subnet_name"],upper(element(split("-",var.azs[count.index]),2)))
    },
    var.tags,
    var.application_subnet_tags,
  )
}

################################
# Database Subnets
################################
resource "aws_subnet" "database" {
  count             = var.create_vpc && length(var.database_subnets) > 0 ? length(var.database_subnets) : 0
  vpc_id            = aws_vpc.this[0].id
  cidr_block        = var.database_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
    {
      "Name" = format("%s%s%s", var.resource_name_prefix,var.resource_names["db_subnet_name"],upper(element(split("-",var.azs[count.index]),2)))
    },
    var.tags,
    var.database_subnet_tags,
  )
}

resource "aws_db_subnet_group" "database" {
  count = var.create_vpc && length(var.database_subnets) > 0 ? 1 : 0

  name        = lower(format("%s%s%s",var.environment,"-",var.resource_names["dbsubnet_group_name"])) 
  description = "Database subnet group"
  subnet_ids  = aws_subnet.database.*.id

  tags = merge(
    {
      "Name" = format("%s%s%s", lower(local.vpc_name),"_",var.resource_names["dbsubnet_group_name"])
    },
    var.tags,
    var.database_subnet_group_tags,
  )
}


#################
# Private routes
# There are as many routing tables as the number of NAT gateways
#################
resource "aws_route_table" "private" {
  # count = var.create_vpc && var.enable_nat_gateway ? local.nat_gateway_count : 0
  count = var.create_vpc && var.enable_nat_gateway ? local.nat_gateway_count : 1

  vpc_id = aws_vpc.this[0].id

  tags = merge(
    {
      "Name" = format("%s%s%s", local.vpc_name,"_",var.resource_names["private_rt_name"])

    },
    var.tags,
    var.private_route_table_tags,
  )
}


resource "aws_route" "private_nat_gateway" {
  count = var.create_vpc && var.enable_nat_gateway ? local.nat_gateway_count : 0

  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.this.*.id, count.index)

  timeouts {
    create = "5m"
  }
}

################################
# Catalog Subnets
################################
resource "aws_subnet" "catalog" {
  count             = var.create_vpc && length(var.catalog_subnets) > 0 ? length(var.catalog_subnets) : 0
  vpc_id            = aws_vpc.this[0].id
  cidr_block        = var.catalog_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
    {
      "Name" = format("%s%s%s", var.resource_name_prefix,var.resource_names["catalog_subnet_name"],upper(element(split("-",var.azs[count.index]),2)))
    },
    var.tags,
    var.catalog_subnet_tags,
  )
}

resource "aws_route_table_association" "application" {
  count = var.create_vpc && length(var.application_subnets) > 0 ? length(var.application_subnets) : 0

  subnet_id = element(aws_subnet.application.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id,
    var.single_nat_gateway ? 0 : count.index,
  )
} 




