/*
  Description: Outputs from this module; Contains commonly used outputs needed by other modules and dependent automation
  Comments: N/A
*/

output "endpoint_services" {
  value = { for k, v in local.sftp_list : k => module.lb[k].endpoint_services }
}

output "endpoints" {
  value = { for k, v in local.sftp_list : k => module.lb[k].endpoints }
}

output "vmss_private_ips" {
  value = { for k, v in local.sftp_list : k => module.sftp_pool[k].vmss_private_ips }
}

locals {
  endpoints = templatefile(
    "./azure-dynamic-inventory.tpl",
    {
      customer_name            = local.layer_00.infrastructure.resource_group_customer.name
      customer_resource_group  = local.layer_00.infrastructure.resource_group_customer.name
      customer_storage_account = local.layer_00.infrastructure.nfs_storage_account.name
      customer_sftp_nfs        = azurerm_storage_share.sftp_nfs[0].name
    }
  )
}
resource "local_file" "inventory_file" {
  content  = local.endpoints
  filename = "/tmp/cre-${local.base_context.customer}-sftp-azure_rm.yml"
}


locals {
  sftp = { for k, v in local.sftp_list : "sftp-${k}" => module.lb[k].endpoints.sftp_service.private_ip_address }

  sftp_endpoints = templatefile(
    "./output-endpoints.tpl",
    { endpoint_list = local.sftp
    }
  )
}

resource "local_file" "sftp_mapping" {
  content  = local.sftp_endpoints
  filename = "/tmp/sftp-cname-mappings-${local.base_context.customer}.md"
}
