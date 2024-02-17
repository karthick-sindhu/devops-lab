locals {
  availability_zones = {
    "ap-northeast-1" = "ap-northeast-1a,ap-northeast-1c,ap-northeast-1d"
    "us-east-1"      = "us-east-1a,us-east-1c"
  }
}


data "aws_vpc" "sandbox-tf-vpc" {
  filter {
    name   = "tag:Name"
    values = ["infra-sandbox"]
  }
}

data "aws_subnet" "public" {
  count = length(split(",", local.availability_zones[var.region]))

  filter {
    name   = "tag:Name"
    values = ["infra-sandbox-public-${count.index}"]
  }
}

data "aws_subnet" "private" {
  count = length(split(",", local.availability_zones[var.region]))

  filter {
    name   = "tag:Name"
    values = ["infra-sandbox-private-${count.index}"]
  }
}