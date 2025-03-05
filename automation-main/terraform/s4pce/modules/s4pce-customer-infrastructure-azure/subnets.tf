/*
  Description: Create Subnet(s)
  Comments:
    Subnets:
      customer_production
      customer_quality_assurance
      customer_development
      customer_edge
*/

resource "azurerm_subnet" "customer" {
  for_each = var.vnet_subnets

  resource_group_name  = azurerm_resource_group.customer.name
  virtual_network_name = azurerm_virtual_network.customer.name
  name                 = "${module.module_context.resource_prefix}-${each.key}"
  address_prefixes = [
    each.value.cidr
  ]
  private_endpoint_network_policies             = var.adv_subnet_endpoint_network_policies
  private_link_service_network_policies_enabled = var.adv_subnet_service_network_policies
  service_endpoints = [
    "Microsoft.Storage"
  ]
}

resource "azurerm_subnet_network_security_group_association" "customer" {
  for_each = var.vnet_subnets

  subnet_id                 = azurerm_subnet.customer[each.key].id
  network_security_group_id = azurerm_network_security_group.customer_global.id
}
