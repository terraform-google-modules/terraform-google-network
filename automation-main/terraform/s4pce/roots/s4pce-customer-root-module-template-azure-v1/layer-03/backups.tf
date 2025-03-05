/*
Description: Resources for VM Backups
*/

locals {
  instance_list_windows_only = {
    for key, value in local.layer_02.raw_instance_list : key => value if lookup(value, "os", "") == "windows"
  }
  instance_list_saprouter_only = {
    for key, value in local.layer_02.raw_instance_list : key => value if lookup(value, "productname", "") == "router"
  }
  instance_list_exclude_windows_and_saprouter = {
    for key, value in local.layer_02.raw_instance_list : key => value if !(lookup(value, "os", "") == "windows" || lookup(value, "productname", "") == "router")
  }
}

### Backups
resource "azurerm_backup_protected_vm" "instance_list" {
  for_each = local.instance_list_exclude_windows_and_saprouter

  resource_group_name = local.layer_00.infrastructure.resource_group_customer.name
  recovery_vault_name = local.layer_01.backups.recovery_vault_name
  backup_policy_id    = local.layer_01.backups.vm_backup_policy_id
  source_vm_id        = local.layer_02.instance_list[each.key].id
}
resource "azurerm_backup_protected_vm" "windows_instance" {
  for_each = local.instance_list_windows_only

  resource_group_name = local.layer_00.infrastructure.resource_group_customer.name
  recovery_vault_name = local.layer_01.backups.recovery_vault_name
  backup_policy_id    = local.layer_01.backups.vm_backup_policy_id
  source_vm_id        = local.layer_02.windows_instance_list[each.key].id
}
resource "azurerm_backup_protected_vm" "saprouter_instance" {
  for_each = local.instance_list_saprouter_only

  resource_group_name = local.layer_00.infrastructure.resource_group_customer.name
  recovery_vault_name = local.layer_01.backups.recovery_vault_name
  backup_policy_id    = local.layer_01.backups.vm_backup_policy_id
  source_vm_id        = local.layer_02.instance_list_saprouter[each.key].id
}
