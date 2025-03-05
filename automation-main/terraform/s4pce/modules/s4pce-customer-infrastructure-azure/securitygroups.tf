/*
  Description: Handles Vnet security group creation
*/

##### Global (Network Security Group)
module "context_network_sg_customer_global" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = module.module_context.context

  name        = "global"
  description = "${local.description_prefix} - Global Network Security Group"
}

resource "azurerm_network_security_group" "customer_global" {
  resource_group_name = azurerm_resource_group.customer.name
  location            = azurerm_resource_group.customer.location
  name                = module.context_network_sg_customer_global.name
  tags                = module.context_network_sg_customer_global.tags
}

# Default Rules
module "context_sg_rule_deafult_deny_all" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = module.module_context.context

  name        = "default-deny-all"
  description = "${local.description_prefix} - Default rule at lowest priority to explictly deny all traffic"
}

resource "azurerm_network_security_rule" "customer_default_deny_all" {
  name                        = module.context_sg_rule_deafult_deny_all.name
  description                 = module.context_sg_rule_deafult_deny_all.description
  resource_group_name         = azurerm_resource_group.customer.name
  network_security_group_name = azurerm_network_security_group.customer_global.name
  priority                    = 4096
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
}

module "context_sg_rule_default_load_balancer_allow" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = module.module_context.context

  name        = "load-balancer-allow"
  description = "${local.description_prefix} - Default rule to ensure AzureLoadBalancer functions"
}

resource "azurerm_network_security_rule" "customer_default_load_balancer_allow" {
  name                        = module.context_sg_rule_default_load_balancer_allow.name
  description                 = module.context_sg_rule_default_load_balancer_allow.description
  resource_group_name         = azurerm_resource_group.customer.name
  network_security_group_name = azurerm_network_security_group.customer_global.name
  priority                    = 4095
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "AzureLoadBalancer"
  destination_address_prefix  = "VirtualNetwork"
}


####### Application Security Groups
##### Egress All
module "context_application_sg_customer_egress_all" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = module.module_context.context

  name        = "egress-all"
  description = "${local.description_prefix} - Allows all egress traffic"
}

resource "azurerm_application_security_group" "customer_egress_all" {
  resource_group_name = azurerm_resource_group.customer.name
  location            = azurerm_resource_group.customer.location
  name                = module.context_application_sg_customer_egress_all.name
  tags                = module.context_application_sg_customer_egress_all.tags
}

### Rules
resource "azurerm_network_security_rule" "customer_egress_all" {
  name                        = module.context_application_sg_customer_egress_all.name
  description                 = module.context_application_sg_customer_egress_all.description
  resource_group_name         = azurerm_resource_group.customer.name
  network_security_group_name = azurerm_network_security_group.customer_global.name
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
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = module.module_context.context

  name        = "vnet-all"
  description = "${local.description_prefix} - Allows all inter-Vnet ingress/egress traffic rules"
}

resource "azurerm_application_security_group" "customer_vnet_all" {
  resource_group_name = azurerm_resource_group.customer.name
  location            = azurerm_resource_group.customer.location
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
  description                 = "${local.description_prefix} - Allows all inter-Vnet ${each.key} traffic"
  resource_group_name         = azurerm_resource_group.customer.name
  network_security_group_name = azurerm_network_security_group.customer_global.name
  priority                    = 2010
  direction                   = each.value
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefixes     = azurerm_virtual_network.customer.address_space

  destination_application_security_group_ids = [
    azurerm_application_security_group.customer_vnet_all.id
  ]
}
