# Latest Version
2.9-000047

# Version History
## Version 2.9-000047 (2023-12-5) (i548447)
### Bugfix - Add region to aws command for KMS lookup
* Add region to aws cli command for KMS lookup as this will error when querying regions other than region set in AWS profile

## Version 2.9-000046 (2023-03-20) (c5357274)
### Enhancement - updated volume type for AWS in disk-management role
* Updated the default type of volume from gp2 to gp3 in the aws-create.yml in the disk-management role.

## Version 2.9-000045 (2022-12-15) (c5336940)
### Bugfix - Update to gcp-create.yml to prevent non-idempotent behavior
* The "Attach disks to instance" task did not have a control structure to prevent it from running when unneeded.
* By running when unneeded, it was 1) causing failures and 2) creating additional block storage devices.
* This update prevents the task from running when not needed, generally on subsequent runs of the role.

## Version 2.9-000044 (2022-11-21) (i555365)
### Enhancement - Update to gcp-create.yml for disk creation/snapshot creation
* Update to gcp-create.yml for disk creation/snapshot creation

## Version 2.9-000043 (2022-08-22) (i511522)
### Enhancement - Added Ubuntu 20.04 distribution validation
* Added ubuntu 20.04 validation for the `Set filesystem default to 'xfs' for RHEL7/Ubuntu` task

## Version 2.9-000042 (2022-08-22) (i511522)
### Enhancement - GCP snapshot policy attachment
* Added GCP disks snapshot policy attachment functionality
* Added default value for `gcp_disk_snapshot_policy`

## Version 2.9-000041 (2022-07-12) (c5336940)
### Bugfix - GCP create remove asychronous disk attachment
* This change removes asynchronous attachment so that disks are attached as desired.
* Fixed spelling in task name.

## Version 2.9-000040 (2022-06-23) (i511522)
### Bugfix - AWS create int cast on volume size
* Added int cast on volume size to prevent playbooks from passing non-integer values

## Version 2.9-000039 (2022-06-15) (i511522)
### Enhancement - AWS gp3 support
* Added AWS gp3 volume type support
  * tested with ansible `[core 2.12.4]`

### Bugfix - AWS json_query for volume size and id
* json_query for volume size and id updated to only use one query not using `contains`

## Version 2.9-000038 (2022-05-27) (i514383)
### Bugfix - instance/hostname
* Change loop value from hostname to name

## Version 2.9-000037 (2022-05-20) (i513825)
### Bugfix - json_query
* Fix issues with `contains()` method in json_query function calls

### Bugfix - Nested volume grep syntax
* Ensure `grep` logic used to lookup devices names based on mount point account for the possibility of nested mounted volumes
* Query logic now uses regex with `....$` at the end to ensure search for mount point matches exactly

## Version 2.9-000036 (2022-05-13) (i511522)
### Bugfix - Azure disk caching value
* Change 'None' to '' for disk caching over 4095

## Version 2.9-000035 (2022-05-07) (i511522)
### Bugfix - Azure disk caching
* Set `attach_caching` to 'None' when disk size > 4095

## Version 2.9-000034 (2022-04-07) (i511522)
### Bugfix - Ensure GCP kms key is defined when checking validity
* Change logic for kms key check to only when a key is defined instead of the boolean `disk_encryption`

## Version 2.9-000033 (2022-04-05) (i537609)
### Bugfix - Fixed conditional for resizing AWS volumes
* Updated AWS volume resizing conditional to check for `azure_resource_group == ''` rather than `azure_resource_group is not defined`
* Fixed documentation to properly state the value of `azure_reosurce_group`

## Version 2.9-000032 (2022-03-09) (c5335489)
### Enhancement - disk creation tasks now supports both instance auth and credentials auth in GCP
* Refactored GCP authentication to support authentication from a VM instance and local machine in GCP

## Version 2.9-000031 (2022-03-30) (i511522)
### Bugfix - AWS Create us-gov-east-1 get new device names
* Revert logic change in previous MR that breaks us-gov-east-1 functionality

## Version 2.9-000030 (2022-02-23) (i537609)
### Bugfix - Fixed conditional for validating AWS credentials
* Updated AWS validation conditional to check for `azure_resource_group == ''` rather than `azure_resource_group is not defined`
* Updated Azure validation conditional to check if `azure_resource_group is defined` and it is not `azure_resource_group == ''`

## Version 2.9-000029 (2022-02-15) (i868402)
### Bugfix - Azure Disk Management fixes
* Tweak Azure conditionals to make it easier for multi-cloud playbook execution
* add default for azure_resource_group

## Version 2.9-000028 (2022-02-14) (i868402)
### Bugfix - Azure Disk Management fixes
* Fix when conditionals preventing Azure tasks to be run.
* Disable Async creation due to Azure API collisions (Azure Support case #2201250040000220)
* Modify Disk search for LUN Attachments

## Version 2.9-000027 (2022-02-08) (c5339660)
### Bugfix - Restore functionality on Legacy AWS Systems (non-Nitro)
* Allows the role to be used for both standard Nitro AWS instances and Legacy Non-Nitro instances

## Version 2.9-000026 (2022-01-21) (i870146)
### Enhancement - Added Flag to replace ec2 ansible placement region
* Sets ansible_ec2_placement_region to aws_region

## Version 2.9-000025 (2022-01-18) (c5323009)
### Bugfix - Updated galaxy_info variables missing breaking molecule test runner
* Added role_name and namespace variables if missing broke molecule test runner

## Version 2.9-000024 (2022-01-06) (c5335697)
### Bugfix - update conditions on azure-create and aws-create
* `azure_resource_group` either has a valid value or blank. A blank value should be treated the same as 'undefined'. Updated tasks/main.yml conditions to reflect that.

## Version 2.9-000023 (2021-12-17) (i868402)
### Bugfix - update azure-create
* update azure create to handle temporary disks
* Update async logic so it doesn't error on skipped tasks
* Efficiency improvements

## Version 2.9-000022 (2021-12-9) (i511522)
### Enhancement - Azure async create
* Added async disk creation for Azure
* Updated partitioning logic to support Azure async disk creation
* Add ability to pass azure_disk_type in disk vars

## Version 2.9-000021 (2021-11-18) (i868402)
### Bugfix - Fixed Azure Create
* Fixed incorrect values for azure

## Version 2.9-000020 (2021-09-16) (i548369)
### Enhancement - Added Support for GCP
* Now able to create and resize disks in GCP in alignment with existing standards
* Adds support for encrypted disks by giving KMS keyring and key
* Adds support for magnetic (HDD) and solid state (SSD)

## Version 2.9-000019 (2021-05-05) (c5323009)
### Bugfix - Updated ns2-scp-dev.sapns2.us domain to gitlab.core.sapns2.us
* Updated issue_tracker_url variable using old gitlab domain to new core services domain

## Version 2.9-000018 (2021-04-14) (i869415)
### Bugfix - Fixed executions for commercial regions
* Fixed a bug where AWS Commercial executions would fail.
* Modified a conditional to accept regions other than 'us-gov-west-1' or 'us-gov-east-1'.

## Version 2.9-000017 (2021-04-02) (i869415)
### Bugfix - Fixed KMS key ID validation
* Fixed the conditional used in KMS key ID validation.

## Version 2.9-000016 (2021-03-19) (i511522)
### Enhancement - Refactor
* Create gpt partition using parted module
* Use ec2_vol module to create and attach ebs volumes in us-gov-west-1
* Create volumes in parallel
* Dynamic variable discovery for disk creation and resizing

## Version 2.9-000015 (2020-10-13) (i513825)
### Enhancement - add `disk_preset_selection` for SAP Hana Cockpit
* Add default `disk_preset_selection` for SAP Hana Cockpit:
  * `/hana/backups` - twice the current ram
  * `/hana/shared` -  current ram (maximum 1tb)
  * `/hana/data` - twice the current ram
  * `/hana/log` - half current ram (maximum 1tb)
  * `/usr/sap` - 50 GB

## Version 2.9-000014 (2020-09-22) (i839460)
### Bugfix - Fixed issues with creating swap
* Swap now creates properly if an existing swap partition already exists
* Added additional disk output for clarity
* Added validation tests for AWS and Azure CLI authentication

## Version 2.9-000013 (2020-08-03) (i861009)
### Enhancement - Optimize pauses
* Replaced 10 pause with `wait_for` task

## Version 2.9-000012 (2020-07-31) (c5295459)
### Bugfix - add additional pause for fdisk
* Added 5 second pause for fdisk to recognize newly mounted volume

## Version 2.9-000011 (2020-07-29) (i861009)
### Enhancement - Support for more platforms
* Added support for Ubuntu 18.04
* Added support for RHEL 8.1/8.2
* Temporarily deprecating the use of `ec2-vol`

## Version 2.9-000010 (2020-06-16) (i861009)
### Enhancement - Removed prerequisites installation
* Removed all prerequisite installation, feature to be moved into Base module

## Version 2.9-000009 (2020-06-12) (i869415)
### Bugfix - Remove localhost install of boto
* Removes tasks and task files that install boto on the localhost.
* Having boto installed ahead of time is now a dependency of the role.

## Version 2.9-000008 (2020-06-03) (i861009)
### Enhancement - LVM partition improvements
* Create partition for lvm instead of installing on raw disk
* Automatic partition/lvm resizing (AWS only)
* Updated platform prerequisites
* Full refactor

## Version 2.9-000007 (2020-03-10) (i869415)
### Bugfix - Fixed usage of pip
* Fixed issues with pip by updating `setuptools` and installing `python2-wheel` packages.

## Version 2.9-000006 (2020-03-02) (i869415)
### Enhancement - S4/HANA deployment defaults
* Added defaults for S4/HANA deployment.

## Version 2.9-000005 (2020-02-19) (i869415)
### Bugfix - Fixed creating encrypted volume without KMS key ID
* Fixed issue when creating an encrypted volume without a KMS key ID.

## Version 2.9-000004 (2020-02-17) (i869415)
### Bugfix - Fixed AWS volume create for 'us-gov-east-1' region.
* Added code to get around a bug where the 'ec2_vol' Ansible module does not support the 'us-gov-east-1' region.
* Replaced 'local_action' with 'delegate_to'.

## Version 2.9-000003 (2019-11-26) (i516349)
### Enhancement - Adding ecc payroll defaults
* Adding variables for `ecc_pas_production` and `ecc_hana_production`

## Version 2.9-000002 (2019-11-19) (i869415)
### Bugfix - Fixed formatting of local_action
* Fixed formatting of local_action use.
* Added variable to skip downloading dependencies from pip for internet restricted environments.
* Fixed names for Azure disks

## Version 2.9-000001 (2019-11-13) (i869415)
### Bugfix - Fixed vars lookup for disk_preset
* Fixed vars lookup for disk_preset variable.
* Fixed use of search test.
* Replaced ansible_product_uuid with custom generated uuid.
* Remove dashes from the uuid.
* Corrected regex in `lsblk` grep.
* Make ec2_instance_facts be local_action.

## Version 2.8-000013 (2019-11-08) (i869415)
### Bugfix - Fix swap commands and conditionals
* Fix swap commands and conditionals

## Version 2.8-000012 (2019-11-04) (i511522)
### Feature - Adding Capability to Auto-Calculate Disk Values
* Removing `create-nvme` task file in favor of less complex looping
* Removing `create-azure` task file in favor of less complex creation
* Consolidating AWS and Azure disk creation efforts
* Removing the need to define `device_name_aws` and `device_name_pvs` variables

### Enhancement - Improving Volume Randomization Value
* Adding `volume_name_randomization_method` with a default value of `uuid` to assist with HCM concerns

## Version 2.8-000011 (2019-10-21) (i516349)
### Enhancement - Update meta file
* Adding metadata for Ansible galaxy

## Version 2.8-000010 (2019-08-05) (i516349)
### Bugfix - Fixing RHEL6 conditional
* Adjusting conditional to ensure proper execution for RHEL6

### Feature - Adding Default Filesystems for RHEL
* Adding in tasks to auto-determine default filesystem types for RHEL6 (ext4) and RHEL7 (xfs)

## Version 2.8-000009 (2019-07-18) (i516349)
### Bugfix - Simplifying Azure conditional
* Removing unnecesary conditional statements for Azure

### Bugfix - Adding AWS tags for non-nitro volumes
* MountPoint and Hostname tags will now be consistent across all volumes

## Version 2.8-000008 (2019-07-16) (c5290493)
### Enhancement - Added Support for Azure
* Now able to create (and eventually resize) disks in Azure.

## Version 2.8-000007 (2019-06-24) (i516439)
### Bugfix - Sorting AWS Disk Names
* Sorting the aws pvs variable to assist with nitro-instance usecases

## Version 2.8-000006 (2019-06-10) (i516349)
### Bugfix - Whitespace issues on RHEL6 task
* Fixed whitespace which was causing playbook to not run

## Version 2.8-000005 (2019-06-06) (i516349)
### Feature - Parameterizing default filesystem
* Default filesystem type is now xfs
* New playbook created to handle legacy rhel6 usecase if packages are not already present

## Version 2.8-000004 (i516349)
### Bugfix - Conditional for nitro-based instance types
* Resolved conditional rather than reverting to legacy fix

## Version 2.8-000003 (i516349)
### Enhancement - Added parameter to support changing default volume type
* Added variable to handle disk volume type

## Version 2.8-000002 (2019-05-29) (c5272575)
### Feature - Added tags and improve searching for PVS id
* Added use of PVS from the custom dict to make sure correct volume is mapped to AWS device
* Changed sort order to use "aws" device to preserve the sequence of volume addition

## Version 2.8-000001 (2019-05-27) (i516349)
### Bugfix - Adding missing disk encryption value for nvme
* Adds variable to enable specific kms keys to be passed during creation on nitro-based instances
* Adds variable to enable encryption of swap volumes due to customer requirements
* Fixes sorting for nvme disk creation

## Version 2.7-000005 (2019-05-23) (c5283382)
### Feature - Adding support for nitro-based instances
* Adds logic to ensure disks created on nitro-based instances are created in the correct order

## Version 2.7-000004 (2019-05-20) (c5283382)
### Feature - Added encryption functionality
* Adds ability to specify a default encryption key for the volumes to be created

## Version 2.7-000003 (2019-05-20) (i516349)
### Enhancement - Adding IBP defaults
* Adds IBP-related default variable groups for test and production environments

## Version 2.7-000002 (2019-04-19) (i516349)
### Feature - Disk Encryption and Swap Volume Creation
* Adds ability to encrypt volumes using default kms key for region
* Adds ability to intelligently create swap volume and enable swap use

## Version 2.7-000001 (2019-03-22) (i516349)
### Initial version established with the following features
* Enables disk creation via preset variables in defaults
* Leverages task-level looping rather than looping an entire play
* Provides preset disk groups for sap application and sap hana products
* Attempts to resize disks using task-level looping
