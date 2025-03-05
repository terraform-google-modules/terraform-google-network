/*
  Description: Handles backups of customer VM's for S4 PCE
*/

module "context_backups_customer" {
  source  = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context = module.layer_context.context

  name        = "backups"
  description = "VNet Recovery Services Vault for VM Backups"
}

resource "azurerm_recovery_services_vault" "customer" {
  resource_group_name = local.layer_00.infrastructure.resource_group_customer.name
  location            = local.layer_00.infrastructure.resource_group_customer.location
  name                = module.context_backups_customer.name
  tags                = module.context_backups_customer.tags
  sku                 = "Standard"
  soft_delete_enabled = var.adv_soft_delete
}

resource "azurerm_backup_policy_vm" "customer" {
  resource_group_name = local.layer_00.infrastructure.resource_group_customer.name
  recovery_vault_name = azurerm_recovery_services_vault.customer.name
  name                = module.context_backups_customer.name

  timezone = "UTC"

  backup {
    frequency = "Daily"
    time      = "05:00"
  }

  retention_daily {
    count = 90 // keep each backup for 90 days
  }

  instant_restore_retention_days = 5
}
