# Create security group
resource "aws_security_group" "allow_ssh" {
  name        = "wordpress-challenge"
  description = "Allow ssh inbound traffic"
  vpc_id      = var.vpc_wordpress.id

  lifecycle {
    create_before_destroy = true
  }

    ingress {
    description      = "prometheus"
    from_port        = 9090
    to_port          = 9090
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "grafana"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "prometheus Node Exporter"
    from_port        = 9100
    to_port          = 9100
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
    ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_SSH"
  }
}

# Linux AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Linux server 1 with Wordpress
resource "aws_instance" "wordpress-challenge-server-1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = "wordpress-challenge"
  subnet_id = var.subnet_wordpress.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  associate_public_ip_address = true
  monitoring                  = true
  user_data = <<-EOF
    #!/bin/bash
    
    sudo apt update && sudo apt install ansible curl git nano unzip -y
    cd /tmp

    git clone https://github.com/issitarual/elven-works.git

    # delete the default values
    rm ./elven-works/ansible/wordpress-challenge/roles/mysql/defaults/main.yml

    tee -a ./elven-works/ansible/wordpress-challenge/roles/mysql/defaults/main.yml << END
    ---
    rds_db_host: "${var.rds_db_host}"
    rds_db_port: "${var.rds_db_port}"
    rds_db_username: "${var.rds_db_username}"
    rds_db_password: "${var.rds_db_password}"
    wordpress_db_name: "${var.wordpress_db_name}"
    wordpress_db_username: "${var.wordpress_db_username}"
    wordpress_db_password: "${var.wordpress_db_password}"
    END

    cp ./elven-works/ansible/wordpress-challenge/roles/mysql/defaults/main.yml ./elven-works/ansible/wordpress-challenge/roles/wordpress/defaults/main.yml
    sudo ansible-playbook ./elven-works/ansible/wordpress-challenge/wordpress.yml
    EOF
  tags = {
    Name = "wordpress_challenge-server-1"
  }
}

# Linux server 2
resource "aws_instance" "wordpress-challenge-server-2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = "wordpress-challenge"
  subnet_id = var.subnet_wordpress.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  associate_public_ip_address = true

  tags = {
    Name = "wordpress_challenge-server-2"
  }
}

# # Prometheus
# resource "aws_instance" "prometheus" {
#   ami               = "ami-0f5ee92e2d63afc18"
#   instance_type     = "t2.nano"
#   availability_zone = "us-east-1"
#   user_data = templatefile("${path.module}/cloud_prometheus.conf", {
#     hostname           = "Hostname"
#     # config_bucket_name = var.config_bucket_name
#     password           = "12345"
#     # letsencrypt_email  = var.letsencrypt_email
#   })
#   security_groups      = [aws_security_group.allow_ssh]

#   lifecycle {
#     ignore_changes = [ami]
#   }

#   tags = {
#     Name = "monitoring-prometheus"
#   }

# }

# # Grafana
# resource "aws_instance" "instance" {
#   ami               = "ami-0f5ee92e2d63afc18"
#   instance_type     = "t2.nano"
#   availability_zone = "us-east-1"
#   user_data = templatefile("${path.module}/cloud_grafana.conf", {
#     hostname           = "Hostname"
#     # config_bucket_name = var.config_bucket_name
#     password           = "12345"
#     # letsencrypt_email  = var.letsencrypt_email
#   })
#   security_groups      = [aws_security_group.allow_ssh]

#   lifecycle {
#     ignore_changes = [ami]
#   }

#   tags = {
#     Name = "monitoring-grafana"
#   }
# }