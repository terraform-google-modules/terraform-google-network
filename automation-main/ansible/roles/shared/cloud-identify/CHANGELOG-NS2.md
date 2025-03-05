# Latest Version
2.9-000006

# Version History
## Version 2.9-000006 (2024-02-05) (i568675)
### Enhancement - Add Azure Virtual Machine Name Output
* Add `machine_name` to cloud information outputted for Azure Government/Commercial clouds
  * Useful for working with the `Azure.Azcollection`Ansible collection, where some modules rely on virtual machine names instead of IDs
  * Defaults to empty string for other cloud providers

## Version 2.9-000005 (2023-01-09) (i555365)
### bug fix - gcp cloud region - CM-18211
* GCP cloud identification bug fix to allow for identification when id string less then 19 characters(16-18)

## Version 2.9-000004 (2022-07-23) (c5335697)
### bug fix - azure cloud region
* Azure public/gov cloud identification bug fix

## Version 2.9-000003 (2022-05-16) (i868402)
### Enhancement - Cloud Region Data
* Store and pass back Cloud Region Data.  Useful for cloud in country purposes.

## Version 2.9-000002 (2021-11-17) (i513825)
### Enhancement - Cloud Partition Detection
* Implements logic to detect whether system is running in AWS GovCloud/Commercial or Azure Government/Commercial clouds

## Version 2.9-000002 (2021-11-17) (i513825)
### Bugfix - Ensure Shell runs as `/bin/bash`
* Ensure compatibility with systems that do not use bash as their default shells

## Version 2.9-000001 (2021-11-09) (i513825)
### Initial verion created with the following features:
* Leverages metadata endpoints to parse information about current cloud provider target host is running within
* Supports cloud provider detection for:
  * AWS
  * Azure
  * GCP
