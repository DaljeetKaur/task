output "instance_id" {
  description = "Instance Id of the EC2"
  value       = concat(aws_instance.this.*.id, [""])[0]
}