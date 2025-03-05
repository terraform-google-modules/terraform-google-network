/*
  Description: Test NSG to allow any tcp/icmp.
  Comment:
*/
resource "azurerm_network_security_group" "nsg" {
  location            = module.network.lb_vnet_location
  name                = "default-nsg"
  resource_group_name = local.resource_group_name

  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  security_rule {
    access                     = "Allow"
    description                = "allowallin"
    destination_address_prefix = "*"
    destination_port_range     = "*"
    direction                  = "Inbound"
    name                       = "TcpAllowAny-in"
    priority                   = "2000"
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
  }

  security_rule {
    access                     = "Allow"
    description                = "allowallin2"
    destination_address_prefix = "*"
    destination_port_range     = "*"
    direction                  = "Inbound"
    name                       = "TcpAllowAny-icmp"
    priority                   = "2001"
    protocol                   = "Icmp"
    source_address_prefix      = "*"
    source_port_range          = "*"
  }
  security_rule {
    access                     = "Allow"
    description                = "allowallout"
    destination_address_prefix = "*"
    destination_port_range     = "*"
    direction                  = "Outbound"
    name                       = "TcpAllowAny-out"
    priority                   = "2000"
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
  }
}
