/*
  Description: create resource group/vnet/subnet for testing.
*/
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.az_location
}

#vnet for load balancer
module "lb_network" {
  source = "../terraform-azurerm-network"


  resource_group_name = azurerm_resource_group.rg.name
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  subnet_prefixes     = var.subnet_prefixes
  subnet_names        = var.subnet_names
  depends_on          = [azurerm_resource_group.rg]
}

#vnet private endpoint
module "private_link_endpoint_network" {
  source = "../terraform-azurerm-network"


  resource_group_name = azurerm_resource_group.rg.name
  vnet_name           = var.vnet_name2
  address_space       = var.address_space2
  subnet_prefixes     = var.subnet_prefixes2
  subnet_names        = var.subnet_names2
  depends_on          = [azurerm_resource_group.rg]
}
