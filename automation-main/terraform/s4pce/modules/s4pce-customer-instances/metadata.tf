/*
  Description: Create metadata
  Comments:
*/

##### Variable Parsing
locals {

  deployment_landscapes = distinct([
    for instance_name, instance_value in var.instance_list : lower(replace("${instance_value.landscape}", "-", "_"))
  ])

  # This formats the landscape value to be used for other variables
  instance_list_landscape_formatted = { for key, value in var.instance_list : key => replace(lower(value.landscape), "-", "_") }

  instance_info_list = flatten(concat([
    for instance_name, instance_value in var.instance_list : [
      for key_network, value_network in var.network : [
        for key_subnets, value_subnets in value_network.subnets : merge({
          subnet_zone   = value_subnets.zone
          subnet_name   = key_subnets
          subnet_cidr   = value_subnets.cidr
          instance_name = instance_name
        }, instance_value) if(length(regexall(lower(replace("^${instance_value.landscape}", "-", "_")), key_subnets)) > 0) && (try("${instance_value.az}", try("1${value_network.landscape_default_deployment_zones["${lower(replace("${instance_value.landscape}", "-", "_"))}"]["default_zone"]}"), null) == "1${value_subnets.zone}")
      ] if value_network.subnets != null
  ]]))

  instance_info_map = { for key, value in local.instance_info_list : value.instance_name => value }

  # Remove Special Instances from Instance List
  instance_list_standard = { for key, value in local.instance_info_map : key => value if !contains(["router"], value.productname) }

}