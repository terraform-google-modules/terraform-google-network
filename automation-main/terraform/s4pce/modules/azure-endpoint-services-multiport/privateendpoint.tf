/*
  Description:
    Create Private Endpoint.
*/

resource "azurerm_private_endpoint" "privateendpoint" {
  for_each = var.loadbalancer_frontendip_private_link_map
  name     = each.value["private_endpoint_name"]

  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_link_endpoint_subnet_id

  private_service_connection {
    name                           = "${each.value["private_endpoint_name"]}-private-service-connection"
    private_connection_resource_id = azurerm_private_link_service.privatelinkservice[each.key].id
    is_manual_connection           = false
  }

  tags = merge(module.base_layer_context.tags, {
    Name        = each.value["private_endpoint_name"]
    Description = title(replace(each.value["private_endpoint_name"], "-", " "))
  })

}
