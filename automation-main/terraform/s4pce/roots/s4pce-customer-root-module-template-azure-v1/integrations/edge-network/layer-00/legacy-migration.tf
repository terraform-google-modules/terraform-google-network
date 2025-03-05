/*
  Description: Handles creation of a legacy migration list that will contain terraform "moved"
    blocks. This is to assist in migrating from legacy code, without requiring the recreation
    of resources.
*/

locals {
  legacy_migration_list = templatefile(
    "./legacy-migration-list.tftpl",
    {
      endpoint_list_keys        = keys(local.merged_endpoint_list),
      non_dr_endpoint_list_keys = keys(local.endpoint_list),
      dr_endpoint_list_keys     = keys(local.endpoint_list_filtered),
    }
  )
}

# To create the legacy migration list, run the following command in the CLI:
#   terraform apply -target=local_file.migration_list -var legacy_migration=true
resource "local_file" "migration_list" {
  count = var.legacy_migration ? 1 : 0

  content  = local.legacy_migration_list
  filename = "./legacy-migration-list.tf"
}
