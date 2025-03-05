aws-iam-user Module
===========================

This module creates multiple IAM Users, attach policies and add to groups as defined by the tfvars or variables file.

Implementation of aws-iam-user Module
=================================

Please see the README.md file underneath the `example_root` folder for correct implementation steps.

**DO NOT Run the terraform directly from this module folder**

Module Order of Operations
--------------------------
To make terraform run in a specific order, use the `module_dependency` variable in `main.tf`s calling block  to pass the output of another module
to create a dependency.  Leave this variable blank to run immediately.

Dependencies
------------

* Terraform 0.12
* AWS Administrator level privileges or privileges to manage VPC, EC2, EIPs and related services
* AWS S3 buckets to store the terraform state files
