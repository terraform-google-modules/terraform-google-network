/*
  Description: Creates reverse private endpoints for the customer.
  Layer: reverse-private-link
  Dependencies:
    layer-00: infrastructure
    layer-00: edge-network
  Comments: Azure DNS issues to be resolved at a future date.
*/


# This module creates Load Balancer, Private Link and Private Endpoint in the backend to consume the endpoint service.
module "endpoint_list" {
  for_each               = var.reverse_private_link_list
  source                 = "../EXAMPLE_SOURCE/terraform/s4pce/modules/azure-endpoint-services-multiport"
  context                = module.layer_context.context
  resource_group_name    = local.layer_00.infrastructure.resource_group_customer.name
  location               = local.layer_00.infrastructure.resource_group_customer.location
  loadbalancer_subnet_id = local.layer_00_edge.subnet_main01.id
  front_end_ip_zones     = local.layer_00.lb_front_end_ip_zones == "Zone-Redundant" ? local.layer_00.unique_zones : [local.layer_00.lb_front_end_ip_zones]

  private_link_endpoint_subnet_id = local.layer_00.infrastructure.subnets.production.id
  private_link_service_subnet_id  = local.layer_00_edge.subnet_main01.id

  loadbalancer_backend_pool_names = [each.key]
  loadbalancer_name               = "${module.layer_context.customer}-${each.key}-service-lb"
  loadbalancer_frontendip_private_link_map = {
    (each.key) = {
      loadbalancer_frontend_ip_name = "${module.layer_context.customer}-${lower(each.key)}"
      private_link_service_name     = "${module.layer_context.customer}-${lower(each.key)}"
      private_endpoint_name         = "${module.layer_context.customer}-${lower(each.key)}"
    }
  }
  loadbalancer_port = {
    for port in each.value.port_list : "${each.key}-${port}" => [port, "Tcp", port, each.key, each.key]
    #port translation
    //for i, port in each.value.port_list : "${each.key}-${port}" => [port, "Tcp", each.value.port_list_translation[i], each.key, each.key]
  }
  loadbalancer_probe = {
    for port in each.value.port_list : "${each.key}-${port}" => ["Tcp", port, ""]
    #port translation
    //for port in each.value.port_list_translation : "${each.key}-${port}" => ["Tcp", port, ""]
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "endpoint_list" {
  for_each              = var.reverse_private_link_list
  network_interface_id  = module.proxy_vm[each.key].network_interface_id
  ip_configuration_name = module.proxy_vm[each.key].network_interface_ip_configuration[0].name

  backend_address_pool_id = module.endpoint_list[each.key].azurerm_lb_backend_address_pool_ids[0]
}
