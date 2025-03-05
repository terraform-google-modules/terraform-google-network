# 2024-1126 i868402
* Added sunset notice

# 2024-11-12 i868402
* Changed Changelog to new format.
* Add/Refactor example-root for module.
* removed unused inspec tests

## Version 1.2.7 (2024-09-09) (i868402)
### Bugfix - Backup Plan Output
* Add conditional and Element to output for backup plan id

## Version 1.2.6 (2024-09-09) (i743694)
### Enhancement - Backup Plan
* Update layer-02 to allow disabling and enabling of backup plan
* Added Terraform Variable enable_backup. Default is enabled
* Added count function to backup plan & selection resources withing backup.tf. Also added count.index to plan id of selection

## Version 1.2.5 (2024-09-05) (i743694)
### Enhancement - s3 bucket version variable
* Added variable for enabling/disabling bucket versioning on s3 bucket. Default is enable.`
* Added variable for enabling/disabling bucket versioning on s3 binary bucket. Default is enable.

# Version History
## Version 1.2.4 (2023-07-31) (c5355631)
### Enhancement - s3 bucket creation
* Updated `s3buckets.tf` to include `aws_s3_bucket_ownership_controls`

# Version History
## Version 1.2.3 (2023-07-28) (c5355631)
### Enhancement - Availability zone 1d for ca-central-1
* Add logic to use ca-central-1d instead of ca-central-1c

## Version 1.2.2 (2023-06-14) (c5309336)
### Enhancement - Null Context Update
* Updated `terraform-null-context` to use `terraform-null-context/modules/legacy`

## Version 1.2.1 (2022-05-02) (i868402)
### Bugfix - S3 ACL header bug
* Need to define either Canned or Custom ACL
* Set to canned ACL "private"

## Version 1.2.0 (2022-04-20) (i868402)
### Enhancement - Output Update
* Fork of `ibp-customer-infrastructure`
* Changed the code for S3 Buckets using c5339660's work
* Changed to Semantec Versioning

## Version 0.13-000009 (1.1.9) (2022-03-02) (i868402)
### Enhancement - Output Update
* Add new nat gateway and routes to outputs
* New output format for route table for more scalable consumption

## Version 0.13-000009 (1.1.8) (2022-03-02) (i868402)
### Enhancement - Output Update
* Add new nat gateway and routes to outputs
* New output format for route table for more scalable consumption

## Version 0.13-000008 (1.1.7) (2022-03-01) (c5339660)
### Enhancement - Add NAT Gateways for each availability zone
* Sets routing tables to the corresponding NAT gateway

## Version 0.13-000007 (1.1.6) (2021-09-03) (c5329049)
### Enhancement - Update required_providers for terraform
* assigned default value to module_dependency variable

## Version 0.13-000006 (1.1.5) (2021-05-10) (c5309377)
### Bugfix - Update required_providers for terraform
* update versions.tf to the format required by Terraform 0.13 (and later)

## Version 0.13-000005 (1.1.4) (2021-04-29) (i868402)
### Enhancement - Update Backup Service Role ARN
* Update to use passed in Backup Service Role ARN

## Version 0.13-000004 (1.1.3) (2021-04-14) (i868402)
### Enhancement - Null Context Integration
* Update VPC with Null Context
* Update Security Group with Null Context
* Update other minor tagging with null context

## Version 0.13-000003 (1.1.2) (2021-03-20) (i868402)
### Enhancement - Backup Vault
* Add variable for Backup Vault Customer Tags

# Version 0.13-000002 (1.1.1) (2021-03-17) (i514383)
### Enhancement - aws backups
* Adds the AWS Backup Service configuration to the ibp-customer-infrastructure and ibp-customer0000-example modules
* Removes legacy declarative terraform code

## Version 0.13-000001 (1.1.0) (2021-02-22) (i511522)
### Enhancement - Added outputs for workspace consumption
* Added necessary outputs for sms-transit-gateway integration

## Version 0.12-000012 (1.0.12) (2020-12-15) (i868402)
### Enhancement - Remove NS2-Access Security Group
* Remove NS2-Access Security Group

## Version 0.12-000011 (1.0.11) (2020-09-30) (i868402)
### Enhancement - Set Minimum Version
* Change Major version lock to minimum version as best practice by Hashicorp for terraform modules.

## Version 0.12-000010 (1.0.10) (2020-08-26) (i868402)
### Enhancement - DHCPOptions
* Provides ability to use custom DHCPOption

## Version 0.12-000009 (1.0.9) (2020-08-10) (i536519)
### Enhancement - Maintenance
* Removed the `##-` prefix from all the filenames

## Version 0.12-000008 (1.0.8) (2020-06-04) (i513825)
### BugFix - security group rules
* broke out security group rules for the following security groups to allow for dynamic modification from external resources
    * `customer_vpc`
    * `customer_access_management`

## Version 0.12-000007 (1.0.7) (2020-06-04) (i513825)
### BugFix - typo
* fixed small typo in module outputs
    * `subnet_edge_1ca_id` --> `subnet_edge_1c_id`

## Version 0.12-000007 (1.0.6) (i868402)
### Enhancement - IBP DR Support
* Add subnet edge 1b and 1c to output
* Add route table to output
* Add IGW to output
* Removed hardcoded S3 endpoint route table association
* Added dynamic S3 endpoint route table association
* Added route table association for dataservices 1b
* Removed excess commented subnet 1b


## Version 0.12-000006 (1.0.5) (i868402)
### Enhancement - IBP DR Support
* Enable creation of Production 1b subnet
* Update outputs
* Update route table association

## Version 0.12-000005 (1.0.4) (i868402)
### Enhancement - VPC
* Enable DNS Hostname Lookup
* Enable DNS Support

## Version 0.12-000004 (1.0.3) (i868402)
### Enhancement - CRE SMS Security Group
* Update to allow CRE SMS 10.64.0.0/16 and 10.200.0.0/16

## Version 0.12-000003 (1.0.2) (i868402)
### Enhancement - Support transit gateways
* Enable Edge SubnetB to support transit gateways
* Enable Edge SubnetC to support transit gateways

## Version 0.12-000002 (1.0.1)(c5295459)
### Enhancement - Syntax
* Fix syntax for terraform 0.12.11+
* No other functional or logical changes

## Version 0.12-000001 (1.0.0) (i868402)
### Initial version established with the following features
* VPC Creation
* Subnets Creation
*   Edge 1a
*   Production 1a
*   Dataservices 1a
*   Staging 1a
*   Pre-populated templates for:
*     Edge 1b
*     Production 1b
*     Dataservices 1b
*     Staging 1c
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
