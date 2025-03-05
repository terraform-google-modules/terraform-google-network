/*
  Description: Create vpc networks dynamically. Creates S3 Endpoint
  Comments:
    * TODO: add ipv6 associations
*/

resource "time_static" "aws_vpc" {
  triggers = {
    cidr       = var.network.primary.cidr
    build_user = var.build_user
  }
  lifecycle {
    ignore_changes = [triggers["build_user"]]
  }
}
locals {
  tags_vpc = merge(var.tags, {
    BuildUser     = time_static.aws_vpc.triggers.build_user
    ProvisionDate = time_static.aws_vpc.rfc3339
  })
}


resource "aws_vpc" "main" {
  cidr_block                       = var.network.primary.cidr
  ipv6_cidr_block                  = null
  assign_generated_ipv6_cidr_block = local.enable_ipv6
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  tags                             = merge(local.tags_vpc, {})
}
resource "aws_vpc_ipv4_cidr_block_association" "main" {
  for_each   = local.vpc_additional_cidrs
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value.cidr
}
resource "aws_vpc_endpoint" "private_s3" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.s3"
  tags         = merge(local.tags_vpc, {})
}
resource "aws_vpc_dhcp_options_association" "main" {
  count           = var.custom_dhcpoptions_id == "" ? 0 : 1
  vpc_id          = aws_vpc.main.id
  dhcp_options_id = var.custom_dhcpoptions_id
}

locals {
  cidr_block_additional = [for key, value in aws_vpc_ipv4_cidr_block_association.main : key]
}
output "vpc" {
  description = "VPCs"
  value = {
    id                     = aws_vpc.main.id
    arn                    = aws_vpc.main.arn
    cidr_block             = aws_vpc.main.cidr_block
    cidr_block_additional  = local.cidr_block_additional
    s3_endpoint_id         = aws_vpc_endpoint.private_s3.id
    dhcp_options_id        = var.custom_dhcpoptions_id == "" ? aws_vpc.main.dhcp_options_id : var.custom_dhcpoptions_id
    default_route_table_id = aws_vpc.main.default_route_table_id
    ipv6 = aws_vpc.main.ipv6_cidr_block != null ? {
      ipv6_cidr_block                      = aws_vpc.main.ipv6_cidr_block
      ipv6_cidr_block_network_border_group = aws_vpc.main.ipv6_cidr_block_network_border_group
  } : null }
}
