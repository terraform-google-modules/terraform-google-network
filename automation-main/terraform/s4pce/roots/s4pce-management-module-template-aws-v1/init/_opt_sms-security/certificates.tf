/*
  Description: Certificates
  Comments: This is code from a specific deployment that is preserved for historical reasons.
*/


# locals {
#   _name_to_cert_hostnames = flatten([
#     for k, v in var.certificates :
#     [
#       for hostname in v["hostnames"] :
#       {
#         "name"     = k
#         "hostname" = hostname
#         "sans"     = lookup(var.certificate_sans, hostname, [])
#       }
#     ]
#   ])

#   name_to_cert_hostname = {
#     for entry in local._name_to_cert_hostnames :
#     "${entry.name}:${entry.hostname}" => entry
#   }
# }

# ### Azure Government Elastic Search Certificate Creation
# module "context_acm_cert" {
#   for_each    = var.certificates
#   source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
#   context     = module.base_layer_context.context
#   name        = each.key
#   description = each.value["description"]
# }

# resource "aws_acm_certificate" "management_acm_cert" {
#   for_each                  = local.name_to_cert_hostname
#   domain_name               = "${each.value.hostname}.${var.dns_fqdn}"
#   tags                      = module.context_acm_cert[each.value.name].tags
#   certificate_authority_arn = var.acm_pca_arn
#   subject_alternative_names = [for san in each.value.sans : "${san}.${var.dns_fqdn}"]
#   lifecycle {
#     create_before_destroy = true
#   }
# }

# output "management_acm_certs" {
#   value = {
#     for k, v in aws_acm_certificate.management_acm_cert :
#     k => {
#       "arn"                       = v.arn
#       "certificate_authority_arn" = v.certificate_authority_arn
#       "domain_name"               = v.domain_name
#     }
#   }
# }
