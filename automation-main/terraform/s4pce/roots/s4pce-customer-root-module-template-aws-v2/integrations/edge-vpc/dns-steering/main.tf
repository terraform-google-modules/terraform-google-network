/*
  Description: Create DNS Steering Records for each endpoint
  Comments:
*/

locals {
  customer_id = module.module_context.customer
  endpoints = merge({
    for key, value in local.edge_vpc_layer_00_outputs.endpoint_list : key => value.endpoint.dns_name[0]
    }, {
    for key, value in local.edge_vpc_layer_00_outputs.sftp_list : key => value.endpoint.0.dns_name[0]
  })
}


module "dns_steering" {
  source            = "../../EXAMPLE_SOURCE/terraform/s4pce/modules/terraform-aws-dns-steering"
  providers         = { aws = aws.dns_account }
  context           = module.module_context.context
  toplevelzone_fqdn = var.dns_steering_zone.fqdn
  toplevelzone_id   = var.dns_steering_zone.id
  customer_id       = local.customer_id
  endpoints         = local.endpoints
}
output "dns_steering" { value = module.dns_steering }
