output "ec2_dns" {
  description = "EC2 instance hostname"
  value = aws_instance.apphost1.public_dns
}

output "elb_dns" {
  description = "ELB hostname"
  value = aws_lb.apphost-elb.dns_name
}

output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.appdb.address
  sensitive   = true
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.appdb.port
  sensitive   = true
}
