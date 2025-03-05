/*
  Description: Manages network storage and network file shares
*/


### Ensure Customer Subnets can access Hana /staging EFS
locals {
  customer_nfs_subnets = concat(
    [
      for subnet in local.layer_00.infrastructure.subnets : subnet.id
    ]
  )
}
module "azurerm_storage_account_network_rules_subnets_management_nfs" {
  source   = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-azure-storage-account-network-rules-subnet"
  for_each = toset(local.customer_nfs_subnets)

  resource_group       = local.management_layer_00.resource_group_management.name
  storage_account_name = local.management_layer_01.nfs_storage_account.name
  subnet_id            = each.key
}
