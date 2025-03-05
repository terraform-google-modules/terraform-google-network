locals {
  customer_subdomain = var.customer_id
  customer_domain    = join(".", [local.customer_subdomain, var.toplevelzone_fqdn])
  vpcs               = var.vpc_id != "" ? [var.vpc_id] : []
}

resource "aws_route53_zone" "customerzone" {
  name = local.customer_domain
  tags = module.module_context.tags

  dynamic "vpc" {
    for_each = local.vpcs
    content {
      vpc_id = vpc.value
    }
  }
}

resource "aws_route53_record" "zone-cut" {
  zone_id = var.toplevelzone_id
  name    = local.customer_domain
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.customerzone.name_servers
}

resource "aws_route53_record" "endpoints" {
  for_each = var.endpoints

  zone_id = aws_route53_zone.customerzone.id
  name    = each.key
  type    = "CNAME"
  ttl     = "30"
  records = [each.value]
}

output "records" {
  value = aws_route53_record.endpoints
}
