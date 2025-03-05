/*
  Description: Create Subnet(s)
  Comments:
*/

##### Subnets
resource "azurerm_subnet" "main01" {
  for_each                                      = var.vnet_subnets
  resource_group_name                           = azurerm_resource_group.main01.name
  virtual_network_name                          = azurerm_virtual_network.main01.name
  name                                          = "${azurerm_virtual_network.main01.name}-${each.key}"
  address_prefixes                              = each.value.cidr
  private_link_service_network_policies_enabled = false
  private_endpoint_network_policies             = "Disabled"
  service_endpoints = [
    "Microsoft.Storage"
  ]
}

output "subnets" { value = {
  for key, value in var.vnet_subnets : key => {
    name = azurerm_subnet.main01[key].name
    id   = azurerm_subnet.main01[key].id
    cidr = value.cidr
    zone = value.zone
  }
} }

##### Subnet Associations
### Associate Security Groups
resource "azurerm_subnet_network_security_group_association" "main01" {
  for_each                  = var.vnet_subnets
  subnet_id                 = azurerm_subnet.main01[each.key].id
  network_security_group_id = azurerm_network_security_group.main01.id
}

### If Nat Gateways are deployed, create associations
resource "azurerm_subnet_nat_gateway_association" "main01" {
  for_each       = var.deploy_nat_gateways ? local.vnet_subnets_no_edge : {}
  subnet_id      = azurerm_subnet.main01[each.key].id
  nat_gateway_id = azurerm_nat_gateway.main01[each.value.zone].id
}

### If Route Tables are deployed, create associations
resource "azurerm_subnet_route_table_association" "main01" {
  for_each       = var.deploy_private_route_tables && var.associates_private_route_tables ? var.vnet_subnets : {}
  subnet_id      = azurerm_subnet.main01[each.key].id
  route_table_id = azurerm_route_table.main01[each.value.zone].id
}
