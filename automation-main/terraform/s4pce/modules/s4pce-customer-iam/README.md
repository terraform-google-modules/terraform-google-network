# s4pce-customer-iam Module

This Terraform code will setup and configure the S4 PCE Customer IAM
**DO NOT Run the terraform directly from this module folder**

1x AWS Policy: s3_backups_readlist_policy
1x AWS Policy: s3_backups_write_policy
1x AWS Role: iam_role_customer_default

## Dependencies

* See [tf-docs](./tf-docs.md) for terraform dependencies

## Example
* See [module-test](./example_root/module-test.tf) for more detailed example

```hcl
module "module_test" {
  source     = "../"
  aws_region = var.aws_region
  build_user = var.build_user
  tags       = var.tags
  network    = {
    primary = {
      cidr = "10.108.0.0/22"
      subnets = {
        production  = { cidr = "10.108.0.0/24", zone = "a" }
      }
      subnets_edge = {
  } } }
}
```
