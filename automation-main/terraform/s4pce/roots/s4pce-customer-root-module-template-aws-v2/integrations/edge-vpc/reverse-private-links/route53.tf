/*
  Description: Route53 Zone and records
  Comments:
    - N/A
*/

locals {
  # Create a list of name/value associations from the endpoint list
  cname_list = flatten([
    for host in keys(var.reverse_private_link_list) :
    [
      for cname in var.reverse_private_link_list[host].cnames : {
        cname  = cname
        target = module.endpoint_list[host].endpoint.dns_name[0]
        zone   = var.reverse_private_link_list[host].private_hosted_zone
      } if cname != ""
    ]
  ])
  # Convert the above list to a map.  Because terraform.
  cname_map = {
    for key, value in local.cname_list : value.cname => {
      target = value.target
      zone   = value.zone
    }
  }
}

resource "aws_route53_record" "endpoint_list" {
  for_each = local.cname_map
  zone_id  = local.customer_hosted_zone_outputs.route53_customer_hosted_zone[each.value.zone].id
  name     = lower(each.key)
  type     = "CNAME"
  ttl      = "300"
  records  = [each.value.target]
}
