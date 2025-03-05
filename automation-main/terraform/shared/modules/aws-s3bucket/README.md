aws-s3buckets Module
====================

This module creates an AWS S3 Buckets on demand.

Implementation of aws-s3buckets Module
======================================

Please see the README.md file underneath the `example_root` folder for correct implementation steps.

**DO NOT Run the terraform directly from this module folder**

Module Order of Operations
--------------------------
To make terraform run in a specific order, use the `module_dependency` variable in `main.tf` calling block to pass the output of another module
to create a dependency.  Leave this variable blank to run immediately.

Dependencies
------------

* Terraform 0.12
* AWS Administrator level privileges or privileges to manage VPC, EC2, EIPs and related services
* AWS S3 buckets to store the terraform state files

Caveats
-------
Because of how S3 Buckets work, Terraform is unable to manage how retention policies or encryption options in S3 Buckets.
