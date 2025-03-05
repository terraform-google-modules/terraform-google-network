/*
  Description: Terraform main file; Base infrastructure for IBP
  Comments:
    TODO: Some resources like the vpc peer needs to be moved out of the infrastructure module.
*/


locals {
  network = var.network.use_new_network_model ? var.network : {
    use_new_network_model = false
    primary = {
      cidr = var.vpc_cidr_block
      subnets = {
        dataservices_1 = { zone = "a", cidr = var.subnet_dataservices_1a_cidr_block }
        dataservices_2 = { zone = "b", cidr = var.subnet_dataservices_1b_cidr_block }
        production_1   = { zone = "a", cidr = var.subnet_production_1a_cidr_block }
        production_2   = { zone = "b", cidr = var.subnet_production_1b_cidr_block }
        staging_1      = { zone = "a", cidr = var.subnet_staging_1a_cidr_block }
      }
      subnets_edge = {
        edge_1 = { zone = "a", cidr = var.subnet_edge_1a_cidr_block }
        edge_2 = { zone = "b", cidr = var.subnet_edge_1b_cidr_block }
        edge_3 = { zone = "c", cidr = var.subnet_edge_1c_cidr_block }
      }
    }
  }
}

##### Infrastructure (VPC, Subnets, security groups etc.)
module "ibp_customer_infrastructure" {
  source                        = "EXAMPLE_SOURCE/terraform/ibp/modules/ibp-customer-infrastructure-v3"
  aws_region                    = module.base_context.region
  build_user                    = module.base_context.build_user
  context                       = module.base_layer_context.context
  vpc_custom_name               = module.base_context.resource_prefix
  vpc_dhcp_options_id           = local.management_layer_00_outputs.vpc_main01.dhcp_options_id
  customer                      = var.customer
  management_vpc_name           = local.management_layer_00_outputs.vpc_main01.name
  management_nat_name           = var.management_nat_name
  management_backup_service_arn = local.management_layer_01_outputs.iam_role_aws_backup.role_arn

  network                        = local.network
  adv_backup_vault_force_destroy = var.adv_backup_vault_force_destroy
}
