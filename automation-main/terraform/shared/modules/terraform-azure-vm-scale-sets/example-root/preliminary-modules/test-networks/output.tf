/*
  Description: output of this sample rivate_link_endpoint stack.
*/
output "lb_vnet_id" {
  description = "The id of the newly created vNet"
  value       = module.lb_network.vnet_id
}

output "lb_vnet_name" {
  description = "The name of the newly created vNet"
  value       = module.lb_network.vnet_name
}

output "lb_vnet_location" {
  description = "The location of the newly created vNet"
  value       = module.lb_network.vnet_location
}

output "lb_vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = module.lb_network.vnet_address_space
}

output "lb_vnet_subnets" {
  description = "The ids of subnets created inside the newly created vNet"
  value       = module.lb_network.vnet_subnets
}

#private_link_endpoint stands for private link endpoint, this code is just quick-and-dirty setup to test the main module
output "private_link_endpoint_vnet_id" {
  description = "The id of the newly created vNet"
  value       = module.private_link_endpoint_network.vnet_id
}

output "private_link_endpoint_vnet_name" {
  description = "The name of the newly created vNet"
  value       = module.private_link_endpoint_network.vnet_name
}

output "private_link_endpoint_vnet_location" {
  description = "The location of the newly created vNet"
  value       = module.private_link_endpoint_network.vnet_location
}

output "private_link_endpoint_vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = module.private_link_endpoint_network.vnet_address_space
}

output "private_link_endpoint_vnet_subnets" {
  description = "The ids of subnets created inside the newly created vNet"
  value       = module.private_link_endpoint_network.vnet_subnets
}
