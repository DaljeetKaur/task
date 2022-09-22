#######################
# VPC Endpoint for SSM
#######################
data "aws_vpc_endpoint_service" "ssm" {
  count = var.create_vpc && var.enable_ssm_endpoint ? 1 : 0

  service = "ssm"
}

resource "aws_vpc_endpoint" "ssm" {
  count = var.create_vpc && var.enable_ssm_endpoint ? 1 : 0

  vpc_id            = aws_vpc.this[0].id
  service_name      = data.aws_vpc_endpoint_service.ssm[0].service_name
  vpc_endpoint_type = "Interface"

  security_group_ids  = [module.vpc_ssm_ecr_cc_sg.security_group_id]
  #subnet_ids          = coalescelist(var.ssm_endpoint_subnet_ids, aws_subnet.ad.*.id)
  subnet_ids          = var.endpoint_subnet_ids
  private_dns_enabled = var.ssm_endpoint_private_dns_enabled
  tags                = local.vpce_tags
}

###############################
# VPC Endpoint for SSMMESSAGES
###############################
data "aws_vpc_endpoint_service" "ssmmessages" {
  count = var.create_vpc && var.enable_ssmmessages_endpoint ? 1 : 0

  service = "ssmmessages"
}

resource "aws_vpc_endpoint" "ssmmessages" {
  count = var.create_vpc && var.enable_ssmmessages_endpoint ? 1 : 0

  vpc_id            = aws_vpc.this[0].id
  service_name      = data.aws_vpc_endpoint_service.ssmmessages[0].service_name
  vpc_endpoint_type = "Interface"

  security_group_ids  = [module.vpc_ssm_ecr_cc_sg.security_group_id]
  #subnet_ids          = coalescelist(var.ssmmessages_endpoint_subnet_ids, aws_subnet.ad.*.id)
  subnet_ids          = var.endpoint_subnet_ids
  private_dns_enabled = var.ssmmessages_endpoint_private_dns_enabled
  tags                = local.vpce_tags
}


###############################
# VPC Endpoint for EC2MESSAGES
###############################
data "aws_vpc_endpoint_service" "ec2messages" {
  count = var.create_vpc && var.enable_ec2messages_endpoint ? 1 : 0

  service = "ec2messages"
}

resource "aws_vpc_endpoint" "ec2messages" {
  count = var.create_vpc && var.enable_ec2messages_endpoint ? 1 : 0

  vpc_id            = aws_vpc.this[0].id
  service_name      = data.aws_vpc_endpoint_service.ec2messages[0].service_name
  vpc_endpoint_type = "Interface"

  security_group_ids  = [module.vpc_ssm_ecr_cc_sg.security_group_id]
  #subnet_ids          = coalescelist(var.ec2messages_endpoint_subnet_ids, aws_subnet.ad.*.id)
  subnet_ids          = var.endpoint_subnet_ids
  private_dns_enabled = var.ec2messages_endpoint_private_dns_enabled
  tags                = local.vpce_tags
}

#######################################################
# Security Group - VPC Endpoint (SSM, ECR, Codecommit)
#######################################################
module "vpc_ssm_ecr_cc_sg" {
  source = "../terraform-aws-sg"
  name        = "VPC_ENDPOINT_SG"
  description = "Endpoint security group for SSM, ECR, Codecommit"
  vpc_id      = aws_vpc.this[0].id

  ingress_cidr_blocks = split(",", var.cidr)
  ingress_rules       = ["https-443-tcp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]
}

###################################
# VPC Endpoint for EC2
###################################
data "aws_vpc_endpoint_service" "ec2" {
  count = var.create_vpc && var.enable_ec2_endpoint ? 1 : 0

  service = "ec2"
}

resource "aws_vpc_endpoint" "ec2_ep" {
  count = var.create_vpc && var.enable_ec2_endpoint ? 1 : 0

  vpc_id            = aws_vpc.this[0].id
  service_name      = data.aws_vpc_endpoint_service.ec2[0].service_name
  vpc_endpoint_type = "Interface"

  security_group_ids  = [module.vpc_ssm_ecr_cc_sg.security_group_id]
  # subnet_ids          = coalescelist(var.codecommit_endpoint_subnet_ids, aws_subnet.private.*.id)
  subnet_ids          = var.endpoint_subnet_ids
  private_dns_enabled = var.ec2_endpoint_private_dns_enabled
  tags                = local.vpce_tags
}

###################################
# VPC Endpoint for SQS
###################################
data "aws_vpc_endpoint_service" "sqs" {
  count = var.create_vpc && var.enable_sqs_endpoint ? 1 : 0

  service = "sqs"
}

resource "aws_vpc_endpoint" "sqs_ep" {
  count = var.create_vpc && var.enable_sqs_endpoint ? 1 : 0

  vpc_id            = aws_vpc.this[0].id
  service_name      = data.aws_vpc_endpoint_service.sqs[0].service_name
  vpc_endpoint_type = "Interface"

  security_group_ids  = [module.vpc_ssm_ecr_cc_sg.security_group_id]
  # subnet_ids          = coalescelist(var.codecommit_endpoint_subnet_ids, aws_subnet.private.*.id)
  subnet_ids          = var.endpoint_subnet_ids
  private_dns_enabled = var.sqs_endpoint_private_dns_enabled
  tags                = local.vpce_tags
}


###################################
# VPC Endpoint for S3
###################################
data "aws_vpc_endpoint_service" "s3" {
  count = var.create_vpc && var.enable_s3_endpoint ? 1 : 0

  service = "s3"

    filter {
    name   = "service-type"
    values = ["Interface"]
  }
}

resource "aws_vpc_endpoint" "s3_ep" {
  count = var.create_vpc && var.enable_s3_endpoint ? 1 : 0

  vpc_id            = aws_vpc.this[0].id
  service_name      = data.aws_vpc_endpoint_service.s3[0].service_name
  vpc_endpoint_type = "Interface"

  security_group_ids  = [module.vpc_ssm_ecr_cc_sg.security_group_id]
  # subnet_ids          = coalescelist(var.codecommit_endpoint_subnet_ids, aws_subnet.private.*.id)
  subnet_ids          = var.endpoint_subnet_ids
#  private_dns_enabled = var.s3_endpoint_private_dns_enabled
  tags                = local.vpce_tags
}


