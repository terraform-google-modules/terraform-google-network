# 2024-11-13 i868402
* New Changelog format
* Added ObjectWriter to Ownership Controls to handle new AWS Defaults
* Update and Tested Example-Root with Recommended Versions
* Removed unneeded Providers from versions.tf

## Version 1.0.7 (2023-06-14) (c5309336)
### Enhancement - Null Context Update
* Updated `terraform-null-context` to use `terraform-null-context/modules/legacy`

## Version 1.0.6 (2022-06-10) (i511522)
### Bugfix - Service account read policy
* Use jsonencode policy instead of generic read template
  * Read template allows list all buckets
  * Service account unable to ls root of bucket

## Version 1.0.5 (2022-05-26) (i511522)
### Enhancement - Add service account functionality
* Add functionality to use service account instead of bucket replication

## Version 1.0.4 (2022-05-03) (i868402)
### Enhancement - Enable logging
* Enable logging for datasync

## Version 1.0.3 (2022-03-29) (i868402)
### Enhancement - Additional Functionality
* Bidirection datasync now available
* Custom datasync schedules available
* Datasync delete files option
* Outputs
* Updated example-root

## Version 1.0.2 (2022-03-21) (i868402)
### Bug - Missing variables
* Missing Variables for local versioning

## Version 1.0.1 (i511522)
### Initial version established with the following features
* Creates S3 Bucket with replication configurtion pointing to customer S3 bucket
* Create IAM role for replication
* Create EFS/Datasync feature
