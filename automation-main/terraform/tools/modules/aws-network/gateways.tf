/*
  Description: Create internet gateways and network gateways.
  Comments:
*/


##### Internet Gateways
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = merge(local.tags_vpc, {})
}
output "internet_gateway" {
  description = "Internet Gateway Output"
  value = {
    id             = aws_internet_gateway.main.id
    route_table_id = aws_vpc.main.default_route_table_id
  }
}
##### End Internet Gateways

##### Nat Gateways
locals {
  nat_gateway_map = var.deploy_nat_gateways ? {
    for key, value in local.subnet_edge_map : value.zone => key
  } : {}
}

##### Nat Gateway Deployment (IPv4)
resource "time_static" "aws_nat_gateway" {
  triggers = {
    nat_gateway_map = join(",", values(local.nat_gateway_map))
    build_user      = var.build_user
  }
  lifecycle {
    ignore_changes = [triggers["build_user"]]
  }
}
locals {
  tags_ngw = merge(var.tags, {
    BuildUser     = time_static.aws_nat_gateway.triggers.build_user
    ProvisionDate = time_static.aws_nat_gateway.rfc3339
  })
}

resource "aws_eip" "main" {
  for_each   = local.nat_gateway_map
  domain     = "vpc"
  tags       = merge(local.tags_ngw, {})
  depends_on = [aws_internet_gateway.main]
}
resource "aws_nat_gateway" "main" {
  for_each      = local.nat_gateway_map
  allocation_id = aws_eip.main[each.key].id
  subnet_id     = aws_subnet.main[each.value].id
  tags          = merge(local.tags_ngw, {})
}
output "nat_gateways" {
  description = "NAT Gateways (IPv4)"
  value = {
    for key, value in local.nat_gateway_map : key => {
      eip            = aws_eip.main[key].public_ip
      id             = aws_nat_gateway.main[key].id
      route_table_id = aws_route_table.main[key].id
  } }
}
##### End Nat Gateways

##### Egress Only Internet Gateways
resource "aws_egress_only_internet_gateway" "main" {
  count  = local.enable_ipv6 ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags   = merge(local.tags_vpc, {})
}
output "egress_only_internet_gateway" {
  description = "Egress Only Internet Gateway"
  value = local.enable_ipv6 ? {
    id = aws_egress_only_internet_gateway.main[0].id
  } : null
}
##### End Egress Only Internet Gateways
