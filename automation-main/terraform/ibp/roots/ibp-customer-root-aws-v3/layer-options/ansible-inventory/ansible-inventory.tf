
##### Ansible Template Variables
variable "inventory_vars" {
  description = "Additional variables used to generate Ansible Inventory"
  type = object({
    staging_sid           = string
    production_sid        = string
    customer_number       = string
    input_hostfile_fqdn   = string
    webdispatcher_release = string
    cpids_release         = string
    prod_release          = string
    nonprod_release       = string
  })
  default = {
    staging_sid           = "___EXAMPLE_99___"
    production_sid        = "___EXAMPLE_99___"
    customer_number       = "___EXAMPLE_99___"
    input_hostfile_fqdn   = "___EXAMPLE.IBP.REGION.SCS.INTERNAL___"
    webdispatcher_release = "___EXAMPLE_WDISP_REL99_PL99_TAR_V99___"
    cpids_release         = "___EXAMPLE_GOLD-PRD-CPIDS-DSOD-9.9.99.99-TAR-V99___"
    prod_release          = "___EXAMPLE_GOLD-PRD-9999-HFC99-EP99-TAR-V1___"
    nonprod_release       = "___EXAMPLE_GOLD-NONPRD-9999-HFC99-EP99-TAR-V1___"
  }
}

locals {
  endpoints = templatefile(
    "./ansible-inventory.tpl",
    {
      customer           = local.layer_00_outputs._context.customer
      efs_staging_ip     = local.management_layer_01_outputs.efs_common_staging.ip_address["1a"]
      efs_usrsaptrans_ip = local.layer_01_outputs.efs_customer_usr_sap_trans_ip_1a
      aws_region         = local.layer_00_outputs._context.region
      instance_map       = local.layer_02_outputs.instance_map
      cpids_alb_cname    = local.layer_02_outputs.loadbalancer_cert_fqdn
      inventory_vars     = var.inventory_vars
    }
  )
}

resource "local_file" "file_content" {
  content  = local.endpoints
  filename = "./${local.layer_00_outputs._context.customer}-inventory.yml"
}
output "zzz_ansible_inventory" { value = "File written to ./${local.layer_00_outputs._context.customer}-inventory.yml" }
