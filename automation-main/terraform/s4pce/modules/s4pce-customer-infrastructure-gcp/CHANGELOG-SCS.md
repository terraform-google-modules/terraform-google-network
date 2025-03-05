# Latest Version
1.0.13

# Version History
## Version 1.0.13 (2024-09-12) (i555365)
#### Enhancement - Update data resource to output project id, not project name - PE505
* Update data resource to output project id, not project name - PE505

## Version 1.0.12 (2024-03-22) (i555365)
#### Enhancement - Enable flow logs for workload vpc subnets - PE366
* Enable flow logs for workload vpc subnets - PE366

## Version 1.0.11 (2024-04-15) (i555365)
#### Enhancement - Add service account for customer landscape - PE158
* Add service account for customer landscape - PE158
* Add IAM role to gcp cloud storage bucket for backups - PE158

## Version 1.0.10 (2023-11-21) (i555365)
#### Enhancement - Parameterize cloud storage lifecyle policy - PE122
* Parameterize cloud storage lifecyle policy - PE122

## Version 1.0.9 (2023-06-15) (i555365)
## Enhancement - update filestore to support custom sizes - BUILDSTE-6185
* Add a variable to allow custom filestore sizes - defaults to 1024 - BUILDSTE-6185

## Version 1.0.8 (2023-06-29) (c5309336)
### Enhancement - Null Context Update
* Updated `terraform-null-context` to use `terraform-null-context/modules/legacy`

## Version 1.0.7 (2023-06-08) (c5355631)
## Enhancement - Add lifecycle rules to storage buckets
* Added lifecycle policies to move objects to colder storage after 30 days and deleted after 180
* Versioned objects are moved to colder storage after 30 days and deleted after 180

## Version 1.0.6 (2023-04-20) (c5336940)
## Bugfix - Disable Cloud functions for GCP regions that only support cloud functions version 2
* Added locals to filestore.tf to determine if the deployed region is in the list of regions that only support CFv2
* Modified all cloud function resources to only deploy if cloud functions version 1 are available.
* This will be superseded by an enhancement to implement CFv2 functions

## Version 1.0.5 (2022-11-22) (i511522)
## Enhancement - Add filestore backup
* Add cloud scheduler and cloud function for customer filestore backups

## Version 1.0.4 (2022-09-19) (c5336940)
### Enhancement - Output
* Added customer edge networks 1a,1b,1c to outputs.tf

## Version 1.0.3 (2022-04-28) (i868402)
### Enhancement - Versions
* Set Version to minimum range
* Change to SemVer only for module
### Enhancement - Firewall Rules
* Changed to only allow backend subnets instead of entire CIDR

## Version 1.0.2 (2022-03-07) (i511522)
### Enhancement - Added GCS and filestore labels
* Added GCS and Filestore labels from context

## Version 1.0.1 (2022-02-17) (i511522)
* Added customer backups bucket

## Version 1.0.0 (2021-09-16) (i511522)
### Initial version established with the following features
* Deploys VPC
* Deploys Subnets
* Deploys firewall rules
* Deploys nat router
* Deploys customer NFS filestore
* Stub for customer backup buckets
