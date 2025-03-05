# 2024-11-12 i868402
* Changed Changelog to new format.
* Add/Refactor example-root for module.

## Version 0.13-000005 (2021-05-10) (c5309377)
### Bugfix - Update required_providers for terraform
* update versions.tf to the format required by Terraform 0.13 (and later)

## Version 0.12-000004 (2020-12-15) (i868402)
### Enhancement - Remove NS2-Access Security Group
* Remove NS2-Access Security Group

## Version 0.12-000003 (2020-09-30) (i868402)
### Enhancement - Set Minimum Version
* Change Major version lock to minimum version as best practice by Hashicorp for terraform modules.

## Version 0.12-000002 (2020-08-07) (i536519)
### Enhancement - Maintenance
* Removed the `##-` prefix from all the filenames

## Version 0.12-000001 (i868402)
### Initial version established with the following features
* VPC Creation
* Subnets Creation
*   customer_production_1a
*   customer_production_1b
*   customer_dataservices_1a
*   customer_dataservices_1b
*   customer_dataservices2_1a
*   customer_staging_1a
*   customer_edge_1a
*   customer_edge_1b
*   customer_edge_1c
* EIP Creation
*   Nat Gateway EIP
* VPC Peering with Management VPC
* Route Creation
*   default route
*   nat gateway route
*   Updates for VPC Peering
* Security Group Creation/Management
*   default
*   all-egress
*   access-ns2
*   access-external
*   access-management
*   vpc
