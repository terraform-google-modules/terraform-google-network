/*
  Description: Create metadata
  Comments:
*/

locals {
  subnet_nonedge_list = flatten(concat([
    for key_subnets, value_subnets in var.network.primary.subnets : {
      vpc_cidr    = var.network.primary.cidr
      zone        = value_subnets.zone
      subnet_name = key_subnets
      subnet_cidr = value_subnets.cidr
  }]))
  subnet_nonedge_map = { for key, value in local.subnet_nonedge_list : value.subnet_name => value }
  subnet_edge_list = flatten(concat([
    for key_subnets_edge, value_subnets_edge in var.network.primary.subnets_edge : {
      vpc_cidr    = var.network.primary.cidr
      zone        = value_subnets_edge.zone
      subnet_name = key_subnets_edge
      subnet_cidr = value_subnets_edge.cidr
  }]))
  subnet_edge_map = { for key, value in local.subnet_edge_list : value.subnet_name => value }
  subnet_all_list = concat(local.subnet_edge_list, local.subnet_nonedge_list)
  subnet_all_map  = merge(local.subnet_edge_map, local.subnet_nonedge_map)


  #### Zone stuff
  unique_zones = sort(distinct([
    for key, value in local.subnet_all_list : value.zone if(value.zone != null)
  ]))
  zone_letter_map = {
    for key in local.unique_zones : "${var.aws_region}${key}" => key
  }
  letter_zone_map = {
    for key in local.unique_zones : key => "${var.aws_region}${key}"
  }
}

output "metadata" { value = {
  letter_zone_map    = local.letter_zone_map
  zone_letter_map    = local.zone_letter_map
  unique_zones       = local.unique_zones
  subnet_nonedge_map = local.subnet_nonedge_map
  subnet_edge_map    = local.subnet_edge_map
  subnet_all_map     = local.subnet_all_map
} }
