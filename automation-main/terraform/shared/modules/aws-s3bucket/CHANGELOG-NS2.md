# Latest Version
0.13-000011

# Version History
## Version 0.13-000011 (2024-01-15) (i555365)
### Enhancement - Add variables to s3 lifecycle configuration - PRODENGINEERING-294
* Add variables to s3 lifecycle configuration - PRODENGINEERING-294

## Version 0.13-000010 (2023-05-23) (c5355631)
### Enhancement - Syntax added resources: s3 bucket versioning and s3 lifecycle configuration
* Added new resource blocks to replace depricated arguments in aws_s3_bucket resource
* changed lifecycle policy for versioned objects to be deleted after 180 days
* Added retention policy (disabled by default) to delete objects after 180 days

## Version 0.13-000009 (2021-05-10) (c5309377)
### Bugfix - Update required_providers for terraform
* update versions.tf to the format required by Terraform 0.13 (and later)

## Version 0.12-000008 (2020-08-14) (i868402)
### Documentation - Version and Validation
* Validated and added minimum versions

## Version 0.12-000007 (2020-07-08) (i513825)
### Enhancement - added variables to configure S3 transistions
* added `noncurrent_version_transition_days` input for the number of days after which noncurrent versions will transition, defaults to `15 days`
* added `noncurrent_version_transition_storage_class` input for the storage class to which noncurrent versions will transition, defaults to `GLACIER`
* added `transition_days` input for the number of days after which unaccessed content will transition, defaults to `30 days`
* added `transition_storage_class` input for the storage class to which unaccessed content will transition, defaults to `GLACIER`

## Version 0.12-000006 (2020-07-08) (i511522)
### Enhancement - added non-current version expiration variable
* Added noncurrent_version_expiration map value to allow logging/cloudtrail buckets to set their own expiration time

## Version 0.12-000005 (2020-06-19) (i513825)
### Enhancement - added owner tag, enforce tags
* Added missing `Owner` tag as optional, will not affect existing buckets that do not define this input
* Module now enforces tags

## Version 0.12-000004 (i513825)
### Bugfix - remove providers from terraform modules
* Terraform will fail when when missing code for resources with provider declarations

## Version 0.12-000003 (i868402)
### Enhancement - Syntax
* Fixup syntax for terraform.12+
* No other Functional or Logical changes

## Version 0.12-000002 (i868402)
### Bugfix - invalid count usage bug
* New variable to resolve invalid count bug

## Version 0.12-000002 (c5291361)
### Enhancement - inspec
* Added inspec tests for functional testing

## Version 0.12-000001 (i868402)
### Initial version established with the following features
* Creates S3 Bucket
* Sets default retention policy
* Optionally attach Bucket Policy
* Sets Public Access Settings
