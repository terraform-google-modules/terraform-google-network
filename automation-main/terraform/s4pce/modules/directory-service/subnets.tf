/*
  Description: Optionally Create Subnets for Directory Service
  Comments:
*/


resource "aws_subnet" "main01" {
  for_each                = var.directory_service_subnets.create_subnets
  vpc_id                  = var.directory_service_vpc_id
  availability_zone       = each.value.az
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = "false"
  tags                    = var.tags
}
output "subnets" { value = {
  for key, value in aws_subnet.main01 : key => {
    id         = value.id
    cidr_block = value.cidr_block
  }
} }
