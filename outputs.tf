output "vpc_id"{
    value = aws_vpc.main.id
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "azs"{
    value = data.aws_availability_zones.azs.names
}

output "s3_template" {
  value = data.template_file.s3_policy.rendered
}