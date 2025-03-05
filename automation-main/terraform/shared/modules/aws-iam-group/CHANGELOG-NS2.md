# Latest Version
0.13-000008

# Version History
## Version 0.13-000008 (2021-05-10) (c5309377)
### Bugfix - Update required_providers for terraform
* update versions.tf to the format required by Terraform 0.13 (and later)

## Version 0.12-000007 (2020-09-14) (i861009)
### Enhancement - Updated for new guidelines
* Updated file headers for new guidelines

## Version 0.12-000006 (2020-08-14) (i868402)
### Documentation - Version and Validation
* Validated and added minimum versions

## Version 0.12-000006 (2020-08-11) (c5309336)
### Enhancement - add more outputs outputs
* Added iam_group_id to outputs
* Added iam_group to outputs

## Version 0.12-000005 (i513825)
### Bugfix - remove providers from terraform modules
* Terraform will fail when when missing code for resources with provider declarations

### Bugfix - added missing `aws_region` variable
* Added missing `aws_region` variable to `.tfvars` files

## Version 0.12-000004 (c5295459)
### Enhancement - Syntax
* Fix syntax for terraform 0.12.11+
* No other functional or logical changes

## Version 0.12-000003 (i868402)
### Bugfix - Hardcoded region
* Changed hardcoded region to a variable

## Version 0.12-000002 (i868402)
### Enhancement - Refactored to no longer use count variable
* Count Variable introduces problems for dynamic resources
* adding testing tfvars

## Version 0.12-000001 (i868402)
### Initial version established with the following features
* Creates multiple IAM Groups
* Attaches policies to IAM Groups as defined
