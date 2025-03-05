/*
  Description: Manages network storage and network file shares
*/

locals {
  label_order_stripped = module.module_context.label_order[length(module.module_context.label_order) - 2]
  _customer_storage_prefix = {
    prefix = replace(
      module.module_context.prefix_label_mapping.prefix[local.label_order_stripped],
      "-", ""
    )
    letter = substr(module.module_context.customer, 0, 1)
    //it removes the ending 0 which is not good: 0020 -> 2
    //number = trim(substr(module.module_context.customer, -4, -1), "0")
    number = trimprefix(trimprefix(substr(module.module_context.customer, -4, -1), "00"), "0")
  }
  customer_storage_prefix = format("%s%s%s%s",
    module.module_context.organization,
    local._customer_storage_prefix.prefix,
    local._customer_storage_prefix.letter,
    local._customer_storage_prefix.number
  )
}

##### Storage Account
### Network File Share
module "context_storage_customer_nfs" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = module.module_context.context

  flags = { override_name = true }

  # NOTE: retaining original name to avoid having to re-deploy, TODO: align naming with other customer storage account
  #name        = "${local.customer_storage_prefix}nfs"
  name        = replace(module.module_context.resource_prefix, "-", "")
  description = "${local.description_prefix} NFS Storage Account"
}

resource "azurerm_storage_account" "customer_nfs" {
  resource_group_name             = azurerm_resource_group.customer.name
  location                        = azurerm_resource_group.customer.location
  name                            = module.context_storage_customer_nfs.name
  tags                            = module.context_storage_customer_nfs.tags
  account_kind                    = "FileStorage"
  account_tier                    = "Premium"
  account_replication_type        = "LRS"
  https_traffic_only_enabled      = var.adv_storage_account_https_only_customer_nfs
  min_tls_version                 = var.adv_min_tls_version
  allow_nested_items_to_be_public = var.adv_allow_nested_items_to_be_public
}

resource "azurerm_storage_account_network_rules" "customer_nfs" {
  depends_on = [azurerm_storage_share.customer_nfs_usr_sap_trans]

  storage_account_id = azurerm_storage_account.customer_nfs.id
  default_action     = "Deny"
  virtual_network_subnet_ids = [
    for key, value in var.vnet_subnets : azurerm_subnet.customer[key].id
  ]

  lifecycle {
    ignore_changes = [
      virtual_network_subnet_ids,
      ip_rules
    ]
  }

  # AZURE LIMITATION:
  #   interacting with the storage shares inside an Azure storage account through the Azure API are subject to these restrictions
  #   ...so Terraform breaks if we don't poke ourselves a hole from wherever we are running Terraform from
  ip_rules = ["${chomp(data.http.my_ip.response_body)}"]
}

# AZURE LIMITATION:
#  This pokes the hole documented above. This happens during `terraform plan` in an unpredictable way, so if you see the typical
#    "AuthorizationFailure" message, run another `terraform plan` and it will be successful.
module "storage_permissions" {
  source = "../../../shared/modules/terraform-external-run-command"

  command = "az storage account network-rule add --resource-group ${azurerm_resource_group.customer.name} --account-name ${azurerm_storage_account.customer_nfs.name} --ip-address ${chomp(data.http.my_ip.response_body)}; sleep 5"
}

data "http" "my_ip" {
  url = "https://checkip.amazonaws.com"
}

### NFS Shares
module "context_storage_customer_nfs_usr_sap_trans" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = module.module_context.context

  name        = "usr-sap-trans"
  description = "${local.description_prefix} NFS share for /usr/sap/trans"
}

resource "azurerm_storage_share" "customer_nfs_usr_sap_trans" {
  depends_on = [azurerm_storage_account.customer_nfs, module.storage_permissions]

  name                 = module.context_storage_customer_nfs_usr_sap_trans.name
  storage_account_name = azurerm_storage_account.customer_nfs.name
  enabled_protocol     = "NFS"
  quota                = var.nfs_storage_quota
}

### Database backups
module "context_storage_customer_backups" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = module.module_context.context

  flags = { override_name = true }

  name        = "${local.customer_storage_prefix}backups"
  description = "${local.description_prefix} Database Backups Storage Account"
}

resource "azurerm_storage_account" "customer_backups" {
  resource_group_name             = azurerm_resource_group.customer.name
  location                        = azurerm_resource_group.customer.location
  name                            = module.context_storage_customer_backups.name
  tags                            = module.context_storage_customer_backups.tags
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  https_traffic_only_enabled      = var.adv_storage_account_https_only_customer_backups
  min_tls_version                 = var.adv_min_tls_version
  allow_nested_items_to_be_public = var.adv_allow_nested_items_to_be_public


  blob_properties {
    versioning_enabled = var.versioning
  }
}

#### Lifecycle policy for Azure Storage Account
resource "azurerm_storage_management_policy" "azure_storage_account_management_policy" {
  storage_account_id = azurerm_storage_account.customer_backups.id

  rule {
    name    = "lifecyclePolicy"
    enabled = var.lifecyeclepolicy
    filters {
      prefix_match = [module.context_storage_container_customer_backups.bucket]
      blob_types   = ["blockBlob"]
    }
    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than    = var.tier_to_cool_days
        tier_to_archive_after_days_since_modification_greater_than = var.tier_to_archive_days
        delete_after_days_since_modification_greater_than          = var.delete_after_days
      }
      version {
        change_tier_to_cool_after_days_since_creation = var.tier_to_cool_days
        delete_after_days_since_creation              = var.delete_after_days
      }
    }
  }
}

module "context_storage_container_customer_backups" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = module.module_context.context

  name        = "backups"
  description = "${local.description_prefix} Database Backups Storage Container"
}

resource "azurerm_storage_container" "customer_backups" {
  storage_account_name = azurerm_storage_account.customer_backups.name
  name                 = module.context_storage_container_customer_backups.bucket
}
