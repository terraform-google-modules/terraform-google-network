/*
  Description: Test the module
  Comments:
    - Creates a public Route53 zone.
*/

locals {
  customer_id = "Testomer0123"
  endpoints = {
    "db01" = "db01.foo.bar"
  }
}

module "module_test" {
  source            = "../"
  context           = module.base_context.context
  toplevelzone_fqdn = aws_route53_zone.toplevelzone.name
  toplevelzone_id   = aws_route53_zone.toplevelzone.id
  customer_id       = local.customer_id
  endpoints         = local.endpoints
}

output "module_test" { value = module.module_test }
