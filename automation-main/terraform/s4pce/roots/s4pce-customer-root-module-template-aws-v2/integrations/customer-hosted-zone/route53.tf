/*
  Description: Route53 Zone and records
  Comments:
    - N/A
*/

resource "aws_route53_zone" "main01" {
  for_each      = toset(var.customer_hosted_zones)
  force_destroy = true
  name          = each.value
  vpc {
    vpc_id = local.layer_00_outputs.infrastructure.vpc_customer.id
  }
  lifecycle {
    ignore_changes = [vpc]
  }
  tags = merge(module.base_layer_context.tags, {
    Name        = lower("${module.base_layer_context.resource_prefix}-default")
    Description = title("${module.base_layer_context.custom_values.kv.prefix_friendly_name} Private Hosted Zone")
  })
}

resource "aws_route53_record" "main01" {
  for_each = var.customer_dns_map
  zone_id  = aws_route53_zone.main01[each.value.zone].id
  name     = lower(each.key)
  type     = upper(each.value.type)
  ttl      = "300"
  records  = each.value.data
}
