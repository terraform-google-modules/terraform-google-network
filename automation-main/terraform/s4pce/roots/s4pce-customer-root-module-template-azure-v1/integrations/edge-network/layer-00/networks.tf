/*
  Description: Create Virtual Network(s)
*/

##### VNets
module "context_vnet_main01" {
  source      = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context     = module.layer_context.context
  build_user  = var.build_user
  label_order = concat(module.layer_context.label_order, ["vnet"])

  environment_values = {
    kv = {
      vnet               = module.layer_context.resource_prefix
      vnet_friendly_name = "${module.layer_context.environment_values.kv.prefix_friendly_name} Edge"
    }
    tags = [
      { name = "VNet", value = "vnet", required = true }
    ]
    locals = null
  }
}

resource "azurerm_virtual_network" "main01" {
  resource_group_name = local.layer_00.infrastructure.resource_group_customer.name
  location            = local.layer_00.infrastructure.resource_group_customer.location
  name                = module.layer_context.resource_prefix
  address_space = [
    var.vnet_cidr_block
  ]
  tags = merge(module.context_vnet_main01.tags, {
    Name        = module.context_vnet_main01.resource_prefix
    Description = "${module.context_vnet_main01.environment_values.kv.vnet_friendly_name} VNet"
  })
}
