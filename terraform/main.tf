variable "aws_region" {}
variable "bucket_name" {}

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
  region = var.aws_region

  default_tags {
    tags = {
      managed-by = "terraform"
    }
  }
}

resource "aws_s3_bucket" "s3_bucket_1" {
  bucket = var.bucket_name
}

