/*
  Description: Handles Vnet security group creation
  Comment:
    To imitate AWS style security,
      * NSG is created for the overall VNET which imitates ACLs.
      * ASGs are created to imitate AWS Style Security Groups.  Remember to associate instances to the ASGs
*/

###### Network Security Groups
resource "random_id" "azurerm_network_security_group" {
  byte_length = 8
}
resource "time_static" "azurerm_network_security_group" {
  triggers = {
    random_id  = random_id.azurerm_network_security_group.hex
    build_user = var.build_user
  }
  lifecycle {
    ignore_changes = [triggers["build_user"]]
  }
}
locals {
  tags_nsg = merge(var.tags, {
    BuildUser     = time_static.azurerm_network_security_group.triggers.build_user
    ProvisionDate = time_static.azurerm_network_security_group.rfc3339
  })
}
resource "azurerm_network_security_group" "main01" {
  resource_group_name = azurerm_resource_group.main01.name
  location            = azurerm_resource_group.main01.location
  name                = random_id.azurerm_network_security_group.hex
  tags                = local.tags_nsg
}
resource "azurerm_network_security_rule" "customer_default_deny_all" {
  name                        = "default-deny-all"
  description                 = "Default rule at lowest priority to explictly deny all traffic"
  resource_group_name         = azurerm_resource_group.main01.name
  network_security_group_name = azurerm_network_security_group.main01.name
  priority                    = 4096
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
}
resource "azurerm_network_security_rule" "customer_default_load_balancer_allow" {
  name                        = "load-balancer-allow"
  description                 = "Default rule to ensure AzureLoadBalancer functions"
  resource_group_name         = azurerm_resource_group.main01.name
  network_security_group_name = azurerm_network_security_group.main01.name
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
locals {
  security_groups = ["base_ingress", "base_egress"]
}
resource "random_id" "azurerm_application_security_group" {
  for_each    = toset(local.security_groups)
  byte_length = 8
}
resource "time_static" "azurerm_application_security_group" {
  for_each = toset(local.security_groups)
  triggers = {
    random_id  = random_id.azurerm_application_security_group[each.key].hex
    build_user = var.build_user
  }
  lifecycle {
    ignore_changes = [triggers["build_user"]]
  }
}
locals {
  tags_asg = { for key in local.security_groups : key => merge(var.tags, {
    BuildUser     = time_static.azurerm_application_security_group[key].triggers.build_user
    ProvisionDate = time_static.azurerm_application_security_group[key].rfc3339
    Description   = key
  }) }
}
resource "azurerm_application_security_group" "main01" {
  for_each            = toset(local.security_groups)
  resource_group_name = azurerm_resource_group.main01.name
  location            = azurerm_resource_group.main01.location
  name                = random_id.azurerm_application_security_group[each.key].hex
  tags                = local.tags_asg[each.key]
}


### Rules
# NOTE: source_address_prefix vs source_address_prefixes.  The latter requires each value be in the same class.
locals {
  cidr_blocks = [for block in azurerm_virtual_network.main01.address_space : {
    cidr = block
    name = replace(replace(block, "/", "-"), ":", "")
  }]
  default_asg_security_rules = var.use_default_security_rules ? merge(
    {
      egress-all = {
        priority  = 2000
        direction = "Outbound"
        asg       = "base_egress"
    } },
    { for block in local.cidr_blocks : "ingress-intranet-${block.name}" => {
      priority              = "${2010 + index(local.cidr_blocks, block)}"
      direction             = "Inbound"
      asg                   = "base_ingress"
      source_address_prefix = block.cidr
    } },
    { for block in local.cidr_blocks : "egress-intranet-${block.name}" => {
      priority              = "${2010 + index(local.cidr_blocks, block)}"
      direction             = "Outbound"
      asg                   = "base_egress"
      source_address_prefix = block.cidr
    } },
  ) : {}
}

resource "azurerm_network_security_rule" "default_security_rules" {
  for_each                    = local.default_asg_security_rules
  name                        = each.key
  description                 = lookup(each.value, "description", each.key)
  resource_group_name         = azurerm_resource_group.main01.name
  network_security_group_name = azurerm_network_security_group.main01.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = "Allow"
  protocol                    = lookup(each.value, "protocol", "*")
  source_port_range           = lookup(each.value, "source_port_range", "*")
  destination_port_range      = lookup(each.value, "destination_port_range", "*")
  source_address_prefix       = lookup(each.value, "source_address_prefix", "*")
  destination_application_security_group_ids = [
    azurerm_application_security_group.main01[each.value.asg].id
  ]
}

###### Security Groups
### Network
output "network_security_group" { value = {
  id   = azurerm_network_security_group.main01.id
  name = azurerm_network_security_group.main01.name
} }
output "application_security_group" { value = {
  for key in local.security_groups : key => {
    id   = azurerm_application_security_group.main01[key].id
    name = azurerm_application_security_group.main01[key].name
  }
} }
output "application_security_rules" { value = local.default_asg_security_rules }
