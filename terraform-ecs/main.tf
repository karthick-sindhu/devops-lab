terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }
  required_version = ">= 1.5"
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Service = var.service_name
    }
  }
}

variable "region" {
  default = "us-east-1"
}

variable "service_name" {
  default = "devops-lab"
}