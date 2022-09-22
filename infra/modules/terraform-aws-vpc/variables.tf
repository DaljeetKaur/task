variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment Name to be used as identifier"
  type        = string
  default     = ""
}

variable "resource_name_prefix" {
  description = "Resource Name prefix to be used on all the resources as identifier"
  type        = string
  default     = ""
}


variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "0.0.0.0/0"
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = true
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = false
}

variable "enable_transit_gateway" {
  description = "Should be true if you want to Transit Gateway for each of the VPC CIDR"
  type        = bool
  default     = false
}


variable "one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`."
  type        = bool
  default     = false
}

variable "dhcp_options_tags" {
  description = "Additional tags for the DHCP option set (requires enable_dhcp_options set to true)"
  type        = map(string)
  default     = {}
}

variable "enable_dhcp_options" {
  description = "Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type"
  type        = bool
  default     = false
}

variable "dhcp_options_domain_name" {
  description = "Specifies DNS name for DHCP options set (requires enable_dhcp_options set to true)"
  type        = string
  default     = ""
}

variable "dhcp_options_domain_name_servers" {
  description = "Specify a list of DNS server addresses for DHCP options set, default to AWS provided (requires enable_dhcp_options set to true)"
  type        = list(string)
  default     = ["AmazonProvidedDNS"]
}

variable "nat_eip_tags" {
  description = "Additional tags for the NAT EIP"
  type        = map(string)
  default     = {}
}

variable "reuse_nat_ips" {
  description = "Should be true if you don't want EIPs to be created for your NAT Gateways and will instead pass them in via the 'external_nat_ip_ids' variable"
  type        = bool
  default     = false
}

variable "external_nat_ip_ids" {
  description = "List of EIP IDs to be assigned to the NAT Gateways (used in combination with reuse_nat_ips)"
  type        = list(string)
  default     = []
}

variable "external_nat_ips" {
  description = "List of EIPs to be used for `nat_public_ips` output (used in combination with reuse_nat_ips and external_nat_ip_ids)"
  type        = list(string)
  default     = []
}

variable "public_route_table_tags" {
  description = "Additional tags for the public route tables"
  type        = map(string)
  default     = {}
}

variable "igw_tags" {
  description = "Additional tags for the internet gateway"
  type        = map(string)
  default     = {}
}

variable "create_igw" {
  description = "Controls if an Internet Gateway is created for public subnets and the related routes that connect them."
  type        = bool
  default     = true
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  type        = map(string)
  default     = {}
}

variable "nat_gateway_tags" {
  description = "Additional tags for the NAT gateways"
  type        = map(string)
  default     = {}
}

variable "application_subnets" {
  description = "A list of application subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "application_subnet_tags" {
  description = "Additional tags for the application subnets"
  type        = map(string)
  default     = {}
}

variable "database_subnets" {
  description = "A list of database subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "database_subnet_tags" {
  description = "Additional tags for the database subnets"
  type        = map(string)
  default     = {}
}


variable "catalog_subnets" {
  description = "A list of catalog subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "catalog_subnet_tags" {
  description = "Additional tags for the catalog subnets"
  type        = map(string)
  default     = {}
}

variable "userworkspace_subnets" {
  description = "A list of userworkspace subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "userworkspace_subnet_tags" {
  description = "Additional tags for the userworkspace subnets"
  type        = map(string)
  default     = {}
}

variable "enable_ssm_endpoint" {
  description = "Should be true if you want to provision an SSM endpoint to the VPC"
  type        = bool
  default     = true
}

variable "ssm_endpoint_security_group_ids" {
  description = "The ID of one or more security groups to associate with the network interface for SSM endpoint"
  type        = list(string)
  default     = []
}

variable "ssm_endpoint_private_dns_enabled" {
  description = "Whether or not to associate a private hosted zone with the specified VPC for SSM endpoint"
  type        = bool
  default     = true
}

variable "enable_ssmmessages_endpoint" {
  description = "Should be true if you want to provision a SSMMESSAGES endpoint to the VPC"
  type        = bool
  default     = true
}

variable "enable_ec2messages_endpoint" {
  description = "Should be true if you want to provision an EC2MESSAGES endpoint to the VPC"
  type        = bool
  default     = true
}

variable "ec2messages_endpoint_private_dns_enabled" {
  description = "Whether or not to associate a private hosted zone with the specified VPC for EC2MESSAGES endpoint"
  type        = bool
  default     = true
}

variable "ssmmessages_endpoint_private_dns_enabled" {
  description = "Whether or not to associate a private hosted zone with the specified VPC for SSMMESSAGES endpoint"
  type        = bool
  default     = true
}

/* variable "ssm_endpoint_subnet_ids" {
  description = "The ID of one or more subnets in which to create a network interface for SSM endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used."
  type        = list(string)
  default     = []
}
 */
variable "endpoint_subnet_ids" {
  description = "The ID of one or more subnets in which to create a network interface for VPC endpoints. Only a single subnet within an AZ is supported. If omitted, private subnets will be used."
  type        = list(string)
  default     = []
}

variable "ssmmessages_endpoint_subnet_ids" {
  description = "The ID of one or more subnets in which to create a network interface for SSMMESSAGES endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used."
  type        = list(string)
  default     = []
}


variable "vpc_endpoint_tags" {
  description = "A mapping of tags to assign to vpc endpoint"
  type        = map(string)
  default     = {}
}

variable "ec2messages_endpoint_subnet_ids" {
  description = "The ID of one or more subnets in which to create a network interface for EC2MESSAGES endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used."
  type        = list(string)
  default     = []
}

variable "private_route_table_tags" {
  description = "A mapping of tags to assign to private route table"
  type        = map(string)
  default     = {}
}

variable "database_subnet_group_tags" {
  description = "A mapping of tags to assign to database subnet group tags"
  type        = map(string)
  default     = {}
}



variable "ssm_endpoints_sg_ids" {
  description = "The ID of one or more Security group to be attached to the SSM vpc endpoints"
  type        = list(string)
  default     = []
}

variable "transit_gateway_id" {
  description = "Transit Gateway Id"
  type        = string
  default     = ""
}


variable "enable_s3_endpoint" {
  description = "Whether or not to enable S3 endpoint for the VPC"
  type        = bool
  default     = false
}

variable "enable_ec2_endpoint" {
  description = "Whether or not to enable EC2 endpoint for the VPC"
  type        = bool
  default     = false
}

variable "ec2_endpoint_private_dns_enabled" {
  description = "Whether or not to enable private dns for the VPC endpoint"
  type        = bool
  default     = true
}

variable "enable_sqs_endpoint" {
  description = "Whether or not to enable EC2 endpoint for the VPC"
  type        = bool
  default     = false
}

variable "sqs_endpoint_private_dns_enabled" {
  description = "Whether or not to enable private dns for the VPC endpoint"
  type        = bool
  default     = true
}


/* variable "enable_s3_endpoint" {
  description = "Whether or not to enable EC2 endpoint for the VPC"
  type        = bool
  default     = false
}*/

variable "s3_endpoint_private_dns_enabled" {
  description = "Whether or not to enable private dns for the VPC endpoint"
  type        = bool
  default     = true
}


