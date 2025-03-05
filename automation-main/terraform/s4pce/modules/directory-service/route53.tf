/*
  Description: (Optionally) Deploys Route53 Outbound Resolver Endpoints
  Comments: N/A
*/

resource "aws_route53_resolver_endpoint" "main01" {
  count              = var.create_outbound_resolver ? 1 : 0
  name               = var.outbound_resolver.name
  direction          = "OUTBOUND"
  security_group_ids = var.outbound_resolver.security_group_ids
  dynamic "ip_address" {
    for_each = local.ds_subnets
    content {
      subnet_id = ip_address.value
    }
  }
  tags = merge(var.tags, {})
}

resource "aws_route53_resolver_rule" "main01" {
  count                = var.create_outbound_resolver ? 1 : 0
  domain_name          = aws_directory_service_directory.main01.name
  name                 = "directory-service-forwarder"
  rule_type            = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.main01[0].id
  dynamic "target_ip" {
    for_each = aws_directory_service_directory.main01.dns_ip_addresses
    content {
      ip = target_ip.value
    }
  }
  tags = merge(var.tags, {})
}

resource "aws_route53_resolver_rule_association" "main01" {
  count            = var.create_outbound_resolver ? 1 : 0
  resolver_rule_id = aws_route53_resolver_rule.main01[0].id
  vpc_id           = var.directory_service_vpc_id
}

output "outbound_resolver" {
  value = var.create_outbound_resolver ? {
    id               = aws_route53_resolver_endpoint.main01[0].id
    arn              = aws_route53_resolver_endpoint.main01[0].arn
    ip_address       = aws_route53_resolver_endpoint.main01[0].ip_address
    resolver_rule_id = aws_route53_resolver_rule.main01[0].id
  } : null
}
