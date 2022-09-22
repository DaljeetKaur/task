data "aws_ec2_transit_gateway" "task_tgw" {
  filter {
    name   = "tag:Name"
    values = ["task-tgw"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }  
}


data "aws_ec2_transit_gateway_route_table" "fw_tgw_rtb" {
  filter {
    name   = "default-association-route-table"
    values = ["false"]
  }
}

####################################################
# Data Source - Public Route Table - N/W Firewall
####################################################
data "aws_route_table" "public" {
  filter {
    name   = "tag:Name"
    values = [local.fw_pub_rtb_name]
  }
}


data "aws_route_table" "private" {
  filter {
    name   = "tag:Name"
    values = [local.fw_pvt_rtb_name]
  }
}

data "aws_route_table" "proj_private" {
  count = var.private_rtb_update == true ? 1 : 0
  filter {
    name   = "tag:Name"
    values = [local.proj_pvt_rtb_name]
  }
}