/*
  Description: Create Windows Virtual Machines in the customer VNet
  Comments:
    Current Terraform module does not support Azure Windows VMs
*/


locals {
  instance_list_windows_only = {
    for key, value in var.instance_list : key => value if lookup(value, "os", "") == "windows"
  }
}

# windows_instance
resource "random_id" "windows_instance" {
  for_each = local.instance_list_windows_only
  prefix   = each.key
  # Generate a new ID if any of these values change.
  byte_length = 8

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_network_interface" "windows_instance" {
  for_each            = local.instance_list_windows_only
  location            = local.layer_00.infrastructure.resource_group_customer.location
  resource_group_name = local.layer_00.infrastructure.resource_group_customer.name
  name                = replace(random_id.windows_instance[each.key].hex, "/", "-")
  tags                = module.context_instance_list[each.key].tags

  ip_configuration {
    name                          = replace(random_id.windows_instance[each.key].hex, "/", "-")
    subnet_id                     = local.layer_00.infrastructure.subnets[lower(each.value.landscape)].id
    private_ip_address_allocation = "Dynamic"
  }

  lifecycle {
    ignore_changes = [
      tags["ProvisionDate"],
    ]
  }
}


locals {
  flat_security_group_association = flatten([
    for network_key, network_value in azurerm_network_interface.windows_instance : [
      for sg_key, sg_value in local.layer_00.infrastructure.vm_base_security_groups : {
        network_interface_id          = network_value.id
        application_security_group_id = sg_value
        instance_key                  = network_key
        sg_key                        = sg_key
      }
    ]
  ])
  security_group_associations = {
    for association in local.flat_security_group_association : "${association.instance_key}.${association.sg_key}" => association
  }
}
resource "azurerm_network_interface_application_security_group_association" "windows_instance" {
  for_each = local.security_group_associations

  network_interface_id          = each.value.network_interface_id
  application_security_group_id = each.value.application_security_group_id
}

resource "azurerm_windows_virtual_machine" "windows_instance" {
  for_each                   = local.instance_list_windows_only
  name                       = replace(random_id.windows_instance[each.key].hex, "/", "-")
  computer_name              = substr(replace(random_id.windows_instance[each.key].hex, "/", "-"), -15, 15)
  location                   = local.layer_00.infrastructure.resource_group_customer.location
  resource_group_name        = local.layer_00.infrastructure.resource_group_customer.name
  zone                       = local.instance_list_metadata[each.key].subnet.zone
  size                       = each.value.instance_type
  admin_username             = "cloud-user"
  admin_password             = var.windows_admin_password
  encryption_at_host_enabled = true
  tags                       = module.context_instance_list[each.key].tags
  network_interface_ids = [
    azurerm_network_interface.windows_instance[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = "500"
  }

  identity {
    type = "SystemAssigned"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  lifecycle {
    ignore_changes = [
      admin_password,
      source_image_id,
      custom_data,
      tags["ProvisionDate"],
    ]
  }
}
# End windows_instance


locals {
  output_windows_instance = {
    for key, value in local.instance_list_windows_only : key => {
      name                               = azurerm_windows_virtual_machine.windows_instance[key].name
      id                                 = azurerm_windows_virtual_machine.windows_instance[key].id
      virtual_machine_id                 = azurerm_windows_virtual_machine.windows_instance[key].virtual_machine_id
      public_ip                          = azurerm_windows_virtual_machine.windows_instance[key].public_ip_address
      private_ip                         = azurerm_windows_virtual_machine.windows_instance[key].private_ip_address
      availability_zone                  = azurerm_windows_virtual_machine.windows_instance[key].zone
      network_interface_id               = azurerm_network_interface.windows_instance[key].id
      network_interface_ip_configuration = azurerm_network_interface.windows_instance[key].ip_configuration
      tags                               = azurerm_windows_virtual_machine.windows_instance[key].tags
    }
  }
}
