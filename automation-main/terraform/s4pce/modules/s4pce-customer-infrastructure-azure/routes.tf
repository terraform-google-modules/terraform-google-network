/*
  Description: Create Route(s) with Subnet association(s)
*/

##### Route Table(s)
### Prod/QA/Dev Subnets
module "context_rtb_customer" {
  source   = "../../../shared/modules/terraform-null-context/modules/legacy"
  context  = module.module_context.context
  for_each = local.az_letter_mapping

  name        = each.key
  description = "${local.description_prefix} - Route Table Zone ${each.value}"
}

resource "azurerm_route_table" "customer" {
  for_each = local.az_letter_mapping

  resource_group_name = azurerm_resource_group.customer.name
  location            = azurerm_resource_group.customer.location
  name                = module.context_rtb_customer[each.key].name
  tags                = module.context_rtb_customer[each.key].tags
}

resource "azurerm_subnet_nat_gateway_association" "customer" {
  for_each = var.create_nat_gateway ? local.vnet_subnets_no_edge : {}

  subnet_id      = azurerm_subnet.customer[each.key].id
  nat_gateway_id = azurerm_nat_gateway.customer[local.az_zone_mapping[each.value.zone]].id
}

resource "azurerm_subnet_route_table_association" "customer" {
  for_each = local.vnet_subnets_no_edge

  subnet_id      = azurerm_subnet.customer[each.key].id
  route_table_id = azurerm_route_table.customer[local.az_zone_mapping[each.value.zone]].id
}


### Edge Subnet
module "context_rtb_customer_edge" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = module.module_context.context

  name        = "edge"
  description = "${local.description_prefix} - Edge Route Table"
}

resource "azurerm_route_table" "customer_edge" {
  resource_group_name = azurerm_resource_group.customer.name
  location            = azurerm_resource_group.customer.location
  name                = module.context_rtb_customer_edge.name
  tags                = module.context_rtb_customer_edge.tags
}

resource "azurerm_subnet_route_table_association" "customer_edge" {
  subnet_id      = azurerm_subnet.customer["edge"].id
  route_table_id = azurerm_route_table.customer_edge.id
}
