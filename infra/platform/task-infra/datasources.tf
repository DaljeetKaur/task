

################################################
# IAM Instance Profile - Platform EC2 Instances
################################################

data "aws_iam_instance_profile" "ptfm_webfnd_ec2_profile" {
  name = "SSMInstanceProfile"
}

data "aws_iam_instance_profile" "ptfm_bckend_ec2_profile" {
  name = "SSMInstanceProfile"
}

data "aws_iam_instance_profile" "ptfm_db_ec2_profile" {
  name = "SSMInstanceProfile"
}

###################
# Ubuntu 18.04 AMI
###################
data "aws_ami" "ubuntu" {
  count = var.deploy_task1_account == false ? 1 : 0
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


################################################
# Ubuntu 18.04 AMI - nav Image (Web Frontend)
################################################
data "aws_ami" "ubuntu_nav_webfnd" {
  count = var.deploy_task1_account == true ? 1 : 0
  most_recent = true

  filter {
    name   = "name"
    values = var.ubuntu_webfnd_ami_name
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = var.ubuntu_webfnd_ami_owner # Canonical
}

#######################################################
# Ubuntu 18.04 AMI - nav Image (Application Backend)
#######################################################
data "aws_ami" "ubuntu_nav_bckend" {
  count = var.deploy_task1_account == true ? 1 : 0
  most_recent = true

  filter {
    name   = "name"
    values = var.ubuntu_bckend_ami_name
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = var.ubuntu_bckend_ami_owner # Canonical
}


#################################################
# Ubuntu 18.04 AMI - nav Image (db Server)
#################################################
data "aws_ami" "ubuntu_nav_db" {
  count = var.deploy_task1_account == true ? 1 : 0
  most_recent = true

  filter {
    name   = "name"
    values = var.ubuntu_db_ami_name
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = var.ubuntu_db_ami_owner # Canonical
}

###################################
# Route Tables - PTFM, MGMT VPC's
###################################
data "aws_route_table" "ptfm_default_rt" {
  vpc_id = module.ptfm_vpc.vpc_id
  filter {
    name   = "association.main"
    values = [true]
  }
}
