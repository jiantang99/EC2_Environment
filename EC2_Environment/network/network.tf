
resource "aws_network_acl" "Intern_NACL" {
  vpc_id = var.vpc_id

  egress {
    rule_no    = 100
    protocol   = -1
    action     = "allow"
    cidr_block = "10.194.229.160/28"
    from_port  = 0
    to_port    = 0
  }

  egress {
    rule_no    = 200
    protocol   = -1
    action     = "allow"
    cidr_block = "10.194.229.128/28"
    from_port  = 0
    to_port    = 0
  }

  egress {
    rule_no    = 300
    protocol   = -1
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    rule_no         = 400
    protocol        = -1
    action          = "allow"
    ipv6_cidr_block = "::/0"
    from_port       = 0
    to_port         = 0
  }

  /*egress {
    rule_no    = "*"
    protocol   = -1
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  } */

  ingress {
    rule_no    = 100
    protocol   = -1
    action     = "allow"
    cidr_block = "10.194.229.160/28"
    from_port  = 0
    to_port    = 0
  }
  ingress {
    rule_no    = 200
    protocol   = -1
    action     = "allow"
    cidr_block = "10.194.229.128/28"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name        = "Intern_NACL"
    Environment = "Test"
    Owner       = "Julian"
    Project     = "Intern"
    Version     = "1.1"
  }
}



// internet gateway
resource "aws_internet_gateway" "Intern_igw" {
  vpc_id = var.vpc_id

  tags = {
    Name        = "Intern_igw"
    Environment = "Test"
    Owner       = "Julian"
    Project     = "Intern"
    Version     = "1.1"
  }
}

// route table for public subnet
resource "aws_route_table" "Intern_public_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Intern_igw.id
  }

  tags = {
    Name        = "Intern_public_route_table"
    Environment = "Test"
    Owner       = "Julian"
    Project     = "Intern"
    Version     = "1.1"
  }
}

// route table association for public route table and public subnet
resource "aws_route_table_association" "Intern_public_route_association" {
  subnet_id      = var.public_subnet
  route_table_id = aws_route_table.Intern_public_route_table.id
}

// elastic ip for nat gateway
resource "aws_eip" "Intern_nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.Intern_igw]
  tags = {
    Name        = "Intern_nat_eip"
    Environment = "Test"
    Owner       = "Julian"
    Project     = "Intern"
    Version     = "1.1"
  }
}

// nat gateway for VPC
resource "aws_nat_gateway" "Intern_nat_gateway" {
  allocation_id = aws_eip.Intern_nat_eip.id
  subnet_id     = var.public_subnet

  tags = {
    Name        = "Intern_nat_gateway"
    Environment = "Test"
    Owner       = "Julian"
    Project     = "Intern"
    Version     = "1.1"
  }
}

// route table for private subnet
resource "aws_route_table" "Intern_private_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.Intern_nat_gateway.id // nat gateway id
  }

  tags = {
    Name        = "Intern_private_route_table"
    Environment = "Test"
    Owner       = "Julian"
    Project     = "Intern"
    Version     = "1.1"
  }
}

// route table association for private route table and private subnet
resource "aws_route_table_association" "Intern_private_route_association" {
  subnet_id      = var.private_subnet //private subnet id
  route_table_id = aws_route_table.Intern_private_route_table.id
}
