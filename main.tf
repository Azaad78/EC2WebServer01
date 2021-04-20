terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.36.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-1"
}

# resource "aws_s3_bucket" "mysolotestbucket" {
#   bucket = "${var.region}-${var.bucketname}"
#   acl    = "private"
# }