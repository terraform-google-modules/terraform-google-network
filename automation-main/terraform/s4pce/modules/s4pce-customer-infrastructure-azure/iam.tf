/*
  Description: IAM roles and assignments
  Comment:
    - Louis 2025-02-20 : All of this looks to be a regional specific thing and not related to PCE at all.  We should move it all to Layer-Options.
*/

data "azurerm_role_definition" "custom_create_virtual_network_gateway" {
  count = var.vnet_gateway_permissions_enable ? 1 : 0

  name  = "NS2-CreateVirtualNetworkGateway"
  scope = data.azurerm_subscription.subscription.id
}


data "azurerm_subscription" "subscription" {
  #leave empty to reference current subscription
}


locals {
  rbac_prefix          = lookup(data.azurerm_subscription.subscription.tags, "RBAC-Prefix", "NULL")
  operations_rbac_name = local.rbac_prefix != "NULL" ? "${local.rbac_prefix}_azure_operations" : "NULL"
}


data "azuread_group" "sg_operations" {
  count = var.vnet_gateway_permissions_enable ? 1 : 0

  display_name = local.operations_rbac_name
}


module "context_create_virtual_network_gateway" {
  source      = "../../../shared/modules/terraform-null-context/modules/legacy"
  count       = var.vnet_gateway_permissions_enable ? 1 : 0
  context     = module.module_context.context
  description = "Authorize operations to manage customer's virtual network gateways."
}


resource "azurerm_role_assignment" "create_virtual_network_gateway" {
  count                = var.vnet_gateway_permissions_enable ? 1 : 0
  description          = module.context_create_virtual_network_gateway[0].description
  scope                = azurerm_resource_group.customer.id
  role_definition_name = data.azurerm_role_definition.custom_create_virtual_network_gateway[0].name
  principal_id         = data.azuread_group.sg_operations[0].object_id
}
