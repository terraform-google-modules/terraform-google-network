/*
  Description: Handles AWS Route53 records for Azure services
*/

##### Instance List
resource "aws_route53_record" "customer_internal_a_record" {
  for_each = merge(local.azure_layer_02.instance_list, local.azure_layer_02.instance_list_saprouter)

  name    = "azure-${module.azure_context.partition}-${each.value.virtual_machine_id}"
  ttl     = "300"
  type    = "A"
  zone_id = local.aws_layer_00.route53_zone_main01.id
  records = [each.value.private_ip]
}

locals {
  instance_cnames_list = flatten([
    for key, value in local.azure_layer_02.raw_instance_list : flatten([
      for cname in value.cnames : [{
        key          = "${key}__${cname}"
        instance_key = key
        instance     = value
        cname        = cname
      }]
    ])
  ])
  instance_cnames = {
    for item in local.instance_cnames_list : item.key => item
  }
}

resource "aws_route53_record" "customer_internal_cname" {
  for_each = local.instance_cnames

  name    = each.value.cname
  ttl     = "300"
  type    = "CNAME"
  zone_id = local.aws_layer_00.route53_zone_main01.id
  records = [aws_route53_record.customer_internal_a_record[each.value.instance_key].fqdn]
}

output "customer_vm" { value = {
  for key, value in local.azure_layer_02.instance_list : key => {
    azure = value
    aws = {
      cnames = [
        for cname_search_key, cname_search_value in local.instance_cnames :
        aws_route53_record.customer_internal_cname[cname_search_key].fqdn
        if(cname_search_value.instance_key == key)
      ]
    }
  }
} }
##### END Instance List
