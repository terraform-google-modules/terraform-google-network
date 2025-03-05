/*
  Description: Create Subnet(s)
  Comments:
    Subnets:
      main01
*/

### Infrastructure Subnets
resource "azurerm_subnet" "main01" {
  resource_group_name                           = local.layer_00.infrastructure.resource_group_customer.name
  virtual_network_name                          = azurerm_virtual_network.main01.name
  name                                          = module.layer_context.resource_prefix
  service_endpoints                             = ["Microsoft.Storage"]
  private_endpoint_network_policies             = var.adv_subnet_endpoint_network_policies
  private_link_service_network_policies_enabled = var.adv_subnet_service_network_policies
  address_prefixes = [
    var.subnet_main01_cidr_block
  ]
}

### Subnet to Network Security Group association
resource "azurerm_subnet_network_security_group_association" "main01" {
  subnet_id                 = azurerm_subnet.main01.id
  network_security_group_id = azurerm_network_security_group.main01.id
}
