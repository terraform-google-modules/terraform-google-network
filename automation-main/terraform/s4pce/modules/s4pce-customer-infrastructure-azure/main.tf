/*
  Description: Core module configurations; Core data resources, base context, global local variables, etc
*/


##### Context
locals {
  module_name = "s4pce-customer-infrastructure-azure"
}

module "module_context" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = var.context

  module = local.module_name
}


##### Global Local Variables
locals {
  unique_zones = sort(distinct([
    for key, value in var.vnet_subnets : value.zone if(value.zone != null)
  ]))
  az_letter_mapping = {
    for key in local.unique_zones : "az${key}" => key
  }
  az_zone_mapping = {
    for key in local.unique_zones : key => "az${key}"
  }
  description_prefix = module.module_context.environment_values.kv.prefix_friendly_name
  vnet_subnets_no_edge = {
    for key, value in var.vnet_subnets : key => value
    if(key != "edge")
  }
}


##### Error Handling
locals {
  errors = {
    VARIABLE_vnet_subnets_REQUIRES_KEY_edge_FOR_EDGE_SUBNET_CREATION = null
    EDGE_SUBNET_zone_MUST_BE_null                                    = null
  }

  # Enforce that an `edge` subnet is always configured in the `vnet_subnets` input
  _edge_subnet_check = lookup(var.vnet_subnets, "edge", null) != null
  edge_subnet_check  = local._edge_subnet_check ? [] : concat([], local.errors.VARIABLE_vnet_subnets_REQUIRES_KEY_edge_FOR_EDGE_SUBNET_CREATION)

  # Enforce that the `edge` subnet does not try to configure a `zone`
  _edge_subnet_null_zone_check = lookup(lookup(var.vnet_subnets, "edge", { cidr = null, zone = null }), "zone", null) == null
  edge_subnet_null_zone_check  = local._edge_subnet_null_zone_check ? [] : concat([], local.errors.EDGE_SUBNET_zone_MUST_BE_null)
}
