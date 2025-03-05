# 2024-11-12 i868402
* Changed Changelog to new format.
* Tested Version Requirements to match contributing guidelines.
* Updated Variables Documentation
* Added missing minimum version

## Version 0.13-000021 (2024-07-25) (i555365)
### Bugfix - Correct variable names - PRODENGINEERING-463
* LCM variable names truncated - correcting - PRODENGINEERING-463

## Version 0.13-000020 (2024-07-25) (i555365)
### Enhancement - Add variables to support s3 LCM policy modifications - PRODENGINEERING-463
* Add variables to support s3 LCM policy modifications - PRODENGINEERING-463

## Version 0.13-000019 (2024-01-10) (i555365)
### Enhancement - Add variables to support s3 bucket expiration - PRODENGINEERING-294
* Add variables to support s3 bucket expiration - PRODENGINEERING-294

## Version 0.13-000018 (2023-10-30) (i548219)
### Enhancement - Support customer0032 Elastic EFS
* Updated code to support EFS Elastic option - default provisioned
* Updated code to support EFS throughput defined in mibps - default 20 mibps

## Version 0.13-000017 (2023-08-29) (i548219)
### Enhancement - Support customer0032 local account dns zone
* Updated code to support c032 custom no local dns zone

## Version 0.13-000016 (2023-06-29) (c5309336)
### Enhancement - Null Context Update
* Updated `terraform-null-context` to use `terraform-null-context/modules/legacy`

## Version 0.13-000015 (2023-06-28) (i868402)
### Bugfix - Fix missing quotes
* Missing quotes

## Version 0.13-000014 (2023-05-23) (c5355631)
### Enhancement - Updated awss3-bucket module
* Updated versioning argument to 'Enabled'
* Updates aws provider version

## Version 0.13-000013 (2023-05-18) (i587430)
### Enhancement - Added private DNS to additional endpoints
* Updated VPC `additional_endpoints` to enable private DNS

## Version 0.13-000012 (2023-05-12) (i868402)
### Enhancement - Support for interface endpoints
* Update code to support interface endpoint deployment

## Version 0.13-000011 (2023-05-03) (i868402)
### Enhancement - Add options to deploy without NGW
* Add variable to deploy without NGW (Default False)

## Verison 0.13-000010 (2022-11-03) (i511522)
### Enhancement - Add s3 backup bucket cloud in country logic for label order
* Add logic for s3 backup bucket name for cloud in country label order

## Version 0.13-000009 (2022-07-09) (c5335697)
### Enhancement - Output Update
* upate for AWS region without zone C

## Version 0.13-000008 (2022-03-17) (i868402)
### Enhancement - Output Update
* EFS Mount Targets added to output

## Version 0.13-000007 (2022-03-02) (i868402)
### Enhancement - Output Update
* New output format for route table for more scalable consumption

## Version 0.13-000006 (2021-09-28) (i535751)
### Enhancement - Add output for efs
* Add output for efs usr_sap_trans

## Version 0.13-000005 (2021-09-03) (c5329049)
### Enhancement - Update required_providers for terraform
* assigned default value to module_dependency variable

## Version 0.13-000004 (2021-05-10) (c5309377)
### Bugfix - Update required_providers for terraform
* update versions.tf to the format required by Terraform 0.13 (and later)

## Version 0.13-000003 2021-02-23 (i868402)
### Enhancement - Missing Tag
* Add missing tag to S3 Endpoints

## Version 0.13-000002 2021-02-03 (i868402)
### Enhancement - EFS Bandwidth increase
* Increase EFS Bandwidth to support provisioning

## Version 0.13-000001 (i868402)
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
