/*
  Description: Output file of the module; Outputs commonly used values from the module.
*/

output "name" { value = azurerm_linux_virtual_machine.instance.name }
output "id" { value = azurerm_linux_virtual_machine.instance.id }
output "virtual_machine_id" { value = azurerm_linux_virtual_machine.instance.virtual_machine_id }
output "principal_id" { value = azurerm_linux_virtual_machine.instance.identity[0].principal_id }
output "public_ip" { value = azurerm_linux_virtual_machine.instance.public_ip_address }
output "private_ip" { value = azurerm_linux_virtual_machine.instance.private_ip_address }
output "availability_zone" { value = azurerm_linux_virtual_machine.instance.zone }
output "network_interface_id" { value = azurerm_network_interface.instance.id }
output "network_interface_ip_configuration" { value = azurerm_network_interface.instance.ip_configuration }
output "cname" { value = ((var.dns_associate_private_ip_address == true) && (var.dns_associate_cname == true)) ? azurerm_private_dns_cname_record.instance[0].fqdn : "" }
output "additional_cnames" { value = (var.dns_associate_private_ip_address == true && length(data.azurerm_private_dns_zone.instance) >= 1) ? formatlist("%s.%s", var.dns_additional_cnames, trimsuffix(data.azurerm_private_dns_zone.instance[0].name, ".")) : null }
output "tags" { value = azurerm_linux_virtual_machine.instance.tags }
output "subnet_id" { value = var.subnet_id }
