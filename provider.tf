provider "aws" {
  region  = var.region
}

locals {
  ws = "${terraform.workspace == "default" ? "dev" : terraform.workspace}"
}

resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "terraform-vpc"
    Batch = "weekend-2020"
    Env =  local.ws
  }
}


# Create Subnet under VPC

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr

  tags = {
    Name = "Subnet-1"
    Location = "Banglore"
    Env =  local.ws
  }
}