/*
  Description: Create Virtual Network(s)
*/

##### VNets
resource "azurerm_virtual_network" "customer" {
  resource_group_name = azurerm_resource_group.customer.name
  location            = azurerm_resource_group.customer.location
  name                = module.module_context.resource_prefix
  address_space       = [var.vnet_cidr_block]

  tags = merge(module.module_context.tags, {
    Name        = module.module_context.resource_prefix
    Description = "${module.module_context.environment_values.kv.prefix_friendly_name} VNet"
  })
}
