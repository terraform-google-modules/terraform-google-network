/*
  Description: Create Virtual Network(s)
*/

##### VNets
resource "azurerm_virtual_network" "main01" {
  resource_group_name = azurerm_resource_group.main01.name
  location            = azurerm_resource_group.main01.location
  name                = random_id.azurerm_resource_group.hex
  address_space       = var.vnet_cidr_blocks
  tags                = merge(local.tags_rg, {})
}

resource "azurerm_virtual_network_dns_servers" "main01" {
  count              = var.use_custom_dhcpoptions_dns != [] ? 1 : 0
  virtual_network_id = azurerm_virtual_network.main01.id
  dns_servers        = var.use_custom_dhcpoptions_dns
}


##### VNets
output "vnet_main01" { value = {
  id            = azurerm_virtual_network.main01.id
  address_space = azurerm_virtual_network.main01.address_space
  guid          = azurerm_virtual_network.main01.guid
} }
