// Criar VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name,
    Terraformed = "true"
  }
}

//Criar Subnets
resource "aws_subnet" "publica1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_pub1_cidr

  tags = {
    Name = var.subnet_pub1_name
    Terraformed = "true"
  }
  depends_on = [
    aws_vpc.main
  ]
}
resource "aws_subnet" "publica2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_pub2_cidr

  tags = {
    Name = var.subnet_pub2_name
    Terraformed = "true"
  }
  depends_on = [
    aws_vpc.main
  ]
}
resource "aws_subnet" "privada1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_priv1_cidr

  tags = {
    Name = var.subnet_priv1_name
    Terraformed = "true"
  }
  depends_on = [
    aws_vpc.main
  ]
}
resource "aws_subnet" "privada2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_priv2_cidr

  tags = {
    Name = var.subnet_priv2_name
    Terraformed = "true"
  }
  depends_on = [
    aws_vpc.main
  ]
}

// Criar o Internet Gateway
resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "iac-internet-gw",
    terraformed = "true"
  }
  depends_on = [
    aws_vpc.main
  ]
}

// Cria os IPs dos Nat Gateways
resource "aws_eip" "ip-nat-gateway-1" {
  vpc = true
  tags = {
    terraformed = "true"
  }
  depends_on = [
    aws_vpc.main,
    aws_internet_gateway.internet-gw
  ]
}

resource "aws_eip" "ip-nat-gateway-2" {
  vpc = true
  tags = {
    terraformed = "true"
  }
  depends_on = [
    aws_vpc.main,
    aws_internet_gateway.internet-gw
  ]
}

// Criar Nat Gateways
resource "aws_nat_gateway" "nat-gateway-1" {
  allocation_id = aws_eip.ip-nat-gateway-1.id
  subnet_id = aws_subnet.publica1.id

  tags = {
    Name = "iac-nat-gw-1",
    terraformed = "true"
  }
  depends_on = [
    aws_vpc.main,
    aws_internet_gateway.internet-gw,
    aws_eip.ip-nat-gateway-1
  ]
}

resource "aws_nat_gateway" "nat-gateway-2" {
  allocation_id = aws_eip.ip-nat-gateway-2.id
  subnet_id = aws_subnet.publica2.id

  tags = {
    Name = "iac-nat-gw-1",
    terraformed = "true"
  }
  depends_on = [
    aws_vpc.main,
    aws_internet_gateway.internet-gw,
    aws_eip.ip-nat-gateway-2
  ]
}

// Criar Tabelas de Roteamento
resource "aws_route_table" "publica" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gw.id
  }
  tags = {
    Name = "iac-rtb-publica",
    terraformed = "true"
  }
  depends_on = [
    aws_vpc.main,
    aws_internet_gateway.internet-gw
  ]
}

resource "aws_route_table" "privada1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway-1.id
  }
  tags = {
    Name = "iac-rtb-privada1",
    terraformed = "true"
  }
  depends_on = [
    aws_vpc.main,
    aws_internet_gateway.internet-gw
  ]
}
resource "aws_route_table" "privada2" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway-2.id
  }
  tags = {
    Name = "iac-rtb-privada2",
    terraformed = "true"
  }
  depends_on = [
    aws_vpc.main,
    aws_internet_gateway.internet-gw
  ]
}

resource "aws_route_table_association" "publica1" {
  subnet_id      = aws_subnet.publica1.id
  route_table_id = aws_route_table.publica.id
}
resource "aws_route_table_association" "publica2" {
  subnet_id      = aws_subnet.publica2.id
  route_table_id = aws_route_table.publica.id
}
resource "aws_route_table_association" "privada1" {
  subnet_id      = aws_subnet.privada1.id
  route_table_id = aws_route_table.privada1.id
}
resource "aws_route_table_association" "privada2" {
  subnet_id      = aws_subnet.privada2.id
  route_table_id = aws_route_table.privada2.id
}
