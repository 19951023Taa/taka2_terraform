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

module "pub_subnet_A" {
 source = "./module/subnet"
  
  vpc_id = var.vpc_id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"
  project = var.project
  env = var.env
  subnetname = "public-A"
}

module "pub_subnet_C" {
 source = "./module/subnet"
  
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-northeast-1c"
  project = var.project
  env = var.env
  subnetname = "public-C"
}