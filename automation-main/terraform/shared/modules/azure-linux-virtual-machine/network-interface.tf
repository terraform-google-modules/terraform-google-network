/*
  Description: Create Network Interface
*/

### Create Public IP if requested
resource "azurerm_public_ip" "instance" {
  count = var.associate_public_ip_address == true ? 1 : 0

  resource_group_name = var.resource_group_name
  location            = var.location
  name                = replace(random_id.instance.hex, "/", "-")
  tags                = local.tags
  allocation_method   = var.associate_static_public_ip_address == true ? "Static" : "Dynamic"
  sku                 = "Standard"
  zones               = var.zone != null ? [var.zone] : var.adv_public_ip_zones
}

### Create Network Interface
resource "azurerm_network_interface" "instance" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = replace(random_id.instance.hex, "/", "-")
  tags                = local.tags
  lifecycle {
    ignore_changes = [
      tags["Image"],
    ]
  }

  ip_configuration {
    name                          = replace(random_id.instance.hex, "/", "-")
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.static_private_ip_address != null ? "Static" : "Dynamic"
    private_ip_address            = var.static_private_ip_address
    public_ip_address_id          = var.associate_public_ip_address == true ? azurerm_public_ip.instance[0].id : null
  }
}

### Security Group Associations
# Network
resource "azurerm_network_interface_security_group_association" "instance" {
  count = var.network_security_group_id != null ? 1 : 0

  network_interface_id      = azurerm_network_interface.instance.id
  network_security_group_id = var.network_security_group_id
}

# Application
resource "azurerm_network_interface_application_security_group_association" "instance" {
  for_each = var.application_security_groups

  network_interface_id          = azurerm_network_interface.instance.id
  application_security_group_id = each.value
}
