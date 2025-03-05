/*
  Description: Core module configurations; Core data resources, base context, global local variables, etc
  Comments: Uncomment and add public key to deploy virtual machines for testing.

*/



# locals {
#   public_key = ""
#   # RHEL 8.8
#   # vm_image = "/subscriptions/ec477f00-3632-495f-8a99-3ad5568024d8/resourceGroups/build-images-usgovvirginia-3ad5568024d8/providers/Microsoft.Compute/images/Golden-SCS-RHEL-8.8-Base-V15.0"
#   # RHEL 9.2
#   # vm_image = "/subscriptions/ec477f00-3632-495f-8a99-3ad5568024d8/resourceGroups/build-images-usgovvirginia-3ad5568024d8/providers/Microsoft.Compute/images/Golden-SCS-RHEL-9.2-Base-V6.0"
#   vm_image = ""

# }

# resource "random_id" "instance" {
#   byte_length = 8
# }


# resource "azurerm_public_ip" "instance" {
#   count               = 1
#   resource_group_name = module.module_test.resource_group_main01.name
#   location            = module.module_test.resource_group_main01.location
#   name                = replace(random_id.instance.hex, "/", "-")
#   tags                = local.tags
#   allocation_method   = "Static"
#   sku                 = "Standard"
#   zones               = ["1"]
# }
# resource "azurerm_network_interface" "instance" {
#   resource_group_name = module.module_test.resource_group_main01.name
#   location            = module.module_test.resource_group_main01.location
#   name                = replace(random_id.instance.hex, "/", "-")
#   tags                = local.tags
#   ip_configuration {
#     name                          = replace(random_id.instance.hex, "/", "-")
#     subnet_id                     = module.module_test.subnets["zone_1"].id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.instance[0].id
#   }
# }
# resource "azurerm_network_interface_security_group_association" "instance" {
#   count                     = 1
#   network_interface_id      = azurerm_network_interface.instance.id
#   network_security_group_id = module.module_test.network_security_group.id
# }
# resource "azurerm_network_interface_application_security_group_association" "instance" {
#   for_each                      = module.module_test.application_security_group
#   network_interface_id          = azurerm_network_interface.instance.id
#   application_security_group_id = each.value.id
# }
# data "http" "my_ip" {
#   url = "https://checkip.amazonaws.com"
# }
# ### Rules
# resource "azurerm_network_security_rule" "ingress_test" {
#   name                        = "ingress_test"
#   description                 = "ingress_test"
#   resource_group_name         = module.module_test.resource_group_main01.name
#   network_security_group_name = module.module_test.network_security_group.name
#   priority                    = 100
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "*"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = "${chomp(data.http.my_ip.response_body)}/32"

#   destination_application_security_group_ids = [
#     module.module_test.application_security_group["base_ingress"].id
#   ]
# }
# resource "azurerm_linux_virtual_machine" "instance" {
#   resource_group_name        = module.module_test.resource_group_main01.name
#   location                   = module.module_test.resource_group_main01.location
#   name                       = replace(random_id.instance.hex, "/", "-")
#   zone                       = "1"
#   size                       = "Standard_B1s"
#   admin_username             = "cloud-user"
#   source_image_id            = local.vm_image
#   encryption_at_host_enabled = true
#   tags                       = local.tags
#   network_interface_ids = [
#     azurerm_network_interface.instance.id
#   ]
#   admin_ssh_key {
#     username   = "cloud-user"
#     public_key = local.public_key
#   }
#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#     disk_size_gb         = "100"
#   }
#   depends_on = [
#     random_id.instance,
#     azurerm_network_interface.instance
#   ]
# }
# output "zzz_instance" { value = {
#   private_ip = azurerm_linux_virtual_machine.instance.private_ip_address
#   public_ip  = azurerm_linux_virtual_machine.instance.public_ip_address
# } }
