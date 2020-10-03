
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "terraform-vpc"
    Batch = "weekend-2020"
    Env =  local.ws
  }
}

# Create Private Subnets

resource "aws_subnet" "private" {
  count = length(local.az_names)
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone = local.az_names[count.index]

  tags = {
    Name = "Private Subnet-${count.index + 1}"
    Env =  local.ws
  }
}

# Create Public Subnets

resource "aws_subnet" "public" {
  count = length(local.az_names)
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, length(local.az_names) + count.index)
  availability_zone = local.az_names[count.index]

  tags = {
    Name = "Public Subnet-${count.index + 1}"
    Env =  local.ws
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "JavaHome-${local.ws}"
    Env =  local.ws
  } 
}

# Create route table for public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "PublicRouter-${local.ws}"
  }
}

# Attach public route table to public subets

resource "aws_route_table_association" "a" {
  count = length(local.az_names)
  subnet_id      = local.pub_sub_ids[count.index]
  route_table_id = aws_route_table.public.id
}

# Create NAT gateway