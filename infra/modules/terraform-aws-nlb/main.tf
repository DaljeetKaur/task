locals {
  target_grp_names = ["DEV-PTFM-BCKEND-GRP-8081", "DEV-PTFM-BCKEND-GRP-8082",
   "DEV-PTFM-BCKEND-GRP-8090"]
  listener_ports = ["8081", "8082", "8090"]
  ec2_ports = ["8081", "8082", "8090"] 
}


resource "aws_lb" "task_ptfm_lb" {
  name               = var.nlb_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  subnets            = var.public_subnets

  enable_deletion_protection = var.enable_deletion_protection

  tags = var.tags
}

resource "aws_lb_target_group" "task_ptfm_lb_target_grp" {
  count    = length(local.target_grp_names)
  name     = local.target_grp_names[count.index]
  port     = local.ec2_ports[count.index]
  protocol = var.tcp_protocol
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "ec2_attachment" {
  count    = length(local.target_grp_names) 
  target_group_arn = aws_lb_target_group.task_ptfm_lb_target_grp[count.index].arn
  target_id        = var.ec2_instance_ids[count.index]
  port             = local.ec2_ports[count.index]
}


resource "aws_lb_listener" "task_ptfm_listener_https" {
  count    = length(local.target_grp_names)   
  load_balancer_arn = aws_lb.task_ptfm_lb.arn
  port              = local.listener_ports[count.index]
  protocol          = var.tcp_protocol
  default_action {
    type             = var.type
    target_group_arn = aws_lb_target_group.task_ptfm_lb_target_grp[count.index].arn
  }
}

