# Latest Version
2.9-000011

# Version History
## Version 2.9-000011 (2024-07-18) (i746373)
### Bugfix 2.9-000010 broke all other OS
* Corrected syntax that was added to support ALS2

## Version 2.9-000010 (2024-07-17) (i511522)
### Enhancement - Added Amazon Linux 2 support
* Added task in main.yml for Amazon Linux 2 configuration
* Apdated logic in main.yml for generic OS based configuration to exclude Amazon Linux 2 hosts
* Added configure-amazon-linux.yml to configure Amazon Linux 2 hosts

## Version 2.9-000009 (2024-03-12) (i568607)
### Enhancement - Added support for RHEL 9
* Added RHEL 9 SELinux package dependencies

## Version 2.9-000008 (2023-11-30) (i548472)
### Bugfix - Update ansible.builtin.include to ansible.builtin.include_tasks
* Update ansible.builtin.include to ansible.builtin.include_tasks as include has been deprecated

## Version 2.9-000007 (2022-11-07) (i513825)
### Enhancement - Reboot via Handler
* Simplify logic to call for a reboot of the system by doing so via notified handler instead of duplicated tasks

### Enhancement - Leverage Grubby
* Ensure `grubby` is used to enable/disable selinux in addition to previous grub configuration file modification methods

## Version 2.9-000006 (2022-01-18) (c5323009)
### Bugfix - Updated galaxy_info variables missing breaking molecule test runner
* Added role_name and namespace variables if missing broke molecule test runner

## Version 2.9-000005 (2021-05-05) (c5323009)
### Bugfix - Updated ns2-scp-dev.sapns2.us domain to gitlab.core.sapns2.us
* Updated issue_tracker_url variable using old gitlab domain to new core services domain

## Version 2.9-000004 (2020-10-28) (i513825)
### Enhancement - Added support for RHEL 8
* Modify set of installed package dependencies for SELinux when running on RHEL 8

## Version 2.9-000003 (2020-07-01) (i869415)
### Enhancement - Added support for Ubuntu
* Added support for Ubuntu
* Split up the reboot task by OS

## Version 2.9-000002 (2020-05-16) (i516349)
### Enhancement - Documentation update
* Updating documentation to align with remaining repository

## Version 2.9-000001 (2020-03-19) (i869415)
### Initial version established with the following features
* Installs the selinux or apparmor package and service(s)
