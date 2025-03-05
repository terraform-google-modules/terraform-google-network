# Latest Version
2.9-000012

# Version History
## Version 2.9-000012 (2024-03-01) (i568675)
### Enhancement - Add support for '/etc/scs-release' when determining image tag
* Added logic to check for either '/etc/ns2-release' or '/etc/scs-release' when trying to obtain the original AMI release for each system
* Ensures aws_tag_image can be set using local artifacts on newer (SCS) Golden AMIs

## Version 2.9-000011 (2023-08-31) (i571239)
### Enhancement - Add aws_region to set region
* Added aws_region for ec2_ami_info module which specifies the region

## Version 2.9-000010 (2022-01-18) (c5323009)
### Bugfix - Updated galaxy_info variables missing breaking molecule test runner
* Added role_name and namespace variables if missing broke molecule test runner

## Version 2.9-000009 (2021-05-05) (c5323009)
### Bugfix - Updated ns2-scp-dev.sapns2.us domain to gitlab.core.sapns2.us
* Updated issue_tracker_url variable using old gitlab domain to new core services domain

## Version 2.9-000008 2021-04-07 (i513825)
### Enhancement - optional task delegation
* Provides users with configurable option to delegate tag-managment tasks to ansible controller or target host machines

### Bugfix - absolute path to `realm` binary
* Ensure proper detection of AD domain with misconfigured user PATH by leveraging absolute path to `realm` binary

### Bugfix - multiline conditionals
* Breaks lengthy single line conditionals into multiple lines for readability

## Version 2.9-000007 2021-04-01 (i868402)
### Enhancement - null-context support
* Added alternate mode where only tags outside of terraform null context control is enforced
### Enhancement - code refresh
* Removed obsolete "scan_group"
* Allowed processing of all OS's instead of just redhat
* Fixed incorrect "Patch Group"
* Normalized tags to "ManagedBy" and "GeneratedBy"
* Remove unnecessary become for realm list

## Version 2.9-000006 2020-10-21 (i868402)
### Enhancement - EC2 metadata
* Lookup ec2 metadata based on instance id

## Version 2.9-000005 (i511522)
### Enhancement - Update ec2_instance_facts to ec2_instance_info
* Changed ec2_instance_facts to ec2_instance_info

## Version 2.9-000004 (c5295459)
### Enhancement - Update Environment tagging
* Create single-/multi-tenant tags for SHC and IBP
* Switched to `delegate_to` as opposed to local actions
* Removed `AvailabilityZone` tag
* Updated `Platform` tag to denote `licensed` or `unlicensed` based on `Windows` vs `Linux` OS families, respectively
* Created tasks to tag disks with customer name, hostname, and instance ID

## Version 2.9-000003 (c5295459)
### Bugfix - Update Environment tagging
* Add ability to read in `Environment` tag if already configured
* Update `realm list` logic to pull domain information

## Version 2.8-000002 (c5295459)
### Enhancement - Add ScanGroup tag
* Add ScanGroup tag and default to `weekly`

## Version 2.8-000001 (c5290493)
### Initial version established with the following features
* Converted standalone AWS Tagging Playbook to more robust role.
* Adds automatic tagging of associated disks.
* Automatically determines certain tags, and sets values.
* Allows run-time supplied values, while preserving existing tag values if already set.
* Switch to allow the overwriting of existing variables.
* Tag set for SHC/IBP, with the option to easily expand to more product specific tags in the future.
