# aws-network Module

Creates an AWS VPC with the following:
* Deploy up to 5 cidr networks.
* Dynamically deploy subnets
* Optionally deploy gateways. One per AZ
* Optionally create and associate route tables. One per AZ
* Create basic ingress, egress security groups.
* Optionally create basic security rules
* Optionally associated dhcpoption
* Pass in a map variable to be used for tagging.
* Rudimentary support of IPv6 CIDR blocks
  * Only AWS Generated IPv6 CIDR blocks are supported at this time.

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
