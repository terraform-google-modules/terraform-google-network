/*
  Description: Create Resource Group(s)
*/

### Tagging
resource "random_id" "azurerm_resource_group" {
  byte_length = 8
}
resource "time_static" "azurerm_resource_group" {
  triggers = {
    random_id  = random_id.azurerm_resource_group.hex
    build_user = var.build_user
  }
  lifecycle {
    ignore_changes = [triggers["build_user"]]
  }
}
locals {
  tags_rg = merge(var.tags, {
    BuildUser     = time_static.azurerm_resource_group.triggers.build_user
    ProvisionDate = time_static.azurerm_resource_group.rfc3339
    meta_name     = time_static.azurerm_resource_group.triggers.random_id
    region        = var.region
  })
}

### Resource Group
resource "azurerm_resource_group" "main01" {
  name     = local.tags_rg.meta_name
  tags     = local.tags_rg
  location = local.tags_rg.region
}

output "resource_group_main01" { value = {
  id       = azurerm_resource_group.main01.id
  name     = azurerm_resource_group.main01.name
  location = azurerm_resource_group.main01.location
} }
