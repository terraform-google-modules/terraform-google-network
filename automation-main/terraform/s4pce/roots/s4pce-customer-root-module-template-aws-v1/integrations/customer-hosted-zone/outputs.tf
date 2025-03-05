/*
  Description: Outputs from the layer-00 module; Contains commonly used outputs needed by other modules and dependent automation
  Layer: 00
  Comments: N/A
*/

locals {
  customer_hosted_zones = {
    for key in var.customer_hosted_zones : key => {
      name    = aws_route53_zone.main01[key].name
      id      = aws_route53_zone.main01[key].id
      zone_id = aws_route53_zone.main01[key].zone_id
    }
  }
}

output "route53_customer_hosted_zone" { value = local.customer_hosted_zones }

output "route53_customer_records" { value = aws_route53_record.main01 }
