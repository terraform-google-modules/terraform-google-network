/*
  Description: Create authoritative Public FQDN
  Comments: This only works in Commercial environments
*/


##### Optional Create the Route 53 public Hosted Zone
locals {
  deploy_route53_external = var.dns_external_fqdn != "" ? true : false
}
module "context_aws_route53_zone_external" {
  count       = local.deploy_route53_external ? 1 : 0
  source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.base_layer_context.context
  name        = var.dns_external_fqdn
  flags       = { override_name = true }
  description = "Route53 public zone"
}
resource "aws_route53_zone" "external" {
  count = local.deploy_route53_external ? 1 : 0
  name  = module.context_aws_route53_zone_external[0].name
  tags  = module.context_aws_route53_zone_external[0].tags
}
