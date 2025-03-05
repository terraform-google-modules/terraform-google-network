# 2025-01-15 i571239
* Fix dev-management route53 attribute reference

# 2025-01-10 i868402
* Added layer-option and example AWS QTM submodule example.

# 2024-11-13 i868402
* Update and Tested Root Templates with Recommended Versions

# 2024-10-30 i868402
* Best Practice - added lifecycle ignore keeper so imports are possible.
* Added note on the sustainability of the gardener/sftp code.

## Version 1.0.8 (2024-10-10) (i868402)
### Enhancement - Dev-Management Update
* Update for internal Dev-Management deployments

## Version 1.0.7 (2024-09-09) (i743694)
### Enhancement - Backup Plan
* Update layer-02 to allow disabling and enabling of backup plan
* Added Terraform Variable enable_backup. Default is enabled
* Added count function to backup plan & selection resources withing backup.tf. Also added count.index to plan id of selection

## Version 1.0.6 2024-09-05 (i868402)
### Enhancement - Relative Paths
* Updated relative paths to support new Repo structure

## Version 1.0.5 2024-06-24 (i568675, i868402)
### Enhancement - Gardener SFTPGo Integration
* Added `gardener/sftpgo` integration
  * Specific to new Gardener-based SFTPGo solution
* Added new outputs to customer layers 00 and 02 to support this new integration
* Added more deployment documentation to the root module template README
* Creates Private Link Service/Endpoint in Bridge Network by supplying Loadbalancer Names.

## Version 1.0.4 2024-05-06 (i744710)
### Enhancement - S3 Bucket
* Update layer-02 to include an optional "backup" S3 bucket
* Added Terraform Variable and Terraform.tf files to include controls for the AWS S3 Bucket lifecycle

## Version 1.0.3 2024-04-29 (i868402)
### Enhancement - Management Template Support
* Added EXAMPLE_MANAGEMENT_KEY to support alternate management deployments
* Added EXAMPLE_MANAGEMENT_WORKSPACE to support workspace management deployments
* Updated Example CIDR Range to support new management template.
* Updated Terraform Version and Providers

## Version 1.0.2 2024-04-23 (i868402)
### Enhancement - AMI
* Update AMI Values

## Version 1.0.1 2023-07-26 (i868402)
### Enhancement - Terraform HA
* Terraform HA updated to support multiple HA Clusters

## Version 1.0.0 2023-07-21 (i868402)
### Initial version established with the following features
* S4PCE Customer Root Module Template
