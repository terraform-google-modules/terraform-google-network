/*
  Description: Test the module
  Comments:
*/

locals {
  network = {
    use_new_network_model = true
    primary = {
      cidr = "10.0.0.0/21"
      subnets = {
        dataservices_1 = { zone = "a", cidr = "10.0.0.0/24" }
        dataservices_2 = { zone = "b", cidr = "10.0.1.0/24" }
        production_1   = { zone = "a", cidr = "10.0.2.0/24" }
        production_2   = { zone = "b", cidr = "10.0.3.0/24" }
        staging_1      = { zone = "a", cidr = "10.0.4.0/24" }
      }
      subnets_edge = {
        edge_1 = { zone = "a", cidr = "10.0.5.0/24" }
        edge_2 = { zone = "b", cidr = "10.0.6.0/24" }
      }
    }
  }
}

module "ibp_customer_infrastructure" {
  depends_on = [
    aws_vpc.test,
    aws_iam_role.test,
    aws_route_table.test,
    aws_default_route_table.test,
  ]
  source                        = "../"
  aws_region                    = var.aws_region
  build_user                    = var.build_user
  context                       = module.base_context.context
  vpc_custom_name               = "test-vpc-name"
  customer                      = "test-customer"
  management_vpc_name           = aws_vpc.test.tags.Name
  management_backup_service_arn = aws_iam_role.test.arn
  network                       = local.network

  ### Hidden Advanced Variables
  # These variables are not intended to be modified
  # but provide advanced configuration options
  # or compensate lack of feature parity.
  # Limited support is provided for these variables, use at your own risk.
  adv_backup_vault_force_destroy = false     # Force destroy the backup vault
  vpc_dhcp_options_id            = ""        # Custom DHCP Option (ID) to use
  management_nat_name            = "nat"     # Name of the management route table to use
  backup_versioning              = "Enabled" # Enable or disable versioning on the backup bucket
  binaries_versioning            = "Enabled" # Enable or disable versioning on the binaries bucket
  enable_backup                  = 1         # Enable or disable backups
}
