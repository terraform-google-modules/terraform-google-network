# Latest Version
2.9-000017

# Version History
## Version 2.9-000017 (2025-02-12) (i746373)
### Enhancement - bug figs for ubuntu 20
* bug fix for ubuntu 20

## Version 2.9-000016 (2025-02004) (i746373)
### Enhancement - support for ubuntu 22
* Adds tasks related to enabling FIPS 140-2 for ubuntu 22

## Version 2.9-000015 (2024-10-30) (i537609)
### Enhancement - Added support for SLES 15 SP2 and SP5
* Adds tasks related to enabling FIPS 140-2 for SLES 15 SP2 and SP5

## Version 2.9-000014 (2024-09-20) (i537609)
### Bugfix - Enhancement - Added support for Ubuntu 22
* Adds tasks related to enabling FIPS for Ubuntu 22

## Version 2.9-000013 (2024-03-06) (i537609)
### Bugfix - Added new task for regenerating GRUB file
* Adds task to regenerate GRUB file to properly ensure FIPS is enabled upon reboot

## Version 2.9-000012 (2024-02-29) (i537609)
### Enhancement - Added support for RHEL 9
* Adds tasks related to enabling FIPS 140-2 for RHEL 9

## Version 2.9-000011 (2023-07-08) (i571239)
### Enhancement - Added support for SLES 15
* Adds tasks related to enabling FIPS 140-2 for SLES 15

## Version 2.9-000010 (2023-01-13) (i537609)
### Bugfix - Removed unnecessary packages from Ubuntu 20 task
* Removed outdated packages that are not required for FIPS enablement on Ubuntu 20 systems

## Version 2.9-000009 (2022-11-18) (i537609)
### Enhancement - Added tasks for Ubuntu 20
* Added tasks for checking, disabling, and enabling FIPS on Ubuntu 20

## Version 2.9-000008 (2022-11-02) (i513825)
### Bugfix - Reboot idempotency
* Refactor logic to only reboot systems when flag enabled and fips is being enabled or disabled
* Before this, systems were getting rebooted even if the state of FIPS on the remote host was not actually changing

### Enhancement - Taskfile organization
* Be consistent about the structure and format of how taskfiles for different OS distributions and major versions get included
* Gives us a more stable base in which to implement conditional logic for idempotent features such as requiring a reboot

### Enhancement - Documentation Formatting
* Touch up the README formatting and code snippets in a few places
* Update metadata for role about ubuntu compatibility

## Version 2.9-000007 (2022-07-21) (c5309377)
### Bugfix - Fix invalid YAML due to bare tabs
* Fixup YAML to no longer contain bare tabs by replacing with \t and enclosing with quotes

## Version 2.9-000006 (2022-01-18) (c5323009)
### Bugfix - Updated galaxy_info variables missing breaking molecule test runner
* Added role_name and namespace variables if missing broke molecule test runner

## Version 2.9-000005 (2021-07-29) (i869415)
### Enhancement - Added support for Ubuntu running in Azure
* Updated the 'disable/enable-fips.yml' task files for Ubuntu so that the Azure FIPS/non-FIPS kernel is correctly configured.
* Updated 'aws-ec2-enable-fips' Molecule scenario to use the new Golden Ubuntu OpenVPN image instead of the Base image.

## Version 2.9-000004 (2021-07-29) (i869415)
### Enhancement - Updating AWS EC2 Molecule subnet ID
* Updated the AWS EC2 Molecule scenario subnet IDs to be SHC Build Dev instead of Core Services Gov.

## Version 2.9-000003 (2021-05-05) (c5323009)
### Bugfix - Updated ns2-scp-dev.sapns2.us domain to gitlab.core.sapns2.us
* Updated issue_tracker_url variable using old gitlab domain to new core services domain

## Version 2.9-000002 (2021-01-22) (i535751)
### Enhancement - Support for Ubuntu 18
* Added support for Ubuntu 18
* Moved fips check,disable,enable into their own distribution type folder

## Version 2.9-000001 (2020-08-03) (i839460)
### Enhancement - Support for Red Hat 8
* Added support for Red Hat 8 with the /usr/bin/fips-mode-setup binary
* Moved Red Hat 7 checks into own yaml for clarity and simplification

## Version 2.7-000006 (2020-07-13) (i538152)
### Enhancement - Allow optional reboot
* Adding option to reboot the instance after fips is enabled or disabled

## Version 2.7-000005 (2020-01-16) (i516349)
### Enhancement - Refreshed role for style alignment
* Converting all variable names from camel case to underscores
* Changing `fipsModeEnabled` to `fips_mode_enabled`
* Updating readme to clarity as to what FIPS is and bios clarification

## Version 2.7-000004 (2019-10-21) (i516349)
### Enhancement - Update meta file
* Adding metadata for Ansible galaxy

## Version 2.7-000003 (2019-02-28) (i516349)
### Enhancement - Moved playbooks out of tests directory
* Moved enable and disable playbooks to playbooks directory

## Version 2.7-000002 (2019-02-27) (i516349)
### Enhancement - Added tests directory
* Adding test directory to ensure future testing capabilities

## Version 2.7-000001 (2018-12-19) (i868402)
### Initial version established with the following features
* Allows for enabling and disabling fips for Red Hat systems
* Installs relevant packages, rebuilds initramfs, and updates GRUB as needed
