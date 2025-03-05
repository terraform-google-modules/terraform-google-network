/*
  Description: Terraform main file; Base infrastructure for S4PCE
  Comments:
*/


##### Infrastructure (VPC, Subnets, security groups etc.)
module "s4pce_customer_infrastructure" {
  source                          = "EXAMPLE_SOURCE/terraform/s4pce/modules/s4pce-customer-infrastructure"
  aws_region                      = module.base_layer_context.region
  build_user                      = module.base_layer_context.build_user
  context                         = module.base_layer_context.context
  vpc_name                        = module.base_context.resource_prefix
  vpc_cidr_block                  = var.vpc_cidr_block
  vpc_dhcp_options_id             = local.management_layer_00_outputs.vpc_main01.dhcp_options_id
  route53_zone_management_id      = local.management_layer_00_outputs.route53_zone_main01.id
  subnet_production_1a_cidr_block = var.subnet_production_1a_cidr_block
  subnet_production_1b_cidr_block = var.subnet_production_1b_cidr_block
  subnet_production_1c_cidr_block = var.subnet_production_1c_cidr_block

  subnet_quality_assurance_1a_cidr_block = var.subnet_quality_assurance_1a_cidr_block
  subnet_quality_assurance_1b_cidr_block = var.subnet_quality_assurance_1b_cidr_block
  subnet_quality_assurance_1c_cidr_block = var.subnet_quality_assurance_1c_cidr_block

  subnet_development_1a_cidr_block = var.subnet_development_1a_cidr_block
  subnet_development_1b_cidr_block = var.subnet_development_1b_cidr_block
  subnet_development_1c_cidr_block = var.subnet_development_1c_cidr_block

  subnet_edge_1a_cidr_block = var.subnet_edge_1a_cidr_block
  subnet_edge_1b_cidr_block = var.subnet_edge_1b_cidr_block
  subnet_edge_1c_cidr_block = var.subnet_edge_1c_cidr_block

  additional_endpoints          = var.additional_endpoints
  additional_endpoints_creation = var.additional_endpoints_creation
}
output "infrastructure" { value = module.s4pce_customer_infrastructure }
