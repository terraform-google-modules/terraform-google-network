/*
  Description: Route53 zone association and record creation
*/

##### Redirect traffic to the IBP Active Directory Domain
resource "aws_route53_resolver_rule_association" "ibp_directory_service" {
  resolver_rule_id = local.management_layer_options_outputs.directory_service.outbound_resolver.resolver_rule_id
  vpc_id           = local.layer_00_outputs.infrastructure.vpc_customer.id
}
