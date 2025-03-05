/*
  Description: Create Resource Group(s)
*/

### Resource Group
resource "azurerm_resource_group" "customer" {
  name     = module.module_context.resource_prefix
  tags     = module.module_context.tags
  location = module.module_context.region
}
