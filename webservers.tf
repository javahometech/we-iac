resource "aws_key_pair" "web" {
  key_name   = "web-key-we"
  public_key = file("web-key-we.pub")
}

# Create EC2 instances in public subnet
resource "aws_instance" "web" {
  ami           = var.web_ami
  instance_type = "t2.micro"
  subnet_id = local.pub_sub_ids[0]
  key_name = aws_key_pair.web.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  user_data = file("web.sh")
  iam_instance_profile = aws_iam_instance_profile.web_s3_profile.id
  tags = {
    Name = "web-1"
  }
}

resource "aws_iam_instance_profile" "web_s3_profile" {
  name = "web_s3_profile-${local.ws}"
  role = aws_iam_role.demo_role.name
}


# Security group for web servers

resource "aws_security_group" "web_sg" {
  name        = "web-security-group-${local.ws}"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-security-group"
  }
}