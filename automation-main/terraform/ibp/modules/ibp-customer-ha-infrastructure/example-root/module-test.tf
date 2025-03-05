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
  source                             = "../"
  aws_region                         = var.aws_region
  build_user                         = var.build_user
  management_vpc_name                = aws_vpc.test.tags.Name
  vpc_custom_name                    = "test-vpc-name"
  vpc_cidr_block                     = "10.0.0.0/16"
  subnet_production_1a_cidr_block    = "10.0.1.0/24"
  subnet_production_1b_cidr_block    = "10.0.2.0/24"
  subnet_dataservices_1a_cidr_block  = "10.0.3.0/24"
  subnet_dataservices_1b_cidr_block  = "10.0.4.0/24"
  subnet_dataservices2_1a_cidr_block = "10.0.5.0/24"
  subnet_dataservices2_1b_cidr_block = "10.0.6.0/24"
  subnet_staging_1a_cidr_block       = "10.0.7.0/24"
  subnet_staging_1b_cidr_block       = "10.0.8.0/24"
  subnet_edge_1a_cidr_block          = "10.0.9.0/24"
  subnet_edge_1b_cidr_block          = "10.0.10.0/24"
  subnet_edge_1c_cidr_block          = "10.0.11.0/24"
  module_dependency                  = join(",", [])


}
