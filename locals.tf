locals {
  ws = "${terraform.workspace == "default" ? "dev" : terraform.workspace}"
  az_names = data.aws_availability_zones.azs.names
  pub_sub_ids = aws_subnet.public.*.id
  pri_sub_ids = aws_subnet.private.*.id
}