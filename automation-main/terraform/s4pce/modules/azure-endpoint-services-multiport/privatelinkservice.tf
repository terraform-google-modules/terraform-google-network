/*
  Description:
    Create Private Link Service.
*/

resource "azurerm_private_link_service" "privatelinkservice" {
  for_each            = var.loadbalancer_frontendip_private_link_map
  name                = each.value["private_link_service_name"]
  resource_group_name = var.resource_group_name
  location            = var.location

  load_balancer_frontend_ip_configuration_ids = [
    azurerm_lb.loadbalancer.frontend_ip_configuration[index(local.loadbalancer_frontend_ip_names, each.value["loadbalancer_frontend_ip_name"])].id
  ]

  nat_ip_configuration {
    name      = "${each.value["private_link_service_name"]}-primary"
    subnet_id = var.private_link_service_subnet_id
    primary   = true
  }

  tags = merge(module.base_layer_context.tags, {
    Name        = each.value["private_link_service_name"]
    Description = title(replace(each.value["private_link_service_name"], "-", " "))
  })

}
