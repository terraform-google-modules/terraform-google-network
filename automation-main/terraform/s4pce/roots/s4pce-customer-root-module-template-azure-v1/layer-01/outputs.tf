/*
  Description: Outputs data from the module; Contains commonly used outputs needed by other modules and dependent automation
*/

##### IAM
### IAM Roles
output "vm_base_roles" { value = local.vm_base_roles }
output "iam_role_default" { value = {
  id    = azurerm_role_definition.default.role_definition_id
  name  = azurerm_role_definition.default.name
  scope = azurerm_role_definition.default.scope
} }
output "iam_role_backups" { value = {
  id    = azurerm_role_definition.backups.role_definition_id
  name  = azurerm_role_definition.backups.name
  scope = local.layer_00.infrastructure.backups_container.id
} }


##### Recovery Services
output "backups" { value = {
  recovery_vault_name = azurerm_recovery_services_vault.customer.name
  vm_backup_policy_id = azurerm_backup_policy_vm.customer.id
} }
