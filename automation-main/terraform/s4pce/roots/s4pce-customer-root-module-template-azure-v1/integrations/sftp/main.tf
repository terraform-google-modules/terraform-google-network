/*
  Description: Core module configurations; Core data resources, base context, global local variables, etc
  Comments:
    - N/A
*/

### Core Data Resources
data "azurerm_subscription" "current" {}

### Local Variables
locals {
  base_context = local.layer_00.base_context

  sftp_list = { for e1 in distinct([
    for e in local.layer_02.raw_instance_list : {
      landscape          = lower(e.landscape)
      spr_sftp_efs_mount = replace(lower(e.spr_interfaces_efs_mount), "_", "-")
      sid                = lower(e.sid)
    } if lookup(e, "spr_interfaces_efs_mount", "") != ""]) :
    var.adv_use_v1_naming ?
    e1.sid :
    "${e1.landscape}-${e1.spr_sftp_efs_mount}"
  => e1 }
}

module "layer_context" {
  source     = "../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context    = local.base_context
  customer   = "${local.base_context.customer}-sftp"
  build_user = var.build_user
  environment_values = {
    kv = {
      deployment_layer     = "sftp"
      tag_productcomponent = "SFTP"
    }
    tags   = null
    locals = null
  }
}

#create LB, private services and links
module "lb" {
  for_each            = local.sftp_list
  source              = "../EXAMPLE_SOURCE/terraform/s4pce/modules/azure-endpoint-services-multiport"
  context             = module.layer_context.context
  resource_group_name = local.layer_00.infrastructure.resource_group_customer.name
  location            = local.layer_00.infrastructure.resource_group_customer.location
  front_end_ip_zones  = local.layer_00.lb_front_end_ip_zones == "Zone-Redundant" ? local.layer_00.unique_zones : [local.layer_00.lb_front_end_ip_zones]
  adv_lb_no_zone      = var.adv_lb_no_zone

  loadbalancer_subnet_id          = local.layer_00.infrastructure.subnets[each.value.landscape].id
  private_link_service_subnet_id  = local.layer_00.infrastructure.subnets[each.value.landscape].id
  private_link_endpoint_subnet_id = local.layer_edge_net.subnet_main01.id


  loadbalancer_name = "${module.layer_context.resource_prefix}-lb-${each.key}"
  loadbalancer_frontendip_private_link_map = {
    sftp_service = {
      loadbalancer_frontend_ip_name = "sftp_ip-${each.key}"
      private_link_service_name     = "sftp-private-link-service-${each.key}"
      private_endpoint_name         = "sftp-private-link-endpoint-${each.key}"
    },
  }
  loadbalancer_backend_pool_names = ["sftp-pool"]

  loadbalancer_port = {
    sftp-rule = ["8022", "Tcp", "8022", "sftp-pool", "sftp_service"]
  }
  loadbalancer_probe = {
    sftp-probe = ["Tcp", "8022", ""]
  }
}

module "sftp_pool" {
  for_each            = local.sftp_list
  source              = "../EXAMPLE_SOURCE/terraform/shared/modules/terraform-azure-vm-scale-sets"
  prefix              = module.layer_context.resource_prefix
  resource_group_name = local.layer_00.infrastructure.resource_group_customer.name
  location            = local.layer_00.infrastructure.resource_group_customer.location

  image_resource_group_name = local.layer_00.golden_image_resource_group
  search_image_name         = var.search_image_name

  vnet_id                            = local.layer_00.infrastructure.vnet_customer.id
  subnet_id                          = local.layer_00.infrastructure.subnets[each.value.landscape].id
  vnet_resource_group_name           = local.layer_00.infrastructure.resource_group_customer.name
  existing_network_security_group_id = local.layer_00.infrastructure.network_security_group_customer_global.id
  application_security_group_ids     = values(local.layer_00.infrastructure.vm_base_security_groups)

  vmscaleset_name      = var.adv_use_v1_naming ? each.value.sid : each.value.landscape
  virtual_machine_size = var.virtual_machine_size
  admin_username       = var.admin_username
  instances_count      = max(length(local.layer_00.unique_zones), 2)
  disk_size_gb         = 200
  availability_zones   = null
  //use the first backend_pool and health probe from LB moduel
  health_probe_id                        = module.lb[each.key].azurerm_loadbalancer_probe_ids[0]
  load_balancer_backend_address_pool_ids = module.lb[each.key].azurerm_lb_backend_address_pool_ids

  tags = merge(module.layer_context.tags, { sftp_mnt_dir = each.value.spr_sftp_efs_mount,
  spr_landscape : each.value.landscape })
  admin_ssh_key_data                  = local.layer_00.ssh_customer_public_key
  assign_public_ip_to_each_vm_in_vmss = false #no public ip as we can provsion them with VPN access
  #need to have this, implicit dependency not working
  depends_on = [module.lb]
}

#storage account for sftp
resource "azurerm_storage_share" "sftp_nfs" {
  count                = length(keys(local.sftp_list)) > 0 ? 1 : 0
  name                 = "${local.layer_00.infrastructure.resource_group_customer.name}-usr-sap-interface"
  storage_account_name = local.layer_00.infrastructure.nfs_storage_account.name
  enabled_protocol     = "NFS"
  quota                = 100
}
