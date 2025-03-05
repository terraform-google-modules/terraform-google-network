# Latest Version
2.9-000050

# Version History
## Version 2.9-000050 (2022-01-18) (c5323009)
### Bugfix - Updated galaxy_info variables missing breaking molecule test runner
* Added role_name and namespace variables if missing broke molecule test runner

## Version 2.9-000049 (2021-05-05) (c5323009)
### Bugfix - Updated ns2-scp-dev.sapns2.us domain to gitlab.core.sapns2.us
* Updated issue_tracker_url variable using old gitlab domain to new core services domain

## Version 2.9-000048 (2021-04-28) (i869415)
### Enhancement - Removed AWS account ID list variables
* Removed the variables containing the AWS account IDs used for image sharing.
* These variables have already been moved to the new 'image-sharing' Ansible role.

## Version 2.9-000047 (2021-04-23) (i869415)
### Enhancement - Removed image copying and sharing automation
* Removed all image copying and sharing automation and variables.
* The image sharing group variables have been moved to the new 'image-sharing' Ansible role.
* Moved the image version increment task files to the 'image-sharing' Ansible role.

## Version 2.9-000046 (2021-04-07) (i516349)
### Enhancement - Added AWS account IDs
* Added additional customer AWS account IDs to defaults for SCP, SHC, and NS2

## Version 2.9-000045 (2021-03-22) (i869415)
### Enhancement - Added AWS account IDs
* Added additional customer AWS account IDs to defaults for SHC to each group

## Version 2.9-000044 (2021-03-22) (i869415)
### Enhancement - Added AWS account IDs
* Added additional customer AWS account IDs to defaults for SCP

## Version 2.9-000043 (2021-03-15) (i869415)
### Enhancement - Added AWS account IDs
* Added additional customer AWS account IDs to defaults for NS2

## Version 2.9-000042 (2021-03-05) (i869415)
### Enhancement - Changed valid values for the 'aws_partition' variable
* Modified 'ami-multiple-copy-and-share.yml' so that the 'aws_partition' variable takes more descriptive values.
* Valid values for the 'aws_partition' variable are now 'aws_govcloud' and 'aws_commercial' which matches our 'golden-image-pipeline' naming conventions.

## Version 2.9-000041 (2021-03-01) (i869415)
### Enhancement - Added AWS account IDs
* Added additional customer AWS account IDs to defaults for NS2

## Version 2.9-000040 (2021-02-19) (i535751)
### Bugfix - ami-shareaccounts.yml
* Added task to wait for copied AMI to become available before moving on to next task
* Added ami_copy_wait_timeout to ami-copyregion.yml input vars
* Updated ami-copyregion.yml to have an accurate Synopsis and updated tasks to be more consistent

## Version 2.9-000039 (2021-02-15) (i535751)
### Enhancement - ami-multiple-copy-and-share.yml task for aws-copy-and-share-multiple-image playbook
* Added task for aws-copy-and-share-multiple-image playbook
* Added example image list in the vars folder (example-image-list.yml)

## Version 2.9-000038 (2021-02-08) (i535751)
### Feature - Added SPR management for shutting down and starting up SPR instances
* tasks now include shutdown-spr-instances and start-spr-instances
* cronbox-setup.yml now uses the cron module instead of copying cron files into the cron directory
* boto is now installed using pip when running on a RHEL 8 instance

## Version 2.9-000037 (2021-01-25) (i869415)
### Feature - Added task files for incrementing image versions
* Added a new directory of task files that are used to increment the image versions in an image inventory file.
* These task files and their corresponding playbook 'aws-increment-image-versions.yml' are to be used before new image releases.

## Version 2.9-000036 (2020-11-24) (i869415)
### Enhancement - Added variable for AMI copy timeout and updated Golden image tags
* Added a variable to adjust the AMI copy timeout and set it to 60 minutes.
* Updated the Golden image tags used by 'ami-recreate.yml' and 'ami-copyregion.yml'

## Version 2.9-000035 (2020-11-10) (i516349)
### Enhancement - Adding customer AWS account ID
* Moves core services and sms into ns2 group
* Updates missing shc gov and commercial account ids

## Version 2.9-000034 (2020-10-22) (i869415)
### Enhancement - Added AUS account IDs
* Added additional customer AWS account ID to defaults for SCP AUS

## Version 2.9-000033 (2020-08-25) (i868402)
### Enhancement - Find missing name tags
* Adds `Name` tag and sets it to test-unamed to instances missing the tag

## Version 2.9-000032 (2020-08-18) (i516349)
### Enhancement - Adding customer AWS account ID
* Added additional customer AWS account ID to defaults for IBP

## Version 2.9-000031 (2020-08-04) (i869415)
### Enhancement - Adding account IDs
* Added additional customer AWS account ID to defaults for SHC

## Version 2.9-000030 (2020-08-04) (i514383)
### Bugfix - Updating syntax for ansible 2.9+ compatibility
* Updating requirements list to include ansible 2.9+
* Updating syntax for compatibility with ansible 2.9+

## Version 2.9-000029 (2020-07-21) (i537609)
### Enchancement - Removed underscores from filenames
* Changed cron job file names' from underscores to dashes
* Updated `cronbox-setup.yml` accordingly

## Version 2.9-000028 (2020-07-17) (i516349)
### Enhancement - Adding customer AWS account ID
* Added additional customer AWS account ID to defaults for SCP

## Version 2.9-000027 (i516349)
### Bugfix - Adding customer AWS account ID
* Updated duplicate value to leverage accurate id

## Version 2.9-000026 (i516349)
### Enhancement - Adding customer AWS account ID
* Added additional customer AWS account ID to defaults for NS2

## Version 2.9-000025 (i516349)
### Enhancement - Adding customer AWS account ID
* Added additional customer AWS account ID to defaults for SHC

## Version 2.9-000024 (2020-06-04) (i511522)
### Enhancement - Changed ec2_instance_facts to ec2_instance_info
* Changed ec2_instance_facts to ec2_instance_info for ansible 2.9+

## Version 2.9-000023 (2020-06-02) (i513825)
### Enhancement - Share hcm_gov images with cre splunk workload account
* Adds the CRE Splunk Workload account to grouplist for HCM Gov image sharing

## Version 2.9-000022 (i516349)
### Enhancement - Adding customer AWS account ID
* Added additional customer AWS account ID to defaults

## Version 2.9-000021 (i516349)
### Enhancement - Adding customer AWS account ID
* Added additional customer AWS account ID to defaults

## Version 2.9-000020 (i869415)
### Feature - Added task for recreating images.
* Added the task file `ami-recreate.yml` that recreates images from a snapshot.
* New task to be used with the playbook `aws-recreate-image.yml`.

## Version 2.9-000019 (i516349)
### Enhancement - Adding customer AWS account ID
* Added additional customer AWS account ID to defaults

## Version 2.9-000018 (i516349)
### Enhancement - Adding customer AWS account ID
* Added additional customer AWS account IDs to defaults
* Removed deprecated accounts and sorted numerically

## Version 2.9-000017 (i869415)
### Enhancement - Multi-destination region support
* Allow for multiple destination regions.

### Bugfix - Write custom wait task and get latest AMI
* Added tasks to manually wait for the AMI to copy to the destination region.
* The built-in wait feature of `ec2_ami_copy` sometimes failed due to timeouts.
* Fixed task that gets the latest AMI information.

## Version 2.9-000016 (i869415)
### Enhancement - Collapsing cre_gov account ID group
* Removed an SCP-related account ID from the cre_gov group.
* Moved all remaining cre_gov account IDs to the hcm_gov group.

## Version 2.8-000015 (i516349)
### Enhancement - Adding customer AWS account ID
* Added additional customer govcloud AWS account ID to the default vars file

## Version 2.8-000014 (i869415)
### Enhancement - Added additional AWS account ID
* Added additional customer AWS account ID to defaults for NS2

## Version 2.8-000013 (i514383)
### Feature - Updating volume deletion capability
* Adding task to force-delete all available volumes, regardless of age or tags

## Version 2.8-000012 (i516349)
### Bugfix - updating permissions
* Adding `become` to necessary task

## Version 2.8-000011 (i516349)
### Enhancement - Update meta file
* Adding metadata for Ansible galaxy

## Version 2.8-000010 (i514383)
### Feature - Add AMI and volume deletion capabilities
* Added age-based AMI deletion capabilities
* Added age-based volume deletion capabilities

## Version 2.8-000009 (i516349)
### Enhancement - Add customer AWS account ID
* Added `aws_destination_accounts_countertack_commercial` variable group
* Added additional customer commercial AWS account ID to the default vars file

## Version 2.8-000008 (i516349)
### Enhancement - Add customer AWS account ID
* Aligned AWS account IDs with asset management team to the default vars file
* Added `aws_destination_accounts_scp_commercial` variable group
* Renamed `aws_destination_accounts_ebs_gov` to `aws_destination_accounts_ibs_gov`

## Version 2.8-000007 (i516349)
### Enhancement - Add customer AWS account ID
* Added additional customer gov AWS account ID to the default vars file

## Version 2.8-000006 (i516349)
### Enhancement - Add customer AWS account ID
* Added additional customer gov AWS account ID to the default vars file

## Version 2.8-000005 (i869415)
### Enhancement - Add customer AWS account ID
* Added additional customer gov AWS account ID to the default vars file

## Version 2.8-000004 (i869415)
### Enhancement - Add new customer AWS account ID
* Added new customer commercial AWS account ID to the default vars file

## Version 2.8-000003 (i869415)
### Bugfix - Cronfile path
* Updated the ansible playbook path in the cron files.

## Version 2.8-000002 (i868402)
### Feature - Role aws-automation-tools enhanced
* Added task to copy ami to regions
* Added task to share ami with other accounts
* Added task to fine latest version of a AMI Name
* New default lists of accounts for AMI Sharing

### Feature - New Playbook to copy and share ami
* New Pipeline playbook to copy and share amis

## Version 2.8-000001 (i516349)
### Enhancement - Added hostname normalization syntax
* Added filter on hostname-rename task to convert `/` to `-`

## Version 2.7-000011 (c5283382)
### Feature - Updating yum repos in S3
* Added 4 new cron tasks to update the yum repos currently kept in S3 via an ansible playbook

## Version 2.7-000010 (i868402)
### Enhancement - Rename the hostname
* New task added, renames hostname to match AWS Tag Name.  Targets off of AWS private IP
* Accepts private IP address as input
* Not currently called by any playbooks or the main task.

## Version 2.7-000009 (i868402)
### Feature - Create VPC
* Enhanced VPC creation by allowing loading custom variable files
* Custom variable files can be specified through the playbook, or as an extra vars `vpc_vars`
* Added subnet-name variable to allow for custom subnet names
* added octet variable; can now generate unique VPCs by using extra vars for `vpc_name` and `vpc_octet`

## Version 2.7-000008 (c5283382)
### Bugfix - Timezone adjustment
* Updated timezones in instance-rename task to 0310 UTC

## Version 2.7-000007 (c5283382)
### Feature - Added Instance Shutdown feature
* A playbook will shutdown any test instances
* A cron task has been added and scheduled to run the shutdown playbook every night at 2300 EST / 0300 UTC

## Version 2.7-000006 (i868402)
### Feature - Added cronbox-setup
* Enables logging in ansible.cfg
* Enables log rotation for /var/log/ansible.log

### Bugfix - cron times
* Correctly set UTC cron time for cronjob `clean_instances`

## Version 2.7-000005 (i868402)
### Enhancement - Added VPC Creation
* Added create-vpc.yml task which will create a new AWS VPC with default options
* Added create-vpc-vars.yml vars files to support new task
* Added aws-create-vpc.yml to run new task

## Version 2.7-000004 (c5283382)
### Enhancement - Test tag normalization
* Playbook will rename any ec2 instances from 'Test' to 'test'
* A cron task has been created to run the rename-instances playbook

## Version 2.7-000003 (i868402)
### Feature - Vault credential retrieval
* Playbook retrieves credentials from vault if not specified
* Role changed to use internal variables
*   aws_automation_access_key
*   aws_automation_secret_key

## Version 2.7-000001 (i868402)
### Initial version established with the following features
* Deletes instances from AWS
* Partial provisioning of Cronbox
