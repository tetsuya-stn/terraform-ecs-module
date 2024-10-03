terraform {
  required_version = "~> 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"

  assume_role {
    role_arn = "arn:aws:iam::448346652527:role/AdministratorAccessRole"
  }

  default_tags {
    tags = {
      ManagedBy = "Terraform"
      product   = "example-service"
    }
  }
}