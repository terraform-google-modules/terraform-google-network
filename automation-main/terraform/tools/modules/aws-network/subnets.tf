/*
  Description: Create subnets dynamically.
  Comments:
*/

resource "time_static" "aws_subnet" {
  triggers = {
    subnet_all_map = join(",", keys(local.subnet_all_map))
    build_user     = var.build_user
  }
  lifecycle {
    ignore_changes = [triggers["build_user"]]
  }
}
locals {
  tags_subnets = merge(var.tags, {
    BuildUser     = time_static.aws_nat_gateway.triggers.build_user
    ProvisionDate = time_static.aws_nat_gateway.rfc3339
  })
}

# NOTE: ipv6 subnet mask must be one of /44, /48, /52, /56, /60, /64
# NOTE: Hardcoding /64 for now
resource "aws_subnet" "main" {
  for_each                = local.subnet_all_map
  vpc_id                  = each.value.in_primary ? aws_vpc.main.id : aws_vpc_ipv4_cidr_block_association.main[each.value.vpc_cidr].vpc_id
  availability_zone       = lookup(local.letter_zone_map, each.value.zone)
  cidr_block              = each.key
  ipv6_cidr_block         = (each.value.ipv6_netnum != null) && (local.enable_ipv6) ? cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, each.value.ipv6_netnum) : null
  map_public_ip_on_launch = false
  tags                    = merge(local.tags_subnets, { meta_subnet_name = each.value.subnet_name })
}

output "subnets" {
  description = "Subnets"
  value = {
    for key, value in local.subnet_all_map : key => {
      arn                  = aws_subnet.main[key].arn
      id                   = aws_subnet.main[key].id
      cidr_block           = aws_subnet.main[key].cidr_block
      availability_zone    = aws_subnet.main[key].availability_zone
      availability_zone_id = aws_subnet.main[key].availability_zone_id
      ipv6 = aws_subnet.main[key].ipv6_cidr_block != "" ? {
        ipv6_cidr_block                = aws_subnet.main[key].ipv6_cidr_block
        ipv6_cidr_block_association_id = aws_subnet.main[key].ipv6_cidr_block_association_id
  } : null } }
}
