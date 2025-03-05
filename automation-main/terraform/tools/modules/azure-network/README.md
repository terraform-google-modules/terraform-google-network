# azure-network Example Root Module
This module creates the following:

* Creates a Customer Resource Group
* Deploy 1 Virtual Network in the Resource Group
* Optional Change the DNS Servers
* Dynamically deploy subnets
* Automatically create storage service endpoint
* Optionally deploy zonal gateways. One per AZ and associated to non-edge subnets
* Optionally create route tables.  One per AZ, one for nozone edge
* Optionally associate route route tables
* Create basic ingress, egress security groups.
* Optionally create basic security rules
* Optionally associated dns (dhcpoption)
* Pass in a map variable to be used for tagging.
* NOTE: Limited IPv6 Support. Creates local IPv6 resources, but does not create Global Unique addresses.

## Dependencies
* See [tf-docs](./tf-docs.md) for terraform dependencies

## Example
* See [module-test](./example_root/module-test.tf) for more detailed example

```hcl
module "module_test" {
  source     = "../"
  region     = "var.region"
  build_user = var.build_user
  tags       = var.tags
  vnet_cidr_blocks = ["172.16.0.0/16", "192.168.1.0/24", "10.0.0.0/8"]
  vnet_subnets = {
    zone_1 = { cidr = "172.16.0.0/26", zone = "1" }
    zone_2 = { cidr = "10.0.0.0/24", zone = "2" }
    edge   = { cidr = "172.16.0.64/26", zone = "nozone" }
  }
}
```
