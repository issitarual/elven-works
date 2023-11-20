output "public_ip" {
  value = aws_instance.wordpress-challenge-server-1.public_ip
}

output "private_ip" {
  value = aws_instance.wordpress-challenge-server-1.private_ip
}

output "wordpress_ec2_sg" {
  value = aws_security_group.allow_ssh
}