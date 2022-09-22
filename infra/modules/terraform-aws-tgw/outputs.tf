output "tgw_id" {
  description = "EC2 Transit Gateway identifier"
  value       = element(concat(aws_ec2_transit_gateway.task_tgw.*.id, [""]), 0)
}
