# Latest Version
0.13-000006

# Version History
## Version 0.13-000006 (2021-05-10) (c5309377)
### Bugfix - Update required_providers for terraform
* update versions.tf to the format required by Terraform 0.13 (and later)

## Version 0.12-000005 (2020-08-14) (i513825)
### Documentation - Version and Validation
* Validated and added minimum versions
* Added group creation to example test

## Version 0.12-000004 (i513825)
### Bugfix - remove providers from terraform modules
* Terraform will fail when when missing code for resources with provider declarations

## Version 0.12-000003 (c5295459)
### Enhancement - Syntax
* Fix syntax for terraform 0.12.11+
* No other functional or logical changes

## Version 0.12-000002 (i868402)
### Enhancement - minor revision
* Removed usage of count variable
* Added testing tfvars

## Version 0.12-000001 (i868402)
### Initial version established with the following features
* Createst multiple IAM users
* Attaches policies to IAM users as defined
* Adds IAM users to defined groups
