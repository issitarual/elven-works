output "database_endpoint" {
  value       = aws_db_instance.wordpress_mysql.address
}

output "database_port" {
  value       = aws_db_instance.wordpress_mysql.port
}