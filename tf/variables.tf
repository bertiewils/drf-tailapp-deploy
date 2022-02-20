variable "aws_region" {
  description = "AWS resource region"
  type        = string
  default     = "eu-west-2"
}

variable "db_name" {
  description = "RDS DB name"
  type        = string
  sensitive   = true
}

variable "db_username" {
  description = "RDS username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "RDS password"
  type        = string
  sensitive   = true
}

variable "vpc_id" {}
