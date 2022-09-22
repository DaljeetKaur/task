locals {
    environment     = terraform.workspace
    fw_pub_rtb_name = upper(format("%s%s%s%s", local.environment, "_", var.resource_vpc_name, "_VPC_PUB_RT"))
    fw_pvt_rtb_name = upper(format("%s%s%s%s", local.environment, "_", var.resource_vpc_name, "_VPC_PVT_RT"))
    proj_pvt_rtb_name = upper(format("%s%s%s%s", local.environment, "_", var.proj_resource_vpc_name, "_VPC_PVT_RT"))
}

resource "aws_route" "fw_public_rt" {
  count                  = var.create_fw_vpc ? 1 : 0
  route_table_id         = data.aws_route_table.public.id
  destination_cidr_block = "192.168.0.0/16"
  vpc_endpoint_id        = var.vpce_endpoint_id

  timeouts {
    create = "5m"
  }
}



resource "aws_route" "fw_private_rt" {
  count                  = var.create_fw_vpc ? 1 : 0
  route_table_id         = data.aws_route_table.private.id
  destination_cidr_block = "192.168.0.0/16"
  transit_gateway_id     = data.aws_ec2_transit_gateway.task_tgw.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "default_rt" {
  count                  = var.create_fw_vpc ? 1 : 0
  route_table_id         = var.rtb_id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = var.vpce_endpoint_id

  timeouts {
    create = "5m"
  }
}

resource "aws_ec2_transit_gateway_route" "def_tgw_static_route" {
  count                          = var.create_fw_vpc ? 1 : 0
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = var.fw_tgw_attachment_id
  transit_gateway_route_table_id = var.def_tgw_associate_rtb_id
}


resource "aws_ec2_transit_gateway_route" "fw_tgw_static_route" {
  count                          = var.new_proj_vpc ? 1 : 0
  destination_cidr_block         = var.cidr 
  transit_gateway_attachment_id  = var.proj_tgw_attachment_id
  transit_gateway_route_table_id = data.aws_ec2_transit_gateway_route_table.fw_tgw_rtb.id
}

resource "aws_route" "transit_gateway" {
  count = var.private_rtb_update ? 1 : 0

  route_table_id         = data.aws_route_table.proj_private[0].id
  
  #2492
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = var.transit_gateway_id

  timeouts {
    create = "5m"
  }
}