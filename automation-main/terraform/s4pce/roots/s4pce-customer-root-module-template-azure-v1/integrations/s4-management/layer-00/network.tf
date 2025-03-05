/*
  Description: Handles network connectivity components
*/

resource "azurerm_virtual_network_peering" "management_to_customer" {
  name                      = "${trim(substr(local.management_layer_00.vnet_management.name, 0, 35), "-")}--peer--${trim(substr(local.layer_00.infrastructure.vnet_customer.name, 0, 35), "-")}"
  resource_group_name       = local.management_layer_00.resource_group_management.name
  virtual_network_name      = local.management_layer_00.vnet_management.name
  remote_virtual_network_id = local.layer_00.infrastructure.vnet_customer.id
}

resource "azurerm_virtual_network_peering" "customer_to_management" {
  depends_on = [azurerm_virtual_network_peering.management_to_customer]

  name                         = "${trim(substr(local.layer_00.infrastructure.vnet_customer.name, 0, 35), "-")}--peer--${trim(substr(local.management_layer_00.vnet_management.name, 0, 35), "-")}"
  resource_group_name          = local.layer_00.infrastructure.resource_group_customer.name
  virtual_network_name         = local.layer_00.infrastructure.vnet_customer.name
  remote_virtual_network_id    = local.management_layer_00.vnet_management.id
  allow_virtual_network_access = false // enforce one-way relationship between management VNet and customer environments
}
