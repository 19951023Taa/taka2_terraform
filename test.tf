resource "aws_vpc" "vpc-test" {
  count = var.env == "pd" ? 1 : 0
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project}-${var.env}-vpc-test"
  }
}

resource "aws_internet_gateway" "igw-test" {
  vpc_id = aws_vpc.vpc-test[0].id

  tags = {
    Name = "${var.project}-${var.env}-igw-test"
  }
}