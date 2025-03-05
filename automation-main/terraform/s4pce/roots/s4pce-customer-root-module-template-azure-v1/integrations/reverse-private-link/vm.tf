/*
  Description: VM forwarding traffic to on-prem endpoints
  Comments:
    - N/A
*/

#create VM with module
module "proxy_vm" {
  source              = "../EXAMPLE_SOURCE/terraform/shared/modules/azure-linux-virtual-machine"
  context             = module.layer_context.context
  for_each            = var.reverse_private_link_list
  name                = "${local.base_context.customer}-${each.key}-vm"
  resource_group_name = local.layer_00.infrastructure.resource_group_customer.name
  location            = local.layer_00.infrastructure.resource_group_customer.location

  ### MANDATORY values. These must be specified when calling module
  search_image_name         = var.image_proxy
  image_resource_group_name = local.layer_00.golden_image_resource_group
  public_key                = local.layer_00.ssh_customer_public_key
  subnet_id                 = local.layer_00_edge.subnet_main01.id
  zone                      = null
  adv_public_ip_zones       = local.layer_00.unique_zones
  ### Optional values. Values specified below have defaults or will be ignored if not passed by calling module.
  size                         = "Standard_D2ds_v4"
  os_disk_storage_account_type = "Standard_LRS"
  tag_productname              = "proxy-server"
  tag_description              = "proxy-server-for-${each.value.ip_address}"
  #no DNS record
  dns_associate_cname = false
  #create static public ip
  associate_public_ip_address        = true
  associate_static_public_ip_address = true
  bootstrap_enable                   = true
  custom_bootstrap = var.enable_proxy ? base64encode(templatefile("./template/envoy.tftpl", {
    custom_nameservers = var.envoy_proxy_values.custom_nameservers
    app_keyid          = var.envoy_proxy_values.app_keyid
    app_repo           = var.envoy_proxy_values.app_repo
    app_branch         = var.envoy_proxy_values.app_branch
    app_package        = var.envoy_proxy_values.app_package
    ip                 = keys(local.ip_port_list[each.key])[0]
    ports              = values(local.ip_port_list[each.key])[0]
    })) : base64encode(templatefile("./template/iptables.tftpl", {
    list = local.ip_port_list[each.key]
  }))
}

locals {
  #generate ip port list for VM cloud-init template input
  ip_port_list = { for k, v in var.reverse_private_link_list : k => { (v.ip_address) : v.port_list } }
}
