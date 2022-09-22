locals {
  environment = terraform.workspace
  db_ud_file_path = format("%s%s",var.file_path,var.db_ud_filename)
  webfnd_ud_file_path = format("%s%s",var.file_path,var.web_ud_filename)
  app_bckend_ud_file_path = format("%s%s",var.file_path,var.app_bckend_ud_filename)
  resource_name_prefix = upper(format("%s%s",local.environment,"_"))
  resource_vpc_name = upper(format("%s%s",var.resource_vpc_name,"_"))
  region_name = split("-",var.region)
  region_short_name = format("%s%s%s", local.region_name[0] ,substr(local.region_name[1], 0, 1),substr(local.region_name[2], 0, 1))

  tags = merge(
    var.tags

  )

}

###################
# Platform VPC
###################
module "ptfm_vpc" {
  source = "../../modules/terraform-aws-vpc"

  resource_name_prefix = format("%s%s",local.resource_name_prefix,local.resource_vpc_name)
  environment = local.environment

  cidr = var.cidr

  azs                   = var.azs
  public_subnets        = var.public_subnets
  application_subnets   = var.application_subnets
  database_subnets      = var.database_subnets
  catalog_subnets       = var.catalog_subnets

  transit_gateway_id = module.task_tgw.tgw_id

  enable_transit_gateway = true

  endpoint_subnet_ids = module.ptfm_vpc.application_subnets

  enable_nat_gateway = var.enable_nat_gateway

  tags = local.tags
}



##################################
# Security Group Web FrontEnd- EC2
##################################
module "application_ec2_webfnd_sg" {
  source = "../../modules/terraform-aws-sg"
  name = format("%s%s%s",local.resource_name_prefix,local.resource_vpc_name, "WEBFND_EC2_SG")
  description = "EC2 Security group"
  vpc_id      = module.ptfm_vpc.vpc_id
  #ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_cidr_blocks = split(",", var.task_cidr_block)
  ingress_rules       = ["http-80-tcp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]
  tags = local.tags
}

##################################
# Security Group App Backend- EC2
##################################
module "application_ec2_bckend_sg" {
  source = "../../modules/terraform-aws-sg"
  name = format("%s%s%s",local.resource_name_prefix,local.resource_vpc_name, "BCKEND_EC2_SG")
  description = "EC2 Security group"
  vpc_id      = module.ptfm_vpc.vpc_id
  #ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_cidr_blocks = split(",", var.task_cidr_block)
  ingress_rules       = ["http-8081-tcp", "http-8082-tcp", "http-8090-tcp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]
  tags = local.tags
}

##################################
# Security Group db- EC2
##################################
module "application_ec2_db_sg" {
  source = "../../modules/terraform-aws-sg"
  name = format("%s%s%s",local.resource_name_prefix,local.resource_vpc_name, "db_EC2_SG")
  description = "EC2 Security group"
  vpc_id      = module.ptfm_vpc.vpc_id
  #ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_cidr_blocks = split(",", var.task_cidr_block)
  ingress_rules       = ["http-5000-tcp", "http-8085-tcp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]
  tags = local.tags
}


#############################
# Security Group - Database
#############################

module "db_sg" {
  source = "../../modules/terraform-aws-sg"
  name = format("%s%s%s",local.resource_name_prefix,local.resource_vpc_name, "DB_SG")
  description = "EC2 Security group"
  vpc_id      = module.ptfm_vpc.vpc_id

  ingress_cidr_blocks = [var.cidr]
  ingress_rules       = ["mysql-tcp"]
  tags = local.tags
}

##########################
# Web Front Servers - EC2
##########################
module "ptfm_webfnd_ec2" {
  source         = "../../modules/terraform-aws-ec2-instance"
  name = format("%s%s%s",local.resource_name_prefix,local.resource_vpc_name, "APST_EC2_WEBFND_AZ")
  azs = var.azs
  instance_count = var.webfnd_instance_count
  ami            = var.deploy_task1_account == true ? data.aws_ami.ubuntu_nav_webfnd[0].id : data.aws_ami.ubuntu[0].id
  instance_type  = var.webfnd_instance_type
  user_data = file(local.webfnd_ud_file_path)
  subnet_ids     = module.ptfm_vpc.application_subnets
  vpc_security_group_ids = [module.application_ec2_webfnd_sg.security_group_id]
  iam_instance_profile   = data.aws_iam_instance_profile.ptfm_webfnd_ec2_profile.name

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 20
    }
  ]

  tags = local.tags


}

###################################
# Application Backend Servers - EC2
###################################
module "ptfm_bckend_ec2" {
  source                 = "../../modules/terraform-aws-ec2-instance"
  name                   = format("%s%s%s", local.resource_name_prefix, local.resource_vpc_name, "APST_EC2_BCKEND_AZ")
  azs                    = var.azs
  instance_count         = var.app_bckend_instance_count
  ami                    = var.deploy_task1_account == true ? data.aws_ami.ubuntu_nav_bckend[0].id : data.aws_ami.ubuntu[0].id
  user_data              = file(local.app_bckend_ud_file_path)
  instance_type          = var.app_bckend_instance_type
  subnet_ids             = module.ptfm_vpc.application_subnets
  vpc_security_group_ids = [module.application_ec2_bckend_sg.security_group_id]
  iam_instance_profile   = data.aws_iam_instance_profile.ptfm_bckend_ec2_profile.name

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 20
    }
  ]

  tags = local.tags
}

###################################
# db Application Servers - EC2
###################################
module "ptfm_db_ec2" {
  source         = "../../modules/terraform-aws-ec2-instance"
  name = format("%s%s%s",local.resource_name_prefix,local.resource_vpc_name, "CGST_EC2_dbSR_AZ")
  azs = var.azs
  instance_count = var.db_instance_count
  user_data = file(local.db_ud_file_path)
  ami            = var.deploy_task1_account == true ? data.aws_ami.ubuntu_nav_db[0].id : data.aws_ami.ubuntu[0].id
  instance_type  = var.db_instance_type
  subnet_ids     = module.ptfm_vpc.catalog_subnets
  vpc_security_group_ids = [module.application_ec2_db_sg.security_group_id]
  iam_instance_profile   = data.aws_iam_instance_profile.ptfm_db_ec2_profile.name

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 20
    }
  ]

  tags = local.tags


}

###################################
# Platform - S3 Buckets
###################################
module "ptfm_s3_bucket" {
  source  = "../../modules/terraform-aws-s3"
  region = var.region
  create_ptfm_bucket = true
  ptfm_s3_name_prefix = format("%s%s",local.environment, "-")
  tags = local.tags
}

########################################
# Platform - Network Load Balancer
########################################
module "ptfm_nlb_https" {
  source  = "../../modules/terraform-aws-nlb"
  public_subnets = module.ptfm_vpc.public_subnets
  vpc_id = module.ptfm_vpc.vpc_id
  enable_https = var.enable_https
  ec2_instance_ids = [module.ptfm_bckend_ec2.instance_id, module.ptfm_bckend_ec2.instance_id, module.ptfm_bckend_ec2.instance_id]
  tags = local.tags
}


############################################
# task - Transit Gateway, VPC Attachments
############################################
module "task_tgw" {
  source = "../../modules/terraform-aws-tgw"
  name            = "task-tgw"
  description     = "task Transit Gateway "
  tags = local.tags
  vpc_attachments = {
  ptfmvpc = {
      vpc_id     = module.ptfm_vpc.vpc_id    # Platform VPC Id
      subnet_ids = module.ptfm_vpc.application_subnets # Platform Application Subnet Ids
      dns_support                                     = true
      ipv6_support                                    = false
      transit_gateway_default_route_table_association = true
      transit_gateway_default_route_table_propagation = true
    },
  }
 }

