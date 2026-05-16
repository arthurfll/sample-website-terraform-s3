terraform {
  required_version = ">= 1.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.58.0"
    }
  }
}


provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""

  default_tags {
    tags = {
      managed-by = "terraform"

    }
  }
}



