provider "aws" {
  region  = var.region
}

terraform {
  backend "s3" {
    bucket = "javahome-2020-iac-we"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "tf_state_lock"
  }
}