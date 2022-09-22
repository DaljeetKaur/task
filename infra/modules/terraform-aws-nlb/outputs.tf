output "network_lb_arn" {
  description = "The ARN of the Network Load Balancer"
  value       = aws_lb.task_ptfm_lb.arn
}

output "network_lb_dns_name" {
  description = "The Network Load Balancer DNS Name"
  value       = aws_lb.task_ptfm_lb.dns_name
}

