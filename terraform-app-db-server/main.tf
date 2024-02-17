provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Env     = var.environment
      Region  = var.region
      Service = var.service_name
    }
  }
}

variable "region" {
}

variable "service_name" {
  default = "myapp"
}

variable "service_vpc_name" {
}

variable "service_db" {
}

variable "image_id" {
}

variable "instance_type" {
}

variable "environment" {

}