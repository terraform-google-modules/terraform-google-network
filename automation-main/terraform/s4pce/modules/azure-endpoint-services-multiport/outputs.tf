/*
  Description: Output file of the module
  Comments:
*/

output "azurerm_lb_id" {
  description = "the id for the azurerm_lb resource"
  value       = azurerm_lb.loadbalancer.*.id
}

output "azurerm_lb_frontend_ip_configuration" {
  description = "the frontend_ip_configuration for the azurerm_lb resource"
  value       = azurerm_lb.loadbalancer.*.frontend_ip_configuration
}

output "lb_frontend_private_ipaddresses" {
  description = "the private frontend ip addresses"
  value       = var.loadbalancer_type == "public" ? [""] : [for entry in flatten(azurerm_lb.loadbalancer.*.frontend_ip_configuration) : entry.private_ip_address]
}
output "azurerm_loadbalancer_probe_ids" {
  description = "the ids for the azurerm_loadbalancer_probe resources"
  value       = azurerm_lb_probe.probe.*.id
}

output "azurerm_lb_nat_rule_ids" {
  description = "the ids for the azurerm_lb_nat_rule resources"
  value       = azurerm_lb_nat_rule.nat_rule.*.id
}

output "azurerm_lb_backend_address_pool_ids" {
  description = "the id for the azurerm_lb_backend_address_pool resource"
  value       = azurerm_lb_backend_address_pool.backend_address_pool.*.id
}

output "azurerm_public_ip_address" {
  description = "the ip address for the azurerm_lb_public_ip resource"
  value       = azurerm_public_ip.public_ip.*.ip_address
}



output "endpoint_services" {
  value = tomap({
    for k, v in azurerm_private_link_service.privatelinkservice : k => {
      name     = v.name
      dns_name = v.alias
    }
  })
}


output "endpoints" {
  value = tomap({
    for k, v in azurerm_private_endpoint.privateendpoint : k => {
      id                 = v.id
      private_ip_address = v.private_service_connection[0].private_ip_address
    }
  })
}
