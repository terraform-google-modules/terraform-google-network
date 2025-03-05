# terraform-aws-dns-steering Module

The purpose of this module is to create intermediary CNAME records for
* Customers to CNAME their intended DNS records (the FQDN of the certificate they provide) to
* Ops to be able to change backing endpoints without impacting the Customer

Creates:
* Customer-specific Route53 sub-zone
* Zone-cut NS records in Route53 parent zone
* If private (specify `vpc_id`) then sub-zone bound to VPC
* All records provided by `endpoints` variable

## Dependencies
* See [tf-docs](./tf-docs.md) for terraform dependencies

## Example
* See private [module-test](./example_private_root/module-test.tf) for examples
* See public [module-test](./example_public_root/module-test.tf) for examples
