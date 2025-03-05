/*
  Description: Handles creation of NAT gateways and associated Public IPs
  Comments:
    - Provision zonal stacks since nat gateways in Azure are not zone-redundant
      (https://docs.microsoft.com/en-us/azure/virtual-network/nat-gateway/nat-gateway-resource#zone-isolation-with-zonal-stacks)
*/

##### NAT Gateways
module "context_nat_customer" {
  source   = "../../../shared/modules/terraform-null-context/modules/legacy"
  context  = module.module_context.context
  for_each = local.az_letter_mapping

  name        = each.key
  description = "${local.description_prefix} - NAT Gateway Zone ${each.value}"
}

resource "azurerm_nat_gateway" "customer" {
  for_each = var.create_nat_gateway ? local.az_letter_mapping : {}

  resource_group_name = azurerm_resource_group.customer.name
  location            = azurerm_resource_group.customer.location
  name                = module.context_nat_customer[each.key].name
  tags                = module.context_nat_customer[each.key].tags
  zones               = each.value == "No-Zone" ? null : [each.value]
}

### Public IPs
module "context_public_ip_customer_nat" {
  source   = "../../../shared/modules/terraform-null-context/modules/legacy"
  context  = module.module_context.context
  for_each = local.az_letter_mapping

  name        = "nat-${each.key}"
  description = "${local.description_prefix} - NAT Gateway Public IP Zone ${each.value}"
}

resource "azurerm_public_ip" "customer_nat" {
  for_each = var.create_nat_gateway ? local.az_letter_mapping : {}

  resource_group_name = azurerm_resource_group.customer.name
  location            = azurerm_resource_group.customer.location
  name                = module.context_public_ip_customer_nat[each.key].name
  tags                = module.context_public_ip_customer_nat[each.key].tags
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = [each.value]
}

resource "azurerm_nat_gateway_public_ip_association" "customer" {
  for_each = var.create_nat_gateway ? local.az_letter_mapping : {}

  nat_gateway_id       = azurerm_nat_gateway.customer[each.key].id
  public_ip_address_id = azurerm_public_ip.customer_nat[each.key].id
}
