ibp-customer-ha-infrastructure Module
=====================================

This is a Proof of Concept (PoC) Terraform code to provision a new IBP customer infrastructure in High Availability (HA) mode.

Implementation
==============

Please see the README.md file underneath the `example_root` folder for correct implementation steps.

**DO NOT Run the terraform directly from this module folder**

Module Order of Operations
--------------------------
To make terraform run in a specific order, use the `module_dependency` variable in `main.tf` calling block to pass the output of another module
to create a dependency.  Leave this variable blank to run immediately.

Dependencies
------------

* Terraform 0.12
* AWS Administrator level privileges or privileges to manage VPC, EC2,S3, and other related services
* AWS S3 buckets to store the terraform state files

IBP Customer HA Module Details
------------------------------

The following are a details concerning the IBP Customer VPC

### Subnets

| Terraform name                  | AWS Tag Name                   | CIDR           | Comments  |
| ------------------------------- | ------------------------------ | -------------- | ----------|
| customer_production_1a          | (VPC NAME)-az1a-production     | (USER DEFINED) | Private Subnet for production servers |
| customer_production_1b          | (VPC NAME)-az1a-production     | (USER DEFINED) | Private Subnet for production servers |
| customer_dataservices_1a        | (VPC NAME)-az1b-dataservices   | (USER DEFINED) | Private Subnet for CPI-DS zone A |
| customer_dataservices_1b        | (VPC NAME)-az1b-dataservices   | (USER DEFINED) | Private Subnet for CPI-DS zone B |
| customer_dataservices2_1a       | (VPC NAME)-az1b-dataservices2  | (USER DEFINED) | Private Subnet for Cluster zone A |
| customer_staging_1a             | (VPC NAME)-az1a-staging        | (USER DEFINED) | Private Subnet for application development and staging |
| customer_edge_1a                | (VPC NAME)-az1a-edge           | (USER DEFINED) | Subnet to route traffic outside the VPC |
| customer_edge_1b                | (VPC NAME)-az1v-edge           | (USER DEFINED) | Subnet to route traffic outside the VPC |
| customer_edge_1c                | (VPC NAME)-az1c-edge           | (USER DEFINED) | Subnet to route traffic outside the VPC |
| # customer_staging_1b           | (VPC NAME)-az1a-staging        | (USER DEFINED) | Reserved for other availability zones |


### Elastic IPs

| Terraform Name    | Comments |
| ----------------- | -------- |
| vpc_ngw1_eip      | For the nat gateway |

### Security Groups

| Terraform Name              | AWS Tag Name                | Comments |
| --------------------------- | --------------------------- | -------- |
| customer_default_sg         | (VPC Name)-default          | AWS Default Security Group. Rules set to blank state |
| customer_all_egress         | (VPC Name)-all-egress       | Allows all egress traffic |
| customer_access_ns2         | (VPC Name)-access-ns2       | Allows access from NS2 IP addresses |
| customer_vpc                | (VPC Name)-vpc              | Allows traffic within the VPC |
| customer_access_management  | (VPC Name)-management       | Allows to/from the management VPC CIDR Block |
