/*
  Description: Creates VNet private endpoints for the customer.
    Parses the raw instance list for instances that have the `endpoint_port_list` value defined.
    Of the instances with `endpoint_port_list`, create a Load Balancer/Endpoint that passes the TCP Ports that are listed.
  Layer: 00
  Dependencies:
    layer-00: infrastructure
    layer-02: layer 02 outputs
  Comments: Azure DNS issues to be resolved at a future date.
*/

locals {
  # Parse the instance list and creates a new list of instances that have `endpoint_port_list` defined
  endpoint_list = { for key, value in local.layer_02.raw_instance_list : key => value if lookup(value, "endpoint_port_list", []) != [] }
  # Find instances that end with "dr"
  dr_instances = { for key, value in local.layer_02.raw_instance_list : key => value if substr(key, -2, -1) == "dr" }
  # Filtered lists/dicts containing only "dr" instances
  endpoint_list_filtered = { for key, value in local.endpoint_list : key => value if contains(keys(local.dr_instances), "${key}dr") == true }
}

locals {
  merged_endpoint_list = { for key, value in local.endpoint_list : key => merge(
    value,
    { "is_legacy" = contains(var.legacy_endpoints, key) ? true : false }
  ) }
}

# This module creates Load Balancer, Private Link and Private Endpoint in the backend to consume the endpoint service.
module "endpoint_list" {
  for_each               = local.merged_endpoint_list
  source                 = "../../EXAMPLE_SOURCE/terraform/s4pce/modules/azure-endpoint-services-multiport"
  context                = module.layer_context.context
  resource_group_name    = local.layer_00.infrastructure.resource_group_customer.name
  location               = local.layer_00.infrastructure.resource_group_customer.location
  loadbalancer_subnet_id = each.value.is_legacy ? local.layer_00.infrastructure.subnets.edge.id : local.layer_02.instance_list[each.key].network_interface_ip_configuration[0].subnet_id
  front_end_ip_zones     = local.layer_00.lb_front_end_ip_zones == "Zone-Redundant" ? local.layer_00.unique_zones : [local.layer_00.lb_front_end_ip_zones]

  private_link_endpoint_subnet_id = azurerm_subnet.main01.id
  private_link_service_subnet_id  = each.value.is_legacy ? local.layer_00.infrastructure.subnets.edge.id : local.layer_02.instance_list[each.key].network_interface_ip_configuration[0].subnet_id

  loadbalancer_backend_pool_names = [each.key]
  loadbalancer_name               = "${each.key}-service-lb"
  loadbalancer_frontendip_private_link_map = {
    (each.key) = {
      loadbalancer_frontend_ip_name = "${lower(each.key)}-load-balancer-edge"
      private_link_service_name     = "${lower(each.key)}-private-link-edge"
      private_endpoint_name         = "${lower(each.key)}-private-endpoint-edge"
    }
  }
  loadbalancer_port = {
    for port in each.value.endpoint_port_list : "${each.key}-${port}" => [port, "Tcp", port, each.key, each.key]
  }
  loadbalancer_probe = {
    for port in each.value.endpoint_port_list : "${each.key}-${port}" => ["Tcp", port, ""]
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "endpoint_list" {
  for_each = local.endpoint_list

  network_interface_id = (
    var.lb_pool_node_type != "dr" ?
    local.layer_02.instance_list[each.key].network_interface_id : !contains(keys(local.layer_02.raw_instance_list), "${each.key}dr") ?
    local.layer_02.instance_list[each.key].network_interface_id : local.layer_02.instance_list["${each.key}dr"].network_interface_id
  )
  ip_configuration_name = (
    var.lb_pool_node_type != "dr" ?
    local.layer_02.instance_list[each.key].network_interface_ip_configuration[0].name : !contains(keys(local.layer_02.raw_instance_list), "${each.key}dr") ?
    local.layer_02.instance_list[each.key].network_interface_ip_configuration[0].name : local.layer_02.instance_list["${each.key}dr"].network_interface_ip_configuration[0].name
  )

  backend_address_pool_id = module.endpoint_list[each.key].azurerm_lb_backend_address_pool_ids[0]
}

# Add DR node to existing LB for 'both' mode
resource "azurerm_network_interface_backend_address_pool_association" "dr_endpoint_list" {
  for_each                = var.lb_pool_node_type == "both" ? toset(keys(local.endpoint_list_filtered)) : []
  network_interface_id    = local.layer_02.instance_list["${each.key}dr"].network_interface_id
  ip_configuration_name   = local.layer_02.instance_list["${each.key}dr"].network_interface_ip_configuration[0].name
  backend_address_pool_id = module.endpoint_list[each.key].azurerm_lb_backend_address_pool_ids[0]
}
