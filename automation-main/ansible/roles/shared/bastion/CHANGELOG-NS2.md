# Latest Version
2.9-000022

# Version History
## Version 2.9-000022 (2023-12-12) (i561481)
### Enhancement - Added yq installation
* Added yq installation to role

## Version 2.9-000021 (2023-01-11) (c5349318)
### Enhancement - Added `coreservices-l` vars file
* Added `coreservices-l` vars file

## Version 2.9-000020 (2022-07-28) (i511522)
### Enhancement - Added fed-s4pce vars file
* Added fed-s4pce vars file

## Version 2.9-000019 (2022-07-21) (c5309377)
### Bugfix - Remove duplicate YAML keys
* Removed duplicated YAML keys from vars files for sms-fuse/sms-hs

## Version 2.9-000018 (2022-07-14) (i870146)
### Enhancement - Added option to download terraform from s3
* Optional feature to download terraform from s3 if `bastion_setup_terraform_s3_bucket_name` is provided
* Updated configuration vars file sms-hs and sms-fuse to download terraform from s3

## Version 2.9-000017 (2022-07-12) (i513825)
### Enhancement - FED SMS Bastion Fly CLI Version
* Upgrade FED SMS Bastion Fly CLI version to match existing Concourse deployment
  * `6.7.4` -> `7.4.0`

## Version 2.9-000016 (2022-07-01) (i513825)
### Enhancement - Added vars file for FED SMS Bastion
* Added separate vars file for FED SMS Bastion

## Version 2.9-000015 (2022-05-16) (i868402)
### Enhancement - Add support for Azure S4PCE
* Added configuration vars file for Azure S4PCE
* Rename configuration vars file for AWS S4PCE

## Version 2.9-000014 (2022-03-15) (i870146)
### Enhancement - Added Fuse SMS Bastion vars file
* Added configuration vars file for Fuse SMS Bastion system deployment

## Version 2.9-000013 (2022-02-02) (i870146)
### Enhancement - Added vars file for HS SMS Bastion deployment.
* Added vars file for HS SMS bastion deployment.
* Added bastion_setup_ec2_placement_region variable Used with sms-provision-bastion to ensure Bastion can interact with ec2 if the ec2_metadata_facts (ansible_ec2_placement_region) is different from the aws_region.

## Version 2.9-000012 (2022-01-21) (i870146)
### Enhancement - Flag for Pip removal and option to download saml2aws and fly CLI from s3
* pip is removed when `remove_pip` is set to true
* Ansible python-based modules can be affected by the removal of pip on a system during execution (noticed error when running `sms-provision-bastion.yml`)
* Optional feature to download Saml2aws and Fly CLI from s3 if `bastion_setup_s3_bucket_name` is provided

## Version 2.9-000011 (2022-01-18) (c5323009)
### Bugfix - Updated galaxy_info variables missing breaking molecule test runner
* Added role_name and namespace variables if missing broke molecule test runner

## Version 2.9-000010 (2021-12-03) (i513825)
### Bugfix - Pip removal handler
* Ensure pip is removed at the end of role execution as a handler
* Prevents errors mid-execution as Ansible python-based modules can be affected by the removal of pip on a system during execution

## Version 2.9-000009 (2021-07-27) (i513825)
### Bugfix - Adjust SMS Bastion vars file
* Leverage Terraform v0.14.7
* Leverage Saml2aws v2.28.4
* Update jinja2
* Provision nightly cron job to keep bastion Ansible up to date with master

### Enhancement - Bastion option to install Concourse Fly CLI
* Optional feature to install Fly CLI on bastion

### Enhancement - Added Molecule test for addition of Fly CLI
* Test validates that Fly CLI is in fact installed on the system when `bastion_fly_cli_setup` is set to `true`

## Version 2.9-000008 (2021-05-21) (i868402)
### Bugfix - Add env path to cron jobs
* Adds env path to cron jobs

## Version 2.9-000007 (2021-05-12) (i513825)
### Enhancement - Added additional packages to SMS bastion configuration
* sendmail
* mailx

## Version 2.9-000006 (2021-05-05) (c5323009)
### Bugfix - Updated ns2-scp-dev.sapns2.us domain to gitlab.core.sapns2.us
* Updated issue_tracker_url variable using old gitlab domain to new core services domain

## Version 2.9-000005 (2021-04-12) (c5283389)
### Enhancement - Bastion SMS role Terraform update
* Set SMS bastion Terraform version to 0.13.5 from 0.13.2

## Version 2.9-000004 (2021-04-02) (i868402)
### Enhancement - IBP and S4 Refresh
* Refreshed IBP vars
* Added Dev-IBP vars
* Added S4PCE vars
### Enhancement - Boto install
* Add option for boto install

## Version 2.9-000003 (2021-02-23) (i511522)
### Enhancement - Cloudwatch alarm cleanup cronjob
* Added cronjob to run aws-cloudwatch-alarm-cleanup ansible weekly

## Version 2.9-000002 (2021-02-19) (i868402)
### Bugfix - Cron Path
* Fixed incorrect Cron path for IBP

## Version 2.9-000001 (2021-01-04) (i868402)
### Initial version established with the following features
* Bastion Provisioning for SMS
* Bastion Provisioning for IBP
