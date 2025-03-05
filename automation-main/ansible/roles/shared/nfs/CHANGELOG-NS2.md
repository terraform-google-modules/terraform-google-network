# Latest Version
2.9-000019

# Version History
## Version 2.9-000019 (2024-11-04) (i548447)
### Enhancement - Add efs_enable_fips option
* Add efs_enable_fips option to use FIPS-mode for stunnel.

## Version 2.9-000018 (2024-11-04) (i744693)
### Enhancement - Add nofail as default aws nfs option
* Add option of nofail to default aws nfs options.  This is the recommended setting by aws.

## Version 2.9-000017 (2024-03-27) (i571239)
### Enhancement - Add nfs_sync option
* Add option to synchronize local nfs_dictionary to remote state.

## Version 2.9-000016 (2024-01-30) (c5358702)
### Enhancement - Enable CloudWatch logging in efs-utils.conf
* Conditionally enable CloudWatch logging in efs-utils.conf based on nfs_enable_cloudwatch_logging variable.

## Version 2.9-000015 (2023-03-07) (i513825)
### Enhancement - nfs_force_remount
* Add optional flag to force a remount on all shares

## Version 2.9-000014 (2022-04-13)
### Bugfix - Update EFS access point mount logic
* Updated default value for `nfs_aws_efs_utils_s3_bucket` and `nfs_aws_efs_utils_s3_path` to empty strings
* Updated `src_root` varaible to `item.value.src_root` for access point mounting task

## Version 2.9-000013 (2022-04-07) (i511522)
### Bugfix - Update mount fstype to support GCP filestore
* Add conditional to not use nsf4 for GCP instances

## Version 2.9-000012 (2022-01-18) (c5323009)
### Bugfix - Updated galaxy_info variables missing breaking molecule test runner
* Added role_name and namespace variables if missing broke molecule test runner

## Version 2.9-000011 (2021-11-08) (i513825)
### Enhancement - Multi-Cloud Support
* Implement `cloud_provider` input to support mounting NFS shares in both Azure and GCP

## Version 2.9-000010 (2021-06-30) (i868402)
### Bugfix - item.value.src_root
* Incorrect reference to item.value.src_root

## Version 2.9-000009 (2021-06-29) (i513825)
### Bugfix - Conditional logic for filesystem DNS check
* Ensure task to check filesystem DNS resolves properly validate required components are defined to avoid failures

## Version 2.9-000008 (2021-06-28) (i513825)
### Bugfix - Stale file handle conditional logic
* Fix bug to properly detect stale file handles and remove them

## Version 2.9-000007 (2021-05-05) (c5323009)
### Bugfix - Updated ns2-scp-dev.sapns2.us domain to gitlab.core.sapns2.us
* Updated issue_tracker_url variable using old gitlab domain to new core services domain

## Version 2.9-000006 (2021-05-04) (i513825)
### Bugfix - conditional fix
* Dependency check for nfs_dictionary executed before traversing dictionary and testing EFS address DNS resolution
* Readme adjustments

## Version 2.9-000005 (2021-03-24) (i513825)
### Enhancement - add support for AWS EFS access point mounts
* Install necessary utilities to enable optional mounting of AWS EFS access points

### Enhancement - report non-changing mounts
* Add entries to nfs change cache during execution for unchanged mounts to better display execution information verbosely

### Bugfix - fix stale file handles
* Added logic to successfully detect and fix any stale file handles left from attempting to remove filesystem mounts

### Bugfix - ignore errors retrieving filesystem mount information
* Added flags to prevent failures when a filesystem is successfully mounted but an access point purposefully does not permit read capabilities

## Version 2.9-000004 (2021-03-12) (i513825)
### Bugfix - default optional information when removing NFS share
* As opposed to failing on undefined variables, set defaults for optional attributes when caching changes made to removed NFS mounts

## Version 2.9-000003 (2020-12-11) (i513825)
### Bugfix - another correction to misleading documentation
* Fix example syntax for SSSD home directory configuration in `defaults/main.yml`

## Version 2.9-000002 (2020-10-28) (i513825)
### Bugfix - correct misleading documentation
* Fix example syntax for SSSD home directory configuration

## Version 2.9-000001 (2020-10-13) (i513825)
### Initial verion created with the following features:
* ability to add/remove network file share (NFS) mount
  * support RedHat and Ubuntu
* ability to configure SSSD user home directory location
