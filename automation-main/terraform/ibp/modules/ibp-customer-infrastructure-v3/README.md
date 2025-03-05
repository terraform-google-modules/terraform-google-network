# ibp-customer-infrastructure-v3 Module

This Terraform code will setup and configure the IBP Customer VPCs for both Development and Production accounts.

This module includes `terraform moves` to migrate from v2 to v3. Please refer to Root modules for migration examples.

## Dependencies
* See [tf-docs](./tf-docs.md) for terraform dependencies


## Example
* See [module-test](./example_root/module-test.tf) for more detailed example

```hcl
  source                        = "../"
  aws_region                    = var.aws_region
  build_user                    = var.build_user
  context                       = module.base_context.context
  vpc_custom_name               = "test-vpc-name"
  customer                      = "test-customer"
  management_vpc_name           = aws_vpc.test.tags.Name
  management_backup_service_arn = aws_iam_role.test.arn
  network                        = local.network
```
