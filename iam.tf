data "template_file" "s3_policy" {
  template = file("iam-s3-policy.tpl")
  vars = {
    bucket_name = var.s3_bucket
  }
}

resource "aws_iam_policy" "policy" {
  name        = "javahome_2020_iam_demo_${local.ws}"
  path        = "/app/"
  description = "put and get permission on bucket"
  policy = data.template_file.s3_policy.rendered
}

resource "aws_iam_role" "demo_role" {
  name = "javahome-we-2020-demo-role_${local.ws}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name = "tag-value"
  }
}

resource "aws_iam_role_policy_attachment" "s3-attach" {
  role       = aws_iam_role.demo_role.name
  policy_arn = aws_iam_policy.policy.arn
}