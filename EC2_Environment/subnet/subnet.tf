
resource "aws_subnet" "Intern_subnet" {
  //private subnet
  vpc_id                  = var.vpc_id
  availability_zone       = "ap-southeast-1a"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "false"
  tags = {
    Name        = "Intern_subnet"
    Environment = "Test"
    Owner       = "Julian"
    Project     = "Intern"
    Version     = "1.1"
  }
}

resource "aws_subnet" "Intern_public_subnet" {
  //public subnet
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name        = "Intern_public_subnet"
    Environment = "Test"
    Owner       = "Julian"
    Project     = "Intern"
    Version     = "1.1"
  }
}


output "public_subnet_id" {
  value = aws_subnet.Intern_public_subnet.id
}
output "private_subnet_id" {
  value = aws_subnet.Intern_subnet.id
}
