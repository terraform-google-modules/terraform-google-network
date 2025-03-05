IAM Role Module
===============

This Terraform module creates a single AWS IAM Role, attaches policies and associates it to an IAM Profile

Implementation of iam-role Module
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
* AWS privileges to manage and create AWS IAM Roles
* AWS S3 buckets to store the terraform state files
