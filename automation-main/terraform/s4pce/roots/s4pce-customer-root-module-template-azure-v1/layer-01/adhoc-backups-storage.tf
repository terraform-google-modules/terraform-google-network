/*
  Description: Resources for Customer Data Migration
*/

module "context_adhocbackup" {
  source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context     = module.layer_context.context
  name        = "adhoc-backups"
  description = "${module.layer_context.customer} adhoc backups"
}

locals {
  lower_context_adhocbackup_tags = {
    for key, value in module.context_adhocbackup.tags : lower(key) => value
  }
}

resource "azurerm_storage_container" "adhoc-backups" {
  storage_account_name = local.layer_00.infrastructure.backups_storage_account.name
  name                 = module.context_adhocbackup.name
  metadata             = local.lower_context_adhocbackup_tags
}
