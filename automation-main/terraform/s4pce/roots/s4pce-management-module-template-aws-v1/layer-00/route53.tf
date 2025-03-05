/*
  Description: Internal/Private Route53 Resources
  Comments:
*/

##### Create the Route 53 private Hosted Zone
module "context_aws_route53_zone_main01" {
  source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.base_layer_context.context
  name        = var.dns_fqdn
  flags       = { override_name = true }
  description = "route53 zone"
}
resource "aws_route53_zone" "main01" {
  name = module.context_aws_route53_zone_main01.name
  vpc {
    vpc_id = aws_vpc.main01.id
  }
  tags = module.context_aws_route53_zone_main01.tags
  lifecycle {
    ignore_changes = [
      vpc, # This will allow other vpc's in other configurations to associate to the hosted zone
    ]
  }
}
### Hosted Zone VPC authorizations
locals {
  dns_authorization_vpc_ids_map = {
    for vpc in var.dns_authorization_vpc_ids : vpc.vpc_id => vpc
  }
}
resource "aws_route53_vpc_association_authorization" "main01" {
  for_each = local.dns_authorization_vpc_ids_map
  vpc_id   = each.value.vpc_id
  zone_id  = aws_route53_zone.main01.id
}


### Send Route 53 traffic into the Management VPC inbound endpoint
module "context_aws_route53_resolver_endpoint_main01_inbound" {
  source = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"

  context     = module.base_layer_context.context
  name        = "dns-inbound-forwarder"
  description = "route53 resolver endpoint inbound"
}
resource "aws_route53_resolver_endpoint" "main01_inbound" {
  name               = module.context_aws_route53_resolver_endpoint_main01_inbound.name
  direction          = "INBOUND"
  security_group_ids = [aws_security_group.main01_access_edge.id, ]
  ip_address {
    subnet_id = aws_subnet.main01_edge_1a.id
  }
  ip_address {
    subnet_id = aws_subnet.main01_edge_1b.id
  }
  ip_address {
    subnet_id = aws_subnet.main01_edge_1c.id
  }
  tags = module.context_aws_route53_resolver_endpoint_main01_inbound.tags
}
