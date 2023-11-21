terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 1.1.7"
}

// Definir um provedor
provider "aws" {
  region = var.location
  profile = var.profile
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc_wordpress" {
  source = "./vpc-wordpress"

  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  subnet_priv1_cidr = var.subnet_priv1_cidr
  subnet_priv2_cidr = var.subnet_priv2_cidr
  subnet_pub1_cidr = var.subnet_pub1_cidr
  subnet_pub2_cidr = var.subnet_pub2_cidr
  subnet_priv1_name = var.subnet_priv1_name
  subnet_priv2_name = var.subnet_priv2_name
  subnet_pub1_name = var.subnet_pub1_name
  subnet_pub2_name = var.subnet_pub2_name
}

module "ec2_wordpress" {
  source = "./ec2-wordpress"

  vpc_wordpress         = module.vpc_wordpress.vpc_wordpress
  subnet_wordpress      = module.vpc_wordpress.subnet_wordpress_public
  rds_db_username       = var.rds_db_username
  rds_db_password       = var.rds_db_password
  rds_db_host           = module.rds_wordpress.database_endpoint
  rds_db_port           = module.rds_wordpress.database_port
  wordpress_db_name     = var.db_name
  wordpress_db_username = var.rds_db_username
  wordpress_db_password = var.rds_db_password
}

module "rds_wordpress" {
  source = "./rds-wordpress"

  rds_db_username           = var.rds_db_username
  rds_db_password           = var.rds_db_password
  vpc_wordpress             = module.vpc_wordpress.vpc_wordpress
  subnets_wordpress_private = module.vpc_wordpress.subnets_wordpress_private
  wordpress_ec2_sg          = module.ec2_wordpress.wordpress_ec2_sg
  tags                      = merge(var.tags, { role = "database" })
}