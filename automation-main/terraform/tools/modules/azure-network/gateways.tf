/*
  Description: Handles creation of NAT gateways and associated Public IPs
  Comments:
    - Provision zonal stacks since nat gateways in Azure are not zone-redundant
      (https://docs.microsoft.com/en-us/azure/virtual-network/nat-gateway/nat-gateway-resource#zone-isolation-with-zonal-stacks)
*/

locals {
  nat_gateway_list = var.deploy_nat_gateways ? local.unique_zones : []
}
resource "random_id" "azurerm_nat_gateway" {
  for_each    = toset(local.nat_gateway_list)
  byte_length = 8
}
resource "time_static" "azurerm_nat_gateway" {
  for_each = toset(local.nat_gateway_list)
  triggers = {
    random_id  = random_id.azurerm_nat_gateway[each.key].hex
    build_user = var.build_user
  }
  lifecycle {
    ignore_changes = [triggers["build_user"]]
  }
}
locals {
  tags_ngw = { for key in local.nat_gateway_list : key => merge(var.tags, {
    BuildUser     = time_static.azurerm_nat_gateway[key].triggers.build_user
    ProvisionDate = time_static.azurerm_nat_gateway[key].rfc3339
    zone          = key
  }) }
}

resource "azurerm_nat_gateway" "main01" {
  for_each            = toset(local.nat_gateway_list)
  resource_group_name = azurerm_resource_group.main01.name
  location            = azurerm_resource_group.main01.location
  name                = random_id.azurerm_nat_gateway[each.key].hex
  tags                = local.tags_ngw[each.key]
  zones               = each.key == "No-Zone" ? null : [each.key]
}

resource "azurerm_public_ip" "main01_nat" {
  for_each            = toset(local.nat_gateway_list)
  resource_group_name = azurerm_resource_group.main01.name
  location            = azurerm_resource_group.main01.location
  name                = random_id.azurerm_nat_gateway[each.key].hex
  tags                = local.tags_ngw[each.key]
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = [each.key] # Revisit this.  Seems like Azure has made IP possibly zone redundant.
}

resource "azurerm_nat_gateway_public_ip_association" "main01" {
  for_each             = toset(local.nat_gateway_list)
  nat_gateway_id       = azurerm_nat_gateway.main01[each.key].id
  public_ip_address_id = azurerm_public_ip.main01_nat[each.key].id
}


##### NAT Gateways
output "nat_gateways" { value = {
  for key in local.nat_gateway_list : key => {
    name = azurerm_nat_gateway.main01[key].name
    id   = azurerm_nat_gateway.main01[key].id
    public_ip = {
      id      = azurerm_public_ip.main01_nat[key].id
      address = azurerm_public_ip.main01_nat[key].ip_address
  } }
} }
