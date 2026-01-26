terraform {
  required_providers {
    # https://search.opentofu.org/provider/hashicorp/aws/latest
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.16.1"
    }
    # https://search.opentofu.org/provider/hashicorp/random/latest
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
  backend "s3" {
    bucket = "architectf"
    key    = "dotfiles"
    region = "us-east-1"
    dynamodb_table = "architectf-timeline"
  }
  required_version = "~> 1.1"
}

provider "aws" {
  region = "us-east-1"
}
