resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "${var.project}-${var.env}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-${var.env}-igw"
  }
}

# public subnet 
module "pub_subnet_A" {
 source = "./module/subnet"
  
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"
  env = var.env
  subnetname = "public-A"
}

module "pub_subnet_C" {
 source = "./module/subnet"
  
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-northeast-1c"
  env = var.env
  subnetname = "public-C"
}

# plivate subnet 
module "pulivate_subnet_A" {
  source = "./module/subnet"

  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-northeast-1a"
  env = var.env
  subnetname = "private-A"
}

module "pulivate_subnet_C" {
  source = "./module/subnet"

  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-northeast-1c"
  env = var.env
  subnetname = "private-C"
}
















