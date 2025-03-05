/*
  Description: Create Security Group(s)
*/

##### Security Group with default out-of-the-box inbound and outbound firewall rules
resource "azurerm_network_security_group" "main01" {
  resource_group_name = local.layer_00.infrastructure.resource_group_customer.name
  location            = local.layer_00.infrastructure.resource_group_customer.location
  name                = "${module.layer_context.resource_prefix}-default"
  tags = merge(module.layer_context.tags, {
    Name        = module.layer_context.resource_prefix
    Description = "${module.layer_context.environment_values.kv.prefix_friendly_name} Security Group - Allow ingress/egress traffic"
  })
}


####### Application Security Groups
##### Egress All
module "context_application_sg_customer_egress_all" {
  source      = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context     = module.layer_context.context
  build_user  = var.build_user
  name        = "egress-all"
  description = "Allows all egress traffic"
}

resource "azurerm_application_security_group" "customer_egress_all" {
  resource_group_name = local.layer_00.infrastructure.resource_group_customer.name
  location            = local.layer_00.infrastructure.resource_group_customer.location
  name                = module.context_application_sg_customer_egress_all.name
  tags                = module.context_application_sg_customer_egress_all.tags
}

### Rules
resource "azurerm_network_security_rule" "customer_egress_all" {
  name                        = module.context_application_sg_customer_egress_all.name
  description                 = module.context_application_sg_customer_egress_all.description
  resource_group_name         = local.layer_00.infrastructure.resource_group_customer.name
  network_security_group_name = azurerm_network_security_group.main01.name
  priority                    = 2000
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"

  destination_application_security_group_ids = [
    azurerm_application_security_group.customer_egress_all.id
  ]
}


##### Inter-Vnet All
module "context_application_sg_customer_vnet_all" {
  source      = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context     = module.layer_context.context
  build_user  = var.build_user
  name        = "vnet-all"
  description = "Allows all inter-Vnet ingress/egress traffic rules"
}

resource "azurerm_application_security_group" "customer_vnet_all" {
  resource_group_name = local.layer_00.infrastructure.resource_group_customer.name
  location            = local.layer_00.infrastructure.resource_group_customer.location
  name                = module.context_application_sg_customer_vnet_all.name
  tags                = module.context_application_sg_customer_vnet_all.tags
}

### Rules
locals {
  customer_vnet_all_rules = {
    ingress = "Inbound"
    egress  = "Outbound"
  }
}

resource "azurerm_network_security_rule" "customer_vnet_all_ingress" {
  for_each = local.customer_vnet_all_rules

  name                        = "${module.context_application_sg_customer_vnet_all.name}-${each.key}"
  description                 = "Allows all inter-Vnet ${each.key} traffic"
  resource_group_name         = local.layer_00.infrastructure.resource_group_customer.name
  network_security_group_name = azurerm_network_security_group.main01.name
  priority                    = 2010
  direction                   = each.value
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = var.vnet_cidr_block

  destination_application_security_group_ids = [
    azurerm_application_security_group.customer_vnet_all.id
  ]
}
