resource "aws_security_group" "Intern_private_security_group" {
  //security group for instance in private subnet
  name   = "Intern_private_security_group"
  vpc_id = var.vpc_id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" // -1 == all
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "Intern_private_security_group"
    Environment = "Test"
    Owner       = "Julian"
    Service     = "Example"
  }
}

resource "aws_security_group" "Intern_public_security_group" {
  //security group for instance in public subnet
  //ingress all, egress all
  name   = "Intern_public_security_group"
  vpc_id = var.vpc_id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" // -1 == all
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "Intern_public_security_group"
    Environment = "Test"
    Owner       = "Julian"
    Service     = "Example"
  }
}


output "private_sg_id" {
  value = aws_security_group.Intern_private_security_group.id
}
output "public_sg_id" {
  value = aws_security_group.Intern_public_security_group.id
}
