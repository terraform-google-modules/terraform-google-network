/*
  Description: Create Route Tables.  One Private Route Table per zone.
  Comments:
*/

##### Default (IGW) Route Table
resource "aws_default_route_table" "main" {
  default_route_table_id = aws_vpc.main.default_route_table_id
  tags                   = merge(local.tags_vpc, {})
}
resource "aws_route" "main_default_igw" {
  route_table_id         = aws_vpc.main.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}
resource "aws_route" "main_default_igw_ipv6" {
  count                       = local.enable_ipv6 ? 1 : 0
  route_table_id              = aws_vpc.main.default_route_table_id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.main.id
}
resource "aws_vpc_endpoint_route_table_association" "main_default_igw" {
  route_table_id  = aws_vpc.main.default_route_table_id
  vpc_endpoint_id = aws_vpc_endpoint.private_s3.id
}


##### Route Tables (NGW)
resource "time_static" "aws_route_table" {
  triggers = {
    deploy_private_route_tables = var.deploy_private_route_tables
    unique_zones                = join(",", local.unique_zones)
    build_user                  = var.build_user
  }
  lifecycle {
    ignore_changes = [triggers["build_user"]]
  }
}
locals {
  tags_rtb = merge(var.tags, {
    BuildUser     = time_static.aws_route_table.triggers.build_user
    ProvisionDate = time_static.aws_route_table.rfc3339
  })
}
resource "aws_route_table" "main" {
  for_each = var.deploy_private_route_tables ? toset(local.unique_zones) : []
  vpc_id   = aws_vpc.main.id
  tags     = merge(local.tags_rtb, { "meta_zone" = each.key })
}
resource "aws_route" "main_ngw" {
  for_each               = var.deploy_nat_gateways && var.deploy_private_route_tables ? local.nat_gateway_map : {}
  route_table_id         = aws_route_table.main[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main[each.key].id
}
resource "aws_route" "main_egress_only" {
  for_each                    = var.deploy_nat_gateways && var.deploy_private_route_tables && local.enable_ipv6 ? local.nat_gateway_map : {}
  route_table_id              = aws_route_table.main[each.key].id
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.main[0].id
}
resource "aws_route_table_association" "main" {
  for_each       = var.deploy_private_route_tables && var.associates_private_route_tables ? local.subnet_nonedge_map : {}
  subnet_id      = aws_subnet.main[each.key].id
  route_table_id = aws_route_table.main[each.value.zone].id
}
resource "aws_vpc_endpoint_route_table_association" "main" {
  for_each        = var.deploy_private_route_tables ? local.subnet_nonedge_map : {}
  route_table_id  = aws_route_table.main[each.value.zone].id
  vpc_endpoint_id = aws_vpc_endpoint.private_s3.id
}
##### END Route Tables (NGW)

output "route_tables" {
  description = "Route Tables"
  value = merge(
    { default = {
      id = aws_default_route_table.main.id
    } },
    { for key in local.unique_zones : key => {
      id = aws_route_table.main[key].id
      } if var.deploy_private_route_tables
  })
}
