# ibp-customer-infrastructure-v2 Module

**NOTE:** This module is sunset with limited support. Please use `ibp-customer-infrastructure-v3` instead.

This Terraform code will setup and configure the IBP Customer VPCs for both Development and Production accounts.

## Dependencies
* See [tf-docs](./tf-docs.md) for terraform dependencies


## Example
* See [module-test](./example_root/module-test.tf) for more detailed example

```hcl
module "ibp_customer_infrastructure" {
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
}
```
