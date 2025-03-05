/*
  Description: create resource group/vnet/subnet for testing.
*/
#Azure Generic vNet Module
data "azurerm_resource_group" "network" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.network.name
  location            = data.azurerm_resource_group.network.location
  address_space       = length(var.address_spaces) == 0 ? [var.address_space] : var.address_spaces
  dns_servers         = var.dns_servers
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  count                                         = length(var.subnet_names)
  name                                          = var.subnet_names[count.index]
  resource_group_name                           = data.azurerm_resource_group.network.name
  address_prefixes                              = [var.subnet_prefixes[count.index]]
  virtual_network_name                          = azurerm_virtual_network.vnet.name
  private_endpoint_network_policies             = "Disabled"
  private_link_service_network_policies_enabled = false
}
