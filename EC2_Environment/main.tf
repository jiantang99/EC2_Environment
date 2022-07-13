terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0.0"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  region     = "ap-southeast-1"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

module "vpc" {
  source = "./vpc"
}

module "subnet" {
  source = "./subnet"
  vpc_id = module.vpc.vpc_id
}

module "keypair" {
  source = "./keypair"
}

module "ec2" {
  source         = "./ec2"
  private_sg     = module.security_group.private_sg_id
  public_sg      = module.security_group.public_sg_id
  public_subnet  = module.subnet.public_subnet_id
  private_subnet = module.subnet.private_subnet_id
}
module "security_group" {
  source = "./sg"
  vpc_id = module.vpc.vpc_id
}
module "network" {
  source         = "./network"
  vpc_id         = module.vpc.vpc_id
  public_subnet  = module.subnet.public_subnet_id
  private_subnet = module.subnet.private_subnet_id
}


