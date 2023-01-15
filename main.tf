#---------------------------------------------
# Terraform configration
#---------------------------------------------
terraform {
  required_version = ">=1.3.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
  backend "s3" {}
}

#---------------------------------------------
# Provider
#---------------------------------------------
provider "aws" {
  profile = "default"
  region  = "ap-northeast-1"
}

