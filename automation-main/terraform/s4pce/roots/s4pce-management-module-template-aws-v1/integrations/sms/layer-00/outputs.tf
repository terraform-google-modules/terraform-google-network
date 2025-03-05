/*
  Description: Terraform Outputs
  Comments: N/A
*/

### Network
locals {
  network_integration = merge(
    local.management_network_integration,
    local.customer_network_integration,
  )
}

output "network_integration" { value = local.network_integration }

### DNS
locals {
  dns_integration = {
    internal = {
      hosted_zones = {
        for workspace in local.management_workspaces :
        (local.management_outputs[workspace].route53_zone_main01.name) => local.management_outputs[workspace].route53_zone_main01.id
      }
      resolver_rules     = {}
      outbound_endpoints = {}
      inbound_endpoints = {
        for workspace in local.management_workspaces :
        (local.management_outputs[workspace].route53_resolver_endpoint_main01_inbound.id) => local.management_outputs[workspace].route53_resolver_endpoint_main01_inbound.object
      }
      additional_forwarded_domains = {}
      additional_records           = {}
    }
    external = {
      hosted_zones = local.init_outputs.route53_zone_external.exists ? {
        id           = local.init_outputs.route53_zone_external.id
        name_servers = local.init_outputs.route53_zone_external.name_servers
  } : {} } }
}

output "dns_integration" { value = local.dns_integration }
