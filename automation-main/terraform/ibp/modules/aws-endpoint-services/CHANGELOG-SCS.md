# 2024-11-12 i868402
* Changed Changelog to new format.
* Removed unnecessary Provider in versions.tf

## Version 0.13-000012 (2022-03-02) (i868402)
### Enhancement - support ip targets
* Added support for ip targets

## Version 0.13-000011 (2021-09-27) (c5329049)
### Enhancement - Resolve AWS VPC Endpoint
* updated aws version
* updated the module so that endpoint acceptance is no longer required
* Modified the endpoint services modules to allow principals
* Removed module dependency related code

## Version 0.13-000010 (2021-09-03) (c5329049)
### Enhancement - Added cross-zone functionality to load balancer
* Added cross-zone functionality to load balancer

# Version History
## Version 0.13-000009 (2021-05-10) (c5309377)
### Bugfix - Update required_providers for terraform
* update versions.tf to the format required by Terraform 0.13 (and later)

## Version 0.12-000008 (2021-02-23) (i868402)
### Bugfix - Auto-acceptance workaround
* Workaround for the auto-acceptance bug

## Version 0.12-000007 (2020-10-30) (i868402)
### Bugfix - Auto-acceptance delay
* Partially fixes auto-acceptance with delay

## Version 0.12-000006 (2020-09-14) (i861009)
### Enhancement - Updated for new guidelines
* Updated file headers for new guidelines

## Version 0.12-000005 (2020-08-14) (i868402)
### Documentation - Versions and Examples
* Split out the testing example code for clarity
* Added minimum terraform and provider versions to module.
* Validated up to latest terraform

## Version 0.12-000004 (i868402)
### Enhancement - targetgroup arn
* Add output for target group arn needed by IBP DR

## Version 0.12-000003 (i868402)
### Enhancement - Syntax
* Fixup syntax for terraform.12+
* Added temporary ec2-key to testing environment
* removed variable for ec2-key as not needed anymore.
* No other Functional or Logical changes

## Version 0.12-000002 (i868402)
### Enhancement - Listener Port
* Added variable for Listener Port allowing for redirects

## Version 0.12-000001 (i868402)
### Initial version established with the following features
* Creates Network Load Balancer and connects to instance
* Creates Endpoint Service from the Network Load Balancer
* Creates Endpoint that consumes the Endpoint Service.
