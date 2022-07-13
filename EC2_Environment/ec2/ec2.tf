
resource "aws_instance" "Intern_server" {
  //ubuntu server 
  ami                         = "ami-055d15d9cfddf7bd3"
  instance_type               = "t2.micro" //free tier only has 1GB memory
  availability_zone           = "ap-southeast-1a"
  key_name                    = "private_key_pair1"
  vpc_security_group_ids      = [var.private_sg]
  subnet_id                   = var.private_subnet
  associate_public_ip_address = false
  tags = {
    Name        = "Intern_server"
    Environment = "Test"
    Owner       = "Julian"
    Project     = "Intern"
    Version     = "1.1"
  }
}

resource "aws_instance" "Intern_jumpbox_server" {
  //linux base server 
  //username = Administrator
  //encrypted version of password will be downloaded
  ami                         = "ami-0801a1e12f4a9ccc0"
  instance_type               = "t2.micro"
  availability_zone           = "ap-southeast-1a"
  key_name                    = "public_key_pair1"
  vpc_security_group_ids      = [var.public_sg]
  subnet_id                   = var.public_subnet
  associate_public_ip_address = true
  tags = {
    Name        = "Intern_jumpbox_server"
    Environment = "Test"
    Owner       = "Julian"
    Project     = "Intern"
    Version     = "1.1"
  }
}
