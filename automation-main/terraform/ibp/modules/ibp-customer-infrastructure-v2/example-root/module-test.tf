/*
  Description: Test the module
  Comments:
*/

module "ibp_customer_infrastructure" {
  depends_on = [
    aws_vpc.test,
    aws_iam_role.test,
    aws_route_table.test,
    aws_default_route_table.test,
  ]
  source                            = "../"
  aws_region                        = var.aws_region
  build_user                        = var.build_user
  management_vpc_name               = aws_vpc.test.tags.Name
  context                           = module.base_context.context
  management_backup_service_arn     = aws_iam_role.test.arn
  vpc_custom_name                   = "test-vpc-name"
  vpc_cidr_block                    = "10.0.0.0/16"
  subnet_production_1a_cidr_block   = "10.0.1.0/24"
  subnet_production_1b_cidr_block   = "10.0.2.0/24"
  subnet_dataservices_1a_cidr_block = "10.0.3.0/24"
  subnet_dataservices_1b_cidr_block = "10.0.4.0/24"
  subnet_staging_1a_cidr_block      = "10.0.5.0/24"
  subnet_staging_1b_cidr_block      = "10.0.6.0/24"
  subnet_edge_1a_cidr_block         = "10.0.7.0/24"
  subnet_edge_1b_cidr_block         = "10.0.8.0/24"
  subnet_edge_1c_cidr_block         = "10.0.9.0/24"
  customer                          = "test-customer"

  ### Hidden Advanced Variables
  # These variables are not intended to be modified
  # but provide advanced configuration options
  # or compensate lack of feature parity.
  # Limited support is provided for these variables, use at your own risk.
  module_dependency   = join(",", []) # Deprecated feature. To be removed in future versions.
  management_nat_name = "nat"         # Name of the management route table to use
  vpc_dhcp_options_id = ""            # Custom DHCP Option (ID) to use
  backup_versioning   = "Enabled"     # Enable or disable versioning on the backup bucket
  binaries_versioning = "Enabled"     # Enable or disable versioning on the binaries bucket
  enable_backup       = 1             # Enable or disable backups
}
