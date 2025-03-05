/*
  Description: DNS hosted zone association
*/

# Virtual Network Association with DNS Zone
resource "azurerm_private_dns_zone_virtual_network_link" "customer" {
  count = var.dns_zone != null ? 1 : 0

  resource_group_name   = azurerm_resource_group.customer.name
  name                  = module.module_context.resource_prefix
  private_dns_zone_name = var.dns_zone
  virtual_network_id    = azurerm_virtual_network.customer.id
}
