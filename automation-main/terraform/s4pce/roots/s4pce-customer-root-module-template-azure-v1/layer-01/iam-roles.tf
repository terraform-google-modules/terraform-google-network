/*
  Description: Handles account IAM roles
*/

locals {
  // role definition name -> scope
  vm_base_roles = {
    (module.context_iam_role_default.name)      = azurerm_role_definition.default.scope
    (module.context_iam_role_backups.name)      = local.layer_00.infrastructure.backups_container.id
    (module.context_iam_role_adhocbackups.name) = azurerm_storage_container.adhoc-backups.resource_manager_id
  }
}

### Default
module "context_iam_role_default" {
  source  = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context = module.layer_context.context

  name        = "default"
  description = "Provides default access for ${module.layer_context.customer} virtual machines"
}

resource "azurerm_role_definition" "default" {
  name        = module.context_iam_role_default.name
  description = module.context_iam_role_default.description
  scope       = local.layer_00.infrastructure.resource_group_customer.id

  permissions {
    actions = [
      "Microsoft.Compute/virtualMachines/read",
    ]
  }
}

### Backups
module "context_iam_role_backups" {
  source  = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context = module.layer_context.context

  name        = "backups"
  description = "Allows VMs to read and write to ${module.layer_context.customer} backups storage account"
}

resource "azurerm_role_definition" "backups" {
  name        = module.context_iam_role_backups.name
  description = module.context_iam_role_backups.description
  scope       = local.layer_00.infrastructure.resource_group_customer.id

  permissions {
    actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/read",
    ]
    data_actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/delete",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write"
    ]
  }

  assignable_scopes = [
    local.layer_00.infrastructure.backups_container.id
  ]
}

### Adhoc backups
module "context_iam_role_adhocbackups" {
  source  = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context = module.layer_context.context

  name        = "adhocbackups"
  description = "Allows VMs to read and write to ${module.layer_context.customer} adhoc backups storage account"
}

resource "azurerm_role_definition" "adhocbackups" {
  name        = module.context_iam_role_adhocbackups.name
  description = module.context_iam_role_adhocbackups.description
  scope       = local.layer_00.infrastructure.resource_group_customer.id

  permissions {
    actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/read",
    ]
    data_actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/delete",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write"
    ]
  }

  assignable_scopes = [
    azurerm_storage_container.adhoc-backups.resource_manager_id
  ]
}
