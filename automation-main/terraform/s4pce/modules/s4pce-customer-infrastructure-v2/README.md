# s4pce-customer-infrastructure-v2 Module

This Terraform code will setup and configure the S4 PCE Customer VPC Infrastructure
**DO NOT Run the terraform directly from this module folder**

## Implementation

Please see the README.md file underneath the `example_root` folder for correct implementation steps.

## Module Order of Operations

To make terraform run in a specific order, use the `module_dependency` variable in `main.tf` calling block to pass the output of another module
to create a dependency.  Leave this variable blank to run immediately.

## Dependencies

* Terraform 0.13.5+
* AWS Administrator level privileges or privileges to manage VPC, EC2,S3, and other related services
* AWS S3 buckets to store the terraform state files

## S4 PCE Infrastructure Summary

1 x EFS
1 x HA EFS (if enabled)
1 x Internet Gateway
? x Nat Gateways (depends on network)
? x Elastic IP
4 x Route Tables
1 x S3 Bucket
4 x Security Groups
