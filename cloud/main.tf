terraform {
  required_providers {
    # https://search.opentofu.org/provider/hashicorp/aws/latest
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.70.0"
    }
    # https://search.opentofu.org/provider/hashicorp/random/latest
    random = {
      source  = "hashicorp/random"
      version = "3.9.1"
    }
  }
  backend "s3" {
    bucket         = "architectf"
    key            = "dotfiles"
    region         = "us-east-1"
    dynamodb_table = "architectf-timeline"
  }
  required_version = "~> 1.1"
}

provider "aws" {
  region = "us-east-1"
}
