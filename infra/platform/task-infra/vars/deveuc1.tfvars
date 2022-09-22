#####################
# AWS Providers Inputs
#######################
region = "us-east-1"


##############################
# task Platform Parameters
##############################
resource_vpc_name = "ptfm"

######################
# File Parameters
#######################
file_path = "files/"
db_ud_filename = "install_db.sh"
web_ud_filename = "install_webapp.sh"
app_bckend_ud_filename = "install_appbackend.sh"

######################
# Platform VPC Inputs
#######################
cidr = "192.168.64.0/21"
azs                   = ["us-east-1a", "us-east-1b"]
public_subnets        = ["192.168.64.0/25", "192.168.64.128/25"]
application_subnets   = ["192.168.65.0/25", "192.168.65.128/25"]
database_subnets      = ["192.168.66.0/25", "192.168.66.128/25"]
catalog_subnets       = ["192.168.68.0/25", "192.168.68.128/25"]

enable_nat_gateway = true
tags = {
    terraform   = "true"
    "nav:product-name" = "task Platform"
    "nav:costcenter" = "X.Y.Z"
  }

###########################
# Web Frontend EC2 Inputs
###########################
webfnd_instance_count = 1
webfnd_instance_type = "t2.micro"
ubuntu_webfnd_ami_name = ["Ubuntu Server 22.04 LTS (HVM), SSD Volume Type"]
ubuntu_webfnd_ami_owner = ["477658596461"]

################################
# Application Backend EC2 Inputs
################################
app_bckend_instance_count = 1
app_bckend_instance_type = "t2.micro"
ubuntu_bckend_ami_name = ["Ubuntu Server 22.04 LTS (HVM), SSD Volume Type"]
ubuntu_bckend_ami_owner = ["477658596461"]

##################
# db EC2 Inputs
##################
db_instance_count = 1
db_instance_type = "t2.micro"
ubuntu_db_ami_name = ["Ubuntu Server 22.04 LTS (HVM), SSD Volume Type"]
ubuntu_db_ami_owner = ["477658596461"]

