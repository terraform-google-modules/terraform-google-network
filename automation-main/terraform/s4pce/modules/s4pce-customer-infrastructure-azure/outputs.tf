/*
  Description: Outputs data from the module; Contains commonly used outputs needed by other modules and dependent automation
*/

##### Pass Inputs to Dependent Terraform Layers
output "context" { value = module.module_context.context }

##### Resource Groups
output "resource_group_customer" { value = {
  id       = azurerm_resource_group.customer.id
  name     = azurerm_resource_group.customer.name
  location = azurerm_resource_group.customer.location
} }

##### VNets
output "vnet_customer" { value = {
  name        = azurerm_virtual_network.customer.name
  id          = azurerm_virtual_network.customer.id
  cidrs       = azurerm_virtual_network.customer.address_space
  description = azurerm_virtual_network.customer.tags.Description
} }

##### Subnets
output "subnets" { value = {
  for key, value in var.vnet_subnets : key => {
    name = azurerm_subnet.customer[key].name
    id   = azurerm_subnet.customer[key].id
    cidr = value.cidr
    zone = value.zone
  }
} }

##### NAT Gateways
output "nat_gateways" { value = var.create_nat_gateway ? {
  for key, value in local.az_letter_mapping : value => {
    name = azurerm_nat_gateway.customer[key].name
    id   = azurerm_nat_gateway.customer[key].id

    public_ip = {
      id      = azurerm_public_ip.customer_nat[key].id
      address = azurerm_public_ip.customer_nat[key].ip_address
    }
  }
} : {} }

##### Route Tables
output "route_tables" { value = {
  for key, value in local.az_letter_mapping : value => {
    name = azurerm_route_table.customer[key].tags.Name
    id   = azurerm_route_table.customer[key].id
  }
} }
output "route_table_edge" { value = {
  name = azurerm_route_table.customer_edge.tags.Name
  id   = azurerm_route_table.customer_edge.id
} }

###### Security Groups
### Network
output "network_security_group_customer_global" { value = {
  id   = azurerm_network_security_group.customer_global.id
  name = azurerm_network_security_group.customer_global.name
} }

### Application
output "vm_base_security_groups" {
  value = {
    (module.context_application_sg_customer_vnet_all.name)   = azurerm_application_security_group.customer_vnet_all.id
    (module.context_application_sg_customer_egress_all.name) = azurerm_application_security_group.customer_egress_all.id
  }
}
output "security_group_customer_vnet_all" { value = {
  id   = azurerm_application_security_group.customer_vnet_all.id
  name = module.context_application_sg_customer_vnet_all.name
} }
output "security_group_customer_egress_all" { value = {
  id   = azurerm_application_security_group.customer_egress_all.id
  name = module.context_application_sg_customer_egress_all.name
} }

##### Private DNS
output "private_dns_enabled" { value = var.dns_zone != null ? true : false }
output "private_dns_zone" { value = var.dns_zone }

##### Storage
output "storage_prefix" { value = local.customer_storage_prefix }

### NFS
output "nfs_storage_account" { value = {
  id   = azurerm_storage_account.customer_nfs.id
  name = azurerm_storage_account.customer_nfs.name
} }
output "nfs_usr_sap_trans" { value = {
  id   = azurerm_storage_share.customer_nfs_usr_sap_trans.id
  name = azurerm_storage_share.customer_nfs_usr_sap_trans.name
} }

### Backups
output "backups_storage_account" { value = {
  id   = azurerm_storage_account.customer_backups.id
  name = azurerm_storage_account.customer_backups.name
} }
output "backups_container" { value = {
  id   = azurerm_storage_container.customer_backups.resource_manager_id
  url  = azurerm_storage_container.customer_backups.id
  name = azurerm_storage_container.customer_backups.name
} }
