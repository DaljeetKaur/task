variable "create_fw_vpc" {
  description = "Controls the association of project vpc to route table or transit gateway route table"
  type        = bool
  default = false
}

variable "new_proj_vpc" {
  description = "Controls the association of project vpc to route table or transit gateway route table"
  type        = bool
  default = false
}

variable "vpc_id" {
  description = "The VPC ID of the Firewall"
  type        = string
  default = ""
}

variable "fw_arn" {
  description = "The arn of firewall"
  type       = string
  default = ""
}

variable "rtb_id" {
  description = "The vpc route table id"
  type       = string
  default = ""
}

variable "fw_tgw_attachment_id" {
  description = "Firewall vpc attachment id"
  type       = string
  default = ""
}

variable "proj_tgw_attachment_id" {
  description = "Project vpc attachment id"
  type       = string
  default = ""
}

variable "def_tgw_associate_rtb_id" {
  description = "The default tgw route table id"
  type       = string
  default = ""
}

variable "vpce_endpoint_id" {
  description = "The firewall gateway load balancer id"
  type       = string
  default = ""
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "0.0.0.0/0"
}

variable "resource_vpc_name" {
  description = "The VPC short name in the AWS resources will be deployed"
  type        = string
  default     = ""
}

#2492
variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

#2492
variable "create_igw" {
  description = "Controls if an Internet Gateway is created for public subnets and the related routes that connect them."
  type        = bool
  default     = true
}

#2492
variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

#2492
variable "private_rtb_update" {
  description = "Controls the update for project private table"
  type        = bool
  default     = false
}

#2492
variable "transit_gateway_id" {
  description = "Transit Gateway Id"
  type        = string
  default     = ""
}

variable "proj_resource_vpc_name" {
  description = "The project uid value"
  type        = string
  default     = ""
}