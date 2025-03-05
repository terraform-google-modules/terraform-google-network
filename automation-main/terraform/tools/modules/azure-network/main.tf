/*
  Description: General module values
*/

##### Global Local Variables
locals {
  unique_zones_all = sort(distinct([
    for key, value in var.vnet_subnets : value.zone
  ]))
  unique_zones = setsubtract(local.unique_zones_all, ["nozone"])
  vnet_subnets_no_edge = {
    for key, value in var.vnet_subnets : key => value
    if(key != "edge")
  }
}


output "debug_main" {
  value = {
    unique_zones         = local.unique_zones
    unique_zones_all     = local.unique_zones_all
    vnet_subnets_no_edge = local.vnet_subnets_no_edge
    vnet_subnets         = var.vnet_subnets
  }
}

##### Error Handling
locals {
  errors = {
    VARIABLE_vnet_subnets_REQUIRES_KEY_edge_FOR_EDGE_SUBNET_CREATION = null
    EDGE_SUBNET_zone_MUST_BE_nozone                                  = null
  }

  # Enforce that an `edge` subnet is always configured in the `vnet_subnets` input
  _edge_subnet_check = lookup(var.vnet_subnets, "edge", null) != null
  edge_subnet_check  = local._edge_subnet_check ? [] : concat([], local.errors.VARIABLE_vnet_subnets_REQUIRES_KEY_edge_FOR_EDGE_SUBNET_CREATION)

  # Enforce that the `edge` subnet does not try to configure a `zone`
  _edge_subnet_nozone_zone_check = lookup(lookup(var.vnet_subnets, "edge", { cidr = null, zone = "nozone" }), "zone", "nozone") == "nozone"
  edge_subnet_nozone_zone_check  = local._edge_subnet_nozone_zone_check ? [] : concat([], local.errors.EDGE_SUBNET_zone_MUST_BE_nozone)
}
