/*
  Description: Resources for Customer Connectivity.
  Comments:
*/

### Gateway Subnets
# NOTE: See link for name requirements: https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-vpn-faq#do-i-need-a-gatewaysubnet
resource "azurerm_subnet" "gateway01" {
  count                             = var.adv_no_customer_gateway ? 0 : 1
  resource_group_name               = local.layer_00.infrastructure.resource_group_customer.name
  virtual_network_name              = azurerm_virtual_network.main01.name
  name                              = "GatewaySubnet"
  address_prefixes                  = [var.subnet_gateway_cidr_block]
  private_endpoint_network_policies = "Enabled"
}

resource "azurerm_public_ip" "gateway01" {
  count               = var.adv_no_customer_gateway ? 0 : 1
  resource_group_name = local.layer_00.infrastructure.resource_group_customer.name
  location            = local.layer_00.infrastructure.resource_group_customer.location
  name                = module.layer_context.resource_prefix
  tags = merge(module.context_vnet_main01.tags, {
    Name        = "${module.context_vnet_main01.resource_prefix}-gateway-public-ip"
    Description = "${module.context_vnet_main01.environment_values.kv.vnet_friendly_name} Public IP for VPN Gateway"
  })
  allocation_method = "Static"
  sku               = "Standard"
  zones             = local.layer_00.unique_zones
}

resource "azurerm_virtual_network_gateway" "virtualnetworkgateway01" {
  count               = var.adv_no_customer_gateway ? 0 : 1
  name                = "${local.base_context.customer}-vng"
  location            = local.layer_00.infrastructure.resource_group_customer.location
  resource_group_name = local.layer_00.infrastructure.resource_group_customer.name

  type       = "Vpn"
  vpn_type   = "RouteBased"
  generation = "Generation2"

  active_active = false
  enable_bgp    = true
  sku           = var.vng_sku

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.gateway01[0].id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway01[0].id
  }

  bgp_settings {
    asn = var.vng_asn
  }
}
