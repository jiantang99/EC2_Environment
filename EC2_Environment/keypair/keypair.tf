resource "tls_private_key" "public_key1" {
  //creating public key for public subnet
  algorithm = "RSA"
}

resource "aws_key_pair" "public_key_pair" {
  // creating key pair using public key
  key_name   = "public_key_pair1"
  public_key = tls_private_key.public_key1.public_key_openssh
}

resource "local_file" "ssh_key" {
  // downloading key pair as pem file
  filename = "${aws_key_pair.public_key_pair.key_name}.pem"
  content  = tls_private_key.public_key1.private_key_pem
}

resource "tls_private_key" "public_key2" {
  //creating public key private subnet
  algorithm = "RSA"
}

resource "aws_key_pair" "private_key_pair" {
  // creating key pair using public key
  key_name   = "private_key_pair1"
  public_key = tls_private_key.public_key2.public_key_openssh
}

resource "local_file" "ssh_key2" {
  // downloading key pair as pem file
  filename = "${aws_key_pair.private_key_pair.key_name}.pem"
  content  = tls_private_key.public_key2.private_key_pem
}