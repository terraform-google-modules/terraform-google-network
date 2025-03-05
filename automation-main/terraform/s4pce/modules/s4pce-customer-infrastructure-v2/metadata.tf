/*
  Description: Create metadata
  Comments:
*/

##### Variable Parsing
locals {
  #### CIDR and Subnet Stuff
  vpc_additional_cidrs = {
    for key, value in var.network : value.cidr => {
      vpc_friendly_name = key
      cidr              = value.cidr
      subnets           = value.subnets
    } if key != "primary"
  }
  subnet_nonedge_list = flatten(concat([
    for key_network, value_network in var.network : [
      for key_subnets, value_subnets in value_network.subnets : {
        vpc_cidr    = value_network.cidr
        zone        = value_subnets.zone
        in_primary  = key_network == "primary" ? true : false
        subnet_name = key_subnets
        subnet_cidr = value_subnets.cidr
  }] if value_network.subnets != null]))
  subnet_nonedge_map = { for key, value in local.subnet_nonedge_list : value.subnet_name => value }
  subnet_primary_landscape_list = flatten(concat([
    for key_network, value_network in var.network : [
      for key_subnets, value_subnets in value_network.subnets : {
        vpc_cidr    = value_network.cidr
        zone        = value_subnets.zone
        in_primary  = key_network == "primary" ? true : false
        subnet_name = key_subnets
        subnet_cidr = value_subnets.cidr
      } if length(regexall("^${lower(replace("${value_network.primary_landscape}", "-", "_"))}", key_subnets)) > 0
  ] if value_network.subnets != null && key_network == "primary"]))
  subnet_primary_landscape_map = { for key, value in local.subnet_primary_landscape_list : value.subnet_name => value }
  subnet_edge_list = flatten(concat([
    for key_network, value_network in var.network : [
      for key_subnets_edge, value_subnets_edge in value_network.subnets_edge : {
        vpc_cidr    = value_network.cidr
        zone        = value_subnets_edge.zone
        in_primary  = key_network == "primary" ? true : false
        subnet_name = key_subnets_edge
        subnet_cidr = value_subnets_edge.cidr
  }] if value_network.subnets_edge != null]))
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
  letter_zone_map              = local.letter_zone_map
  zone_letter_map              = local.zone_letter_map
  unique_zones                 = local.unique_zones
  subnet_nonedge_map           = local.subnet_nonedge_map
  subnet_primary_landscape_map = local.subnet_primary_landscape_map
  subnet_edge_map              = local.subnet_edge_map
  subnet_all_map               = local.subnet_all_map
} }


# ##### Error Handling
locals {
  ERROR_PRIMARY_CIDR_NOT_DEFINED = var.network.primary

  ERROR_DUPLICATE_EDGE_SUBNET_ZONE = { for key, value in local.subnet_edge_map : value.zone => "" }
}
