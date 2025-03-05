/*
  Description: Resources for Customer Data Migration
*/

module "context_migration" {
  source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context     = module.layer_context.context
  name        = "migration"
  description = "${module.layer_context.customer} data migration"
}

locals {
  lower_context_migration_tags = {
    for key, value in module.context_migration.tags : lower(key) => value
  }
}

resource "azurerm_storage_container" "migration" {
  storage_account_name = local.layer_00.infrastructure.backups_storage_account.name
  name                 = module.context_migration.name
  metadata             = local.lower_context_migration_tags
  # NOTE: The metadata attribute in terraform doesn't seem to actually work.....?
}

### NOTE: Could not get the azure application created due to token issues?
###       Leaving this code here if we ever want to revist and get this full encoded.
###       Otherwise the rest of this code has been done by hand in the console.

# resource "azuread_application" "migration" {
#   display_name = module.context_migration.name
#   #tags         = module.context_migration.tags
# NOTE: Potential issue with tags here.  Could not validate due to token issue.
# }

# resource "azuread_service_principal" "migration" {
#   application_id               = azuread_application.migration.application_id
#   #tags         = module.context_migration.tags
# NOTE: Potential issue with tags here.  Could not validate due to token issue.
# }

# resource "azuread_service_principal_password" "migration" {
#   service_principal_id = azuread_service_principal.migration.id
# }

# resource "azurerm_role_assignment" "migration" {
#   scope                = azurerm_storage_container.migration.resource_manager_id
#   role_definition_name = "Storage Blob Data Contributor"
#   principal_id         = azuread_service_principal.migration.object_id
# }
