terraform-context-aws-iam-role Module
=====================================

This Terraform module creates a single AWS IAM Role, attaches policies and associates it to an IAM Profile

Implementation of terraform-context-aws-iam-role Module
=======================================================

Please see the README.md file underneath the `example_root` folder for correct implementation steps.

**DO NOT Run the terraform directly from this module folder**

Dependencies
------------

* Terraform 0.14
* AWS privileges to manage and create AWS IAM Roles
* AWS S3 buckets to store the terraform state files
* terraform-null-context role
