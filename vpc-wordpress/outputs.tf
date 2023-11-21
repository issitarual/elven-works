output "vpc_wordpress" {
  value = aws_vpc.main
}

output "subnet_wordpress_public" {
  value = aws_subnet.publica1
}

output "subnets_wordpress_private" {
  value = [aws_subnet.privada1, aws_subnet.privada2]
}