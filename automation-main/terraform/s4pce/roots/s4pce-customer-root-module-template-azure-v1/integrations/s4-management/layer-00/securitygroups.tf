/*
  Description: Handles modification of VNet security group rules
*/

resource "azurerm_network_security_rule" "management_to_customer" {
  name                                       = "${local.management_layer_00.vnet_management.name}--${local.layer_00.infrastructure.vnet_customer.name}"
  description                                = "Allows ingress traffic from VNets in ${local.management_layer_00.vnet_management.name}"
  resource_group_name                        = local.layer_00.infrastructure.resource_group_customer.name
  network_security_group_name                = local.layer_00.infrastructure.network_security_group_customer_global.name
  priority                                   = 500
  direction                                  = "Inbound"
  access                                     = "Allow"
  protocol                                   = "*"
  source_port_range                          = "*"
  destination_port_range                     = "*"
  source_address_prefixes                    = local.management_layer_00.vnet_management.cidrs
  destination_application_security_group_ids = [local.layer_00.infrastructure.security_group_customer_vnet_all.id]
}

resource "azurerm_network_security_rule" "customer_to_management" {
  name                         = "${local.layer_00.infrastructure.vnet_customer.name}--${local.management_layer_00.vnet_management.name}"
  description                  = "Allows egress traffic from customer VNet to ${local.management_layer_00.vnet_management.name}"
  resource_group_name          = local.layer_00.infrastructure.resource_group_customer.name
  network_security_group_name  = local.layer_00.infrastructure.network_security_group_customer_global.name
  priority                     = 501
  direction                    = "Outbound"
  access                       = "Allow"
  protocol                     = "*"
  source_port_range            = "*"
  destination_port_range       = "*"
  source_address_prefixes      = local.layer_00.infrastructure.vnet_customer.cidrs
  destination_address_prefixes = local.management_layer_00.vnet_management.cidrs
}
