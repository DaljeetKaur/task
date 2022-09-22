variable "internal" {
  description = "Controls if load balancer is internal or internet facing"
  type        = bool
  default     = false
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
}

variable "load_balancer_type" {
  description = "Specifies the load balancer type"
  type        = string
  default     = "network"
}

variable "nlb_name" {
  description = "Name of the Load Balancer"
  type        = string
  default = "task-platform-loadbalancer"
}

variable "security_groups" {
  description = "A list of security groups for Applicaiton Load Balancer "
  type        = list(string)
  default = []
}

variable "enable_deletion_protection" {
  description = "Controls if load balancer is internal or internet facing"
  type        = bool
  default     = false
}

variable "enable_https" {
  description = "Controls if HTTPS needs to be enabled"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags for the Load Balancer"
  type        = map(string)
  default     = {}
}


variable "http_protocol" {
  description = "The protocol for the ALB target group"
  type        = string
  default     = "HTTP"
}

variable "tcp_protocol" {
  description = "The protocol for the Load Balancer target group"
  type        = string
  default     = "TCP"
}


variable "https_protocol" {
  description = "The protocol for the ALB target group"
  type        = string
  default     = "HTTPS"
}

variable "ssl_policy" {
  description = "The dafault SSL policy"
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
}


variable "vpc_id" {
  description = "The VPC ID of the ALB target group"
  type        = string
}

variable "type" {
  description = "The type of action in LB Listener"
  type        = string
  default = "forward"
}

variable "ec2_instance_ids" {
  description = "A list of EC2 Instance Ids"
  type        = list(string)
}

variable "certificate_arn" {
  description = "The task application TLS certificate ARN"
  type        = string
  default = ""
}


