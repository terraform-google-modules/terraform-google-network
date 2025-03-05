/*
  Description: Create Route(s) with Subnet association(s)
*/

##### Route Table(s)
locals {
  # Create a map of zones to deploy route tables.
  route_table_list = var.deploy_private_route_tables ? local.unique_zones_all : []
}
resource "random_id" "azurerm_route_table" {
  for_each = toset(local.route_table_list)
  keepers = {
    deploy_private_route_tables = var.deploy_private_route_tables
  }
  byte_length = 8
}
resource "time_static" "azurerm_route_table" {
  for_each = toset(local.route_table_list)
  triggers = {
    random_id  = random_id.azurerm_route_table[each.key].hex
    build_user = var.build_user
  }
  lifecycle {
    ignore_changes = [triggers["build_user"]]
  }
}
locals {
  tags_rtb = { for key in local.route_table_list : key => merge(var.tags, {
    BuildUser     = time_static.azurerm_route_table[key].triggers.build_user
    ProvisionDate = time_static.azurerm_route_table[key].rfc3339
    zone          = key
  }) }
}
resource "azurerm_route_table" "main01" {
  for_each            = toset(local.route_table_list)
  resource_group_name = azurerm_resource_group.main01.name
  location            = azurerm_resource_group.main01.location
  name                = random_id.azurerm_route_table[each.key].hex
  tags                = local.tags_rtb[each.key]
}


##### Route Tables
output "route_tables" { value = {
  for key in local.route_table_list : key => {
    name = azurerm_route_table.main01[key].name
    id   = azurerm_route_table.main01[key].id
  } if var.deploy_private_route_tables
} }
