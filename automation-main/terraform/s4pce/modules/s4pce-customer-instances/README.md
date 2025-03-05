# s4pce-customer-infrastructure Module

This Terraform code will setup and configure the S4 PCE Customer VPC Infrastructure
**DO NOT Run the terraform directly from this module folder**

## Implementation

Please see the README.md file underneath the `example_root` folder for correct implementation steps.

## Dependencies

* Terraform 0.13.5+
* AWS Administrator level privileges or privileges to manage VPC, EC2,S3, and other related services
* AWS S3 buckets to store the terraform state files
* Requires that the network has been previously created and that a VPC or subnets with the specified CIDRs exist

## S4 PCE Instances Summary

1x SSH Keypair
?x Instances
