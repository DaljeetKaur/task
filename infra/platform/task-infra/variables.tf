variable "region" {
  description = "The `Region Name where AWS resources will be deployed"
  type        = string
}

variable "resource_vpc_name" {
  description = "The VPC short name in the AWS resources will be deployed"
  type        = string
}


variable "profile" {
  description = "AWS profile name as set in the shared credentials file."
  type        = string
  default = ""
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "0.0.0.0/0"
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = false
}

variable "application_subnets" {
  description = "A list of application subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "database_subnets" {
  description = "A list of database subnets inside the VPC"
  type        = list(string)
  default     = []
}


variable "catalog_subnets" {
  description = "A list of catalog subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "task1_cidr_block" {
  description = "Cidr block of the TASK Platform"
  type        = string
  default = "192.168.64.0/18"
}


variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "webfnd_instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 1
}


variable "webfnd_instance_type" {
  description = "The type of instance to start"
  type        = string
}


variable "app_bckend_instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 1
}


variable "app_bckend_instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "db_instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 1
}

variable "db_instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "create_iam_instance_profile" {
  description = "Whether to create IAM Instance profile"
  type        = bool
  default     = false
}

variable "webfnd_ec2_role_name" {
  description = "The IAM Role name to be assigned to the EC2"
  type        = string
}

variable "bckend_ec2_role_name" {
  description = "The IAM Role name to be assigned to the EC2"
  type        = string
}

variable "db_ec2_role_name" {
  description = "The IAM Role name to be assigned to the EC2"
  type        = string
}

variable "file_path" {
  description = "The file path of the install scripts"
  type        = string
}

variable "db_ud_filename" {
  description = "The db user data script file name"
  type        = string
}

variable "web_ud_filename" {
  description = "The Web Front end user data script file name"
  type        = string
}

variable "app_bckend_ud_filename" {
  description = "The Web Front end user data script file name"
  type        = string
}

variable "webfnd_private_ips" {
  description = "A list of private IP address to associate with the instance in a VPC. Should match the number of instances."
  type        = list(string)
  default     = []
}

variable "bckend_private_ips" {
  description = "A list of private IP address to associate with the instance in a VPC. Should match the number of instances."
  type        = list(string)
  default     = []
}

variable "db_private_ips" {
  description = "A list of private IP address to associate with the instance in a VPC. Should match the number of instances."
  type        = list(string)
  default     = []
}

variable "enable_https" {
  description = "Controls if HTTPS needs to be enabled"
  type        = bool
  default     = true
}

variable "deploy_task1_account" {
  description = "Controls if deployment is in HCL or task1 AWS account"
  type        = bool
  default     = true
}

variable "task_directory_id" {
  description = "task Active Directory ID"
  type        = string
//  default = "d-9167385423"
}


variable "mgmt_vpc_cidr" {
  description = "Cidr block of the Management VPC"
  type        = string
  default = "192.168.80.0/21"
}

variable "task_cidr_block" {
  description = "Cidr block of the task Platform"
  type        = string
  default = "192.168.64.0/18"
}

variable "adjoin_username" {
  description = "AD Join username"
  type        = string
  sensitive = true
}

variable "adjoin_password" {
  description = "AD Join Password"
  type        = string
  sensitive = true
}

variable "task_api_gw_domain_url" {
  description = "task API Gateway domain url"
  type        = string
  default = ""
}

variable "task_app_domain_url" {
  description = "task App domain url"
  type        = string
  default = ""
}

variable "nav_lambda_uri" {
  description = "nav Lambda URI"
  type        = string
  default = ""
}

variable "nav_lambda_authorizer_uri" {
  description = "nav Lambda Authorizer URI"
  type        = string
  default = ""
}

variable "api_gw_stage_name" {
  description = "task API Gateway stage Name"
  type        = string
  default     = ""
}

variable "task_api_gw_domain_name" {
  description = "API gateway domain name"
  type        = string
  default     = ""
}

//db RDS PostgreSQL variables
variable "db_db_engine_version" {
  description = "The engine version to use"
  type        = string
}

variable "db_db_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "db_db_name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = ""
  sensitive = true
}

variable "db_db_username" {
  description = "Username for the master DB user"
  type        = string
  sensitive = true
}

variable "db_db_password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
  type        = string
  sensitive = true
}


variable "db_db_az" {
  description = "The Availability Zone of the RDS instance"
  type        = string
  default     = ""
}

variable "db_db_publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
}

variable "db_db_maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string
}
variable "db_db_backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 1
}

variable "db_db_deletion_protection" {
  description = "The database can't be deleted when this value is set to true."
  type        = bool
  default     = false
}

variable "db_db_backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
}

variable "db_db_port" {
  description = "The port on which the DB accepts connections"
  type        = string
}

variable "db_db_identifier" {
  description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier"
  type        = string
}

variable "db_db_allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = string
}

variable "db_db_storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type        = bool
  default     = false
}

variable "db_db_engine" {
  description = "The database engine to use"
  type        = string
}

variable "db_multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}
variable "ubuntu_webfnd_ami_name" {
  description = "Ubuntu webfnd ami name"
  type        = list(string)
  default     = []
}

variable "ubuntu_webfnd_ami_owner" {
  description = "Ubuntu webfnd ami owner"
  type        = list(string)
  default     = []
}
variable "ubuntu_bckend_ami_name" {
  description = "ubuntu backend ami name"
  type        = list(string)
  default     = []
}

variable "ubuntu_bckend_ami_owner" {
  description = "ubuntu db ami owner"
  type        = list(string)
  default     = []
}
variable "ubuntu_db_ami_name" {
  description = "ubuntu db ami name"
  type        = list(string)
  default     = []
}

variable "ubuntu_db_ami_owner" {
  description = "ubuntu db ami owner"
  type        = list(string)
  default     = []
}

variable "x_nav_tenant" {
  description = "nav Tenant"
  type        = string
 }
variable "okta_config" {
  description = "Okta Config"
  type        = string
 }

#db Team Request starts
variable "create_db_ec2_role_policies" {
  description = "The Flag to create db ec2 role"
  type        = bool
  default     = false
}
#db Team Request ends

#IAM Roles for backend and frontend ec2 instance starts
variable "create_backend_ec2_role_policies" {
  description = "The Flag to create db ec2 role"
  type        = bool
  default     = false
}

variable "create_webfnd_ec2_role_policies" {
  description = "The Flag to create db ec2 role"
  type        = bool
  default     = false
}
#IAM Roles for backend and frontend ec2 instance ends

#Cloudfront changes starts
variable "prefix" {
  type    = string
  default = ""
}

variable "domainname" {
  type    = string
  default = ""
}


variable "routename" {
  type    = string
  default = ""
}


variable "env" {
  type    = string
  default = ""
}

variable "waf_global_name" {
  type    = string
  default = ""
}

variable "app_region" {
  description = "App region"
  type        = string
  default     = "eu-central-1"
}
#Cloudfront changes ends