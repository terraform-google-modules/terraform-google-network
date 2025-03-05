/*
  Description: Outputs
  Comments: N/A
*/

# Metadata
output "_context" { value = module.base_context.context }
output "vpc_prefix" { value = "${module.base_context.security_boundary}-${module.base_context.business}-${module.base_context.customer}" }
output "vpc_customer_cidr" { value = var.vpc_cidr_block }


output "infrastructure" { value = module.ibp_customer_infrastructure }
