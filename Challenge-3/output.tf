output "aws_instances_public_ips" {
  value       = [aws_eip.citadel_eip.public_ip]
  description = "Public IP addresses of the created EC2 instance"
}
