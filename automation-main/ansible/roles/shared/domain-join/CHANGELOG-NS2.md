# Latest Version
2.9-000037

# Version History
## Version 2.9-000037 (2024-06-17) (i548447)
### Bugfix - Fix jinja2 template error
* SSHD AllowGroups jinja2 template was not adding space after default_users list

## Version 2.9-000036 (2023-11-30) (i548447)
### Bugfix - Update override_home_dir logic to handle file-transfer chroot
### Enhancement - Add default variable to allow option to require users to provide password to sudo
* Add variable domain_chroot_home_directories and conditional for override_homedir to handle chroot home directory without individual user directories
* Add variable domain_require_sudo_password to allow option to require users to authenticate when invoking sudo

## Version 2.9-000035 (2023-07-19) (c5323009)
### Bugfix - libsss-certmap package name for Ubuntu 20.04
* Fixed libsss-certmap package name to `libsss-certmap0`

## Version 2.9-000034 (2023-06-13) (i561481)
### Enhancement - Add additional realmd package dependencies for ubuntu 20.04+
* Adds additional realmd package dependencies for ubuntu 20.04+

## Version 2.9-000033 (2023-04-06) (i548447)
### Enhancement - Change default to use ignore_group_members
* No longer set ldap_group_nesting_level unless defined
* Add option to remove invalid config options (matching_rule_in_chain, nesting_level, tokengroups)
* Add var to toggle no_log for realm join tasks to prevent manual editing of role task file

# Version History
## Version 2.9-000032 (2023-03-15) (i511522)
### Bugfix - Use domain_set_dns variable for dyndns_update
* Use domain_set_dns variable for dyndns_update sssd configuration

## Version 2.9-000031 (2023-02-20) (i511522)
### Enhancment - Remove legacy sssd configurations
* Removed ldap_groups_use_matching_rule_in_chain and ldap_initgroups_use_matching_rule_in_chain

### Enhancement - Add ignore_group_members task
* Add ignore_group_members = True as optional sssd configuration

## Version 2.9-000030 (2023-02-02) (i548472)
### Bugfix - Set `krb5_store_password_if_offline` to false in sssd config for concourse workers
* Domain-join has been failing on restarting sssd on concourse workers since `krb5_store_password_if_offline` is set to true
* Set `krb5_store_password_if_offline` to false on concourse workers only

## Version 2.9-000029 (2022-12-20) (i548472)
### Enhancement - SMS Bastion Domain Join
* Ensure the SMS bastion has the `domain_user_home_path` set to `/nfs/home`

## Version 2.9-000028 (2022-11-03) (i548472)
### Enhancement - Adding inventory
* Added inventory directory to pass different variables depending on host

## Version 2.9-000027 (2022-10-27) (i513825)
### Bugfix - Ensure SSSD service is started
* In order to catch systems where the SSSD service has failed, always attempt to make sure the SSSD service is started at the end of execution

## Version 2.9-000026 (2022-07-08) (i868402)
### Bugfix - Int/String type mismatch
* Fix incorrect validation on type for `domain_log_level`
* As this is defined in defaults, removed extraneous validation

## Version 2.9-000025 (2022-06-29) (i513825)
### Enhancement - Enable SSSD logging
* Add optional variable `domain_log_level` to allow for customization of the SSSD log level, default set to 3

## Version 2.9-000024 (2022-02-28) (c5336940)
### Enhancement - Remove unused handlers, remove unused molecule test
* Removed rename hostname handler from domain-join-standalone playbook
* Removed rename hostname handler from domain-join role handlers/main.yml
* Removed molecule/handler/ directory and contents.  The molecule test only covered the rename hostname handler.

## Version 2.9-000023 (2022-02-24) (c5336940)
### Enhancement - Molecule test for domain join hostname rename functionality
* Created /molecule/host-rename test / scenario

## Version 2.9-000022 (2022-02-04) (c5336940)
### Enhancement - Created Block to ensure hostname is restored to original even if domain join fails.
* Created Block - Rename system, join domain, restore original hostname.
* Added Restore original hostname task to always block so that it will run in case of a domain join failure.

## Version 2.9-000021 (2022-01-18) (c5323009)
### Bugfix - Updated galaxy_info variables missing breaking molecule test runner
* Added role_name and namespace variables if missing broke molecule test runner

## Version 2.9-000020 (2021-12-03) (i513825)
### Bugfix - Instance hostname parsing to 15 charactes
* Restore missing functionality that ensures computer name is properly shortened to 15 characters as Active Directory dictates as its max

## Version 2.9-000019 (2021-11-17) (i513825)
### Bugfix - Ensure Shell runs as `/bin/bash`
* Ensure compatibility with systems that do not use bash as their default shells
* Leverage consistent logic with that of the `cloud-identify` role

## Version 2.9-000018 (2021-11-02) (i513825)
### Enhancement - Support GCP and Azure domain-joins
* Ensure logic to parse machine ID and temporarily set hostname supports domain joins for GCP instances and Azure virtual machines
* Ensure logic for SSH logins supports the fact that `cloud-user` is in use as the default user for GCP and Azure
* Provide additional `custom_default_user` for use cases where one might need to specify a custom default user to preserve remote access to the system for during the domain-join process

## Version 2.9-000017 (2021-09-17) (i516349)
### Bugfix - Increase compatibility with RHEL7
* Removes conditional forcing SSSD file creation only on RHEL 8

## Version 2.9-000016 (2021-08-04) (i548633)
### Enhancement - add handlers to rename hostname in case of failure
* Added handlers to handlers.yml as well as notify command after renaming of hostname task in case it fails

## Version 2.9-000015 (2021-05-05) (c5323009)
### Bugfix - Updated ns2-scp-dev.sapns2.us domain to gitlab.core.sapns2.us
* Updated issue_tracker_url variable using old gitlab domain to new core services domain

## Version 2.9-000014 (2021-04-29) (c5323009)
### Bugfix - add become true to individual tasks
* Add become true to individual tasks

## Version 2.9-000013 (2021-04-09) (i513825)
### Enhancement - configurable domain user home directory path
* Added variable `domain_user_home_path` to allow operators to configure domain user home directory location
* Only time this should be overridden is when used in conjuction with EFS for example to store domain user home directories

## Version 2.9-000012 (2021-03-30) (i868402)
### Bugfix - pam-auth-update force
* Add force flag to `pam-auth-update`

## Version 2.9-000011 (2021-03-09) (i513825)
### Bugfix - revert find-executable-path changes
* revert find-executable-path changes

## Version 2.9-000010 (2020-03-08) (i513825)
### Bugfix - dynamically search for `visudo`
* Some systems did not have common installation location for `visudo` on the root user's PATH
* Implemented a conditional search for `visudo` when it cannot be found on root user's path

## Version 2.9-000009 (2020-11-06) (i513825)
### Bugfix - Ubuntu home directory creation detection condition
* Add catch for pam-auth-update command to trigger on condition detected where it is needed, as well as on initial domain-join

## Version 2.9-000008 (2020-10-20) (i869415)
### Bugfix - Fixed Ubuntu home directory creation
* Fixed the creation of home directories on Ubuntu systems.

## Version 2.9-000007 (2020-10-20) (i869415)
### Bugfix - Move homedir settings tasks
* Moved tasks that set the 'fallback_homedir' and 'override_homedir' sssd settings.
* Prevents issues where the settings are placed in the wrong location within the '/etc/sssd/sssd.conf' file.

## Version 2.9-000006 (2020-10-15) (i513825)
### Bugfix - Set hostname condition
* Only set system hostname when system detected to not already be a part of a domain

### Bugfix - Add missing variable initialization
* `domain_full_home_directories`

### Enhancement - Multi AD security group support
* Enable ability to pass comma-separated lists for sudo and login groups

### Enhancement - Add flag to be able to reset SSSD cache
* Add flag to be able to reset SSSD cache to be able to pick up and Active Directory RBAC changes immediately

## Version 2.9-000005 (2020-10-13) (i513825)
### Bugfix - Removed logic for mounting shared filestystem
* Due to NFS mounting being scoped to its own Ansible role, this functionality has been removed

### Enhancement - Bring domain-join role up to parity with domain-join-standalone playbook
* Add domain_full_home_directories variable to determine of user home directories are `/user` or `/user@domain`
* Moved hostname revert task adjacent to realm join to avoid additional chance for error preventing hostname restoration

## Version 2.9-000004 (2020-09-19) (c5309377)
### Enhancement - Add shared file system support
* Adds support for automatically mounting a shared file system for all domain users

## Version 2.9-000003 (2020-08-11) (i861009)
### Enhancement - Validated support for RHEL8
* Added native escalation where required
* Added `sssd.conf` file creation for rhel8
### Bugfix - Fixed ubuntu 16 support
* Changed implementation of `realm join` for Ubuntu 16.04 due to a lack of support for the `--change-name` flag

## Version 2.9-000002 (2020-07-20) (i868402)
### Enhancement - Preserve original hostname
* Preserves the original hostname of the system.

## Version 2.9-000001 (2020-07-08) (i869415)
### Enhancement - Added support for Ubuntu
* Added support for Ubuntu systems.

## Version 2.8-000002 (2020-03-17) (i868402)
### Enhancement - Features
* Update to feature parity with domain-join-standalone.yml

## Version 2.8-000002 (2019-10-21) (i516349)
### Enhancement - Update meta file
* Adding metadata for Ansible galaxy

## Version 2.7-000001 (2019-08-28) (i868402)
### Initial version established with the following features
* Joins Red Hat Host to Active Directory Domain
