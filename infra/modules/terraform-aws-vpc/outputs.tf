output "vpc_id" {
  description = "The ID of the VPC"
  value       = concat(aws_vpc.this.*.id, [""])[0]
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = concat(aws_vpc.this.*.arn, [""])[0]
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public.*.id
}

output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.public.*.arn
}

output "application_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.application.*.id
}

output "catalog_subnets" {
  description = "List of IDs of catalog subnets"
  value       = aws_subnet.catalog.*.id
}
output "database_subnet_group" {
  description = "ID of database subnet group"
  value       = concat(aws_db_subnet_group.database.*.id, [""])[0]
}


output "def_rtb_id" {
  description = "VPC default route table ID"
  value       = concat(aws_vpc.this.*.default_route_table_id, [""])[0]
}
