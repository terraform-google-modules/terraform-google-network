# aws-qtm Module

Creates the following AWS Resources:
* 1 x Public ALB (with Listener and Target Group)
* 1 x Security Group for QTM Instances
  * Rules TBD
* 1 x Security Group for ALB
  * Allows all ingress
  * Restricts egress to QTM Webdispatcher 44301
* 3 x Instances for QTM (HANA, ABAP, WDISP)

## Dependencies
* See [tf-docs](./tf-docs.md) for terraform dependencies
* NOTE: Requires aws-instance, null-context modules for now.

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
