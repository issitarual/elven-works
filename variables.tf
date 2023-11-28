# VPC variables
variable "vpc_cidr" {
  type = string
  default = "10.132.0.0/16"
}
variable "vpc_name" {
  type = string
  default = "vpc-wordpress"
}
variable "subnet_priv1_cidr" {
  type = string
  default = "10.132.3.0/24"
}
variable "subnet_priv2_cidr" {
  type = string
  default = "10.132.2.0/24"
}
variable "subnet_pub1_cidr" {
  type = string
  default = "10.132.1.0/24"
}
variable "subnet_pub2_cidr" {
  type = string
  default = "10.132.0.0/24"
}

variable "subnet_priv1_name" {
  type = string
  default = "priv1"
}
variable "subnet_priv2_name" {
  type = string
  default = "priv2"
}
variable "subnet_pub1_name" {
  type = string
  default = "pub1"
}
variable "subnet_pub2_name" {
  type = string
  default = "pub2"
}

# EC2 variables
variable "location" {
  type = string
  default = "us-east-1"
}

variable "profile" {
  type = string
  default = "terraform-elven"
}

variable "access_key" {
  type = string
  default = "changeme"
  sensitive = true
}

variable "secret_key" {
  type = string
  default = "changeme"
  sensitive = true
}

# RDS variables
variable "rds_db_username" {
  type        = string
  default     = "wordpress"
  sensitive   = true
}
variable "rds_db_name" {
  type        = string
  default     = "wordpress"
  sensitive   = true
}

variable "rds_db_password" {
  type        = string
  default     = "12345678"
  sensitive   = true
}

variable "wordpress_db_name" {
  type        = string
  default     = "wordpress"
  sensitive   = true
}
variable "tags" {
  type        = map(string)
  default = {}
}
