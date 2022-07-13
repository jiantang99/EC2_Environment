
resource "aws_vpc" "Intern_VPC" {
  //creating VPC
  cidr_block = "10.0.0.0/16"
  tags = {
    Name        = "Intern_VPC"
    Environment = "Test"
    Owner       = "Julian"
    Project     = "Intern"
    Version     = "1.1"
  }
}

output "vpc_id" {
  value = aws_vpc.Intern_VPC.id
}
