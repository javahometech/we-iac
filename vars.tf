variable "vpc_cidr" {
   default = "10.0.0.0/16" 
      type = string
   description = "Choose CIDR block for VPC"
}
variable "subnet_cidr" {
    default = "10.0.1.0/24"
}

variable "region" {
    default = "us-east-1"
}

variable "s3_bucket"{
    default = "arn:aws:s3:::javahome-we-cdn/*"
}

variable "web_ami"{
    default = "ami-0c94855ba95c71c99"
}
