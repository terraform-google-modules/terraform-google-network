/*
  Description: Handles Vnet routing creation
*/

##### Edge Route Table
module "context_rtb_main01" {
  source  = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context = module.layer_context.context

  name        = "connection"
  description = "Route Table - Customer Edge Network Connection"
}

resource "azurerm_route_table" "main01" {
  resource_group_name = local.layer_00.infrastructure.resource_group_customer.name
  location            = local.layer_00.infrastructure.resource_group_customer.location
  name                = module.context_rtb_main01.name
  tags                = module.context_rtb_main01.tags
}

### Routes
// NOTE: Azure edge resources route to internet by default when a Public IP is associated

### Route Table Associations
resource "azurerm_subnet_route_table_association" "main01" {
  subnet_id      = azurerm_subnet.main01.id
  route_table_id = azurerm_route_table.main01.id
}
