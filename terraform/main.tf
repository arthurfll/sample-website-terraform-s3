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
  region = "us-east-1"

  default_tags {
    tags = {
      managed-by = "terraform"
    }
  }
}

resource "aws_s3_bucket" "s3_bucket_1" {
  bucket = "{{BUCKET_NAME}}"
}

resource "aws_s3_bucket_public_access_block" "s3_bucket_1" {
  bucket = aws_s3_bucket.s3_bucket_1.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "s3_bucket_1" {
  bucket = aws_s3_bucket.s3_bucket_1.id

  depends_on = [aws_s3_bucket_public_access_block.s3_bucket_1]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.s3_bucket_1.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "s3_bucket_1" {
  bucket = aws_s3_bucket.s3_bucket_1.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

