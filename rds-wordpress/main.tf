resource "aws_security_group" "mysql_rds" {
  name        = "mysql_rds"
  vpc_id      = var.vpc_wordpress.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.wordpress_ec2_sg.id]
  }

  tags = var.tags
}

resource "aws_db_subnet_group" "mysql" {
  name        = "mysql_subnet_group"
  subnet_ids = [for subnet in var.subnets_wordpress_private : subnet.id]
}

resource "aws_db_instance" "wordpress_mysql" {
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "8.0.35"
  instance_class         = "db.t2.micro"
  name                   = var.rds_db_name
  username               = var.rds_db_username
  password               = var.rds_db_password
  db_subnet_group_name   = aws_db_subnet_group.mysql.id
  vpc_security_group_ids = [aws_security_group.mysql_rds.id]
  skip_final_snapshot    = true
}
