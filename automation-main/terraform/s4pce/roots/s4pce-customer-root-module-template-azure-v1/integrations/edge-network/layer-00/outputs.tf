/*
  Description: Outputs from the layer-00 module; Contains commonly used outputs needed by other modules and dependent automation
  Layer: 00
  Comments: N/A
*/

##### Customer Connectivity
output "customer_connectivity" { value = var.adv_no_customer_gateway ? {} : {
  gateway = {
    name = azurerm_subnet.gateway01[0].name
    id   = azurerm_subnet.gateway01[0].id
  }
  public_ip = {
    ip_address = azurerm_public_ip.gateway01[0].ip_address
  }
} }

##### Endpoints
output "endpoint_list" { value = module.endpoint_list }


##### VNet
output "vnet_main01" { value = {
  name        = azurerm_virtual_network.main01.name
  id          = azurerm_virtual_network.main01.id
  cidr_block  = azurerm_virtual_network.main01.address_space
  description = azurerm_virtual_network.main01.tags.Description
} }

##### Subnet
output "subnet_main01" { value = {
  name = azurerm_subnet.main01.name
  id   = azurerm_subnet.main01.id
} }

##### Security Group
output "network_security_group_main01" { value = {
  id   = azurerm_network_security_group.main01.id
  name = azurerm_network_security_group.main01.name
} }

output "application_security_group_customer_egress_all" { value = {
  id   = azurerm_application_security_group.customer_egress_all.id
  name = azurerm_application_security_group.customer_egress_all.name
} }

output "application_security_group_customer_vnet_all" { value = {
  id   = azurerm_application_security_group.customer_vnet_all.id
  name = azurerm_application_security_group.customer_vnet_all.name
} }

locals {
  endpoints = templatefile(
    "./output-endpoints.tftpl",
    { endpoint_list = module.endpoint_list,
    raw_instance_list = local.layer_02.raw_instance_list }
  )
}
resource "local_file" "file_content" {
  content  = local.endpoints
  filename = "/tmp/cname-mappings-${local.base_context.customer}.md"
}
