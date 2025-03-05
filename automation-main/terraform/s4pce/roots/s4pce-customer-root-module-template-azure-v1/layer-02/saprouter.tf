/*
  Description: SAP Router Resources
  Layer: 02
  Dependencies:
    layer-00: outputs
*/

locals {
  # Parse the instance list and creates a new list of instances that have `endpoint_port_list` defined
  instance_list_saprouter = { for key, value in var.instance_list : key => value if contains(["router"], value.productname) }
  deploy_saprouter        = length(local.instance_list_saprouter) > 0 ? 1 : 0
}


##### SAP Router Security Group
module "context_application_sg_saprouter" {
  source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context     = module.layer_context.context
  build_user  = var.build_user
  name        = "saprouter"
  description = "Allows ingress from IPs in var.saprouter_ingress_cidr to saprouter"
}

resource "azurerm_application_security_group" "support_saprouter" {
  resource_group_name = local.layer_00.infrastructure.resource_group_customer.name
  location            = local.layer_00.infrastructure.resource_group_customer.location
  name                = module.context_application_sg_saprouter.name
  tags                = module.context_application_sg_saprouter.tags
}

resource "azurerm_network_security_rule" "support_saprouter_ingress" {
  name                        = module.context_application_sg_saprouter.name
  description                 = module.context_application_sg_saprouter.description
  resource_group_name         = local.layer_00.infrastructure.resource_group_customer.name
  network_security_group_name = local.layer_00.infrastructure.network_security_group_customer_global.name
  priority                    = 2020
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefixes     = var.saprouter_ingress_cidr

  destination_application_security_group_ids = [
    azurerm_application_security_group.support_saprouter.id
  ]
}
##### End Security Group



##### SAPRouter instance
module "instance_saprouter" {
  source   = "EXAMPLE_SOURCE/terraform/shared/modules/azure-linux-virtual-machine"
  for_each = local.instance_list_saprouter
  context  = module.context_instance_list[each.key].context
  ### MANDATORY values. These must be specified when calling module
  name                      = lower(each.key)
  location                  = local.layer_00.infrastructure.resource_group_customer.location
  resource_group_name       = local.layer_00.infrastructure.resource_group_customer.name
  search_image_name         = local.instance_list_metadata[each.key].image
  image_resource_group_name = local.layer_00.golden_image_resource_group
  public_key                = local.layer_00.ssh_customer_public_key
  subnet_id                 = local.layer_00.infrastructure.subnets["edge"].id
  zone                      = local.layer_00.infrastructure.subnets["edge"].zone
  ### Optional values. Values specified below have defaults or will be ignored if not passed by calling module.
  size                                 = each.value.instance_type
  application_security_groups          = merge(local.layer_00.infrastructure.vm_base_security_groups, tomap({ (local.layer_00.infrastructure.network_security_group_customer_global.name) = azurerm_application_security_group.support_saprouter.id }))
  system_assigned_identity_permissions = local.layer_01.vm_base_roles
  os_disk_storage_account_type         = local.instance_list_metadata[each.key].disk_type
  # DNS Variables
  dns_associate_private_ip_address = local.layer_00.infrastructure.private_dns_enabled
  dns_zone                         = lookup(local.layer_00.infrastructure, "private_dns_zone", null)
  dns_associate_cname              = true
  dns_additional_cnames            = concat(lookup(each.value, "cnames", []), [])
  # Network variables
  associate_static_public_ip_address = true
  associate_public_ip_address        = true
}

##### End Instance
