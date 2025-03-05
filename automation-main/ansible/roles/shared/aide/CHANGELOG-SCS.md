# Latest Version
2.9-000021

# Version History
## Version 2.9-000021 (2024-06-7) (i746373)
### Bugfix - release 2.9-000020 broke on ubuntu-20
* correct the when statement to include ubuntu 20

## Version 2.9-000020 (2024-05-30) (i746373)
### Enhancement - Added support for Ubuntu-22 and Redhat 9
* add support for Ubuntu 22.04 and Red-Hat 9 release

## Version 2.9-000019 (2024-01-16) (i548447)
### Enhancement - Switch to aide-dynamic package for Ubuntu >= 20.04
* Switch to aide-dynamic for Ubuntu >= 20.04 due to bug in static version

## Version 2.9-000018 (2023-09-27) (i548447)
### Bugfix - Remove /var/log/lastlog$ from include paths
* Removed sha512 from PERMS rule in aide.conf to prevent high CPU alerts and significantly reduce aide run time.
* There is no DISA STIG that requires sha512 for PERMS rule
* Reference package default PERMS rule options: PERMS = p+u+g+acl+selinux+xattrs

## Version 2.9-000017 (2023-05-03) (i571239)
### Enhancement - Added support for Suse 15
* Added Audit Tools aide configuration from Suse 15 STIG
* Added config path for aide.conf for Suse 15

## Version 2.9-000016 (2023-04-06) (i548447)
### Enchancement - Added /root/.azcopy/ and /usr/sap/ to defaults ignored paths

## Version 2.9-000015 (2022-05-23) (i561481)
### Enchancement - Added /opt/concourse/worker to defaults ignored paths
* Added /opt/concourse/worker to defaults/main.yml ignored paths

## Version 2.9-000014 (2022-03-03) (c5335489)
### Enhancement - Updated aide role for asynchronous update flag
* Updated aide role to run update aide database async

## Version 2.9-000013 (2022-01-18) (c5323009)
### Bugfix - Updated galaxy_info variables missing breaking molecule test runner
* Added role_name and namespace variables if missing broke molecule test runner

## Version 2.9-000012 (2021-08-17) (i869415)
### Enhancement - Updated Molecule test
* Updated the Molecule test to work with the new RHEL Dockefiles.

## Version 2.9-000011 (2021-07-28) (i547123)
### Enhancement - Added molecule testing
* Added molecule directory with molecule.yml, converge.yml, and verify.yml
* Provides testing for both Debian and Redhat OS
* Tests for proper installation configurations, cron processes, and aide commands such as check and update.

## Version 2.9-000010 (2021-06-07) (c5323009)
### Bugfix - DISA STIG Ansible roles compatibility
* Added STIG_DEFAULT AIDE rule to the 'defaults.yml' variables file.
* Added AUDIT_TOOL AIDE rule to the 'defaults.yml' variables file.
* Added the variable 'aide_stig_compatibility' to toggle compatibility with the DISA STIG Ansible roles.

## Version 2.9-000009 (2021-05-04) (c5323009)
### Bugfix - Global Privilege Escalation Dependency
* Added become: true on each task

## Version 2.9-000008 (2021-04-05) (i868402)
### Bugfix - Cron Scheduling
* Fixed 'update every minute' cron schedule
* Reworked Cron Scheduling logic
* Using account Cron instead of Cron.d
* Rename tasks to fall inline with the existing STIG names

## Version 2.9-000007 (2021-03-09) (i513825)
### Bugfix - revert find-executable-path changes
* revert find-executable-path changes

## Version 2.9-000006 (2021-03-08) (i513825)
### Bugfix - dynamically find aide executable
* Fixes systems where default installation location for `aide` is not found on PATH
* In this case, will perform dynamic search for `aide` executable

## Version 2.9-000005 (2020-01-08) (i869415)
### Enhancement - Updating AIDE configuration file path
* Added task to dynamically determine the AIDE configuration file path based on the OS.

## Version 2.9-000004 (2020-01-06) (i535751)
### Enhancement - Role Refresh for Ubuntu 18
* Fixed issues where the role's custom AIDE configuration file was not being used by Ubuntu systems.
* Role is now compatible Ubuntu 18 and 16.
* Added task to setup a cron job for database updates.
* Added variables aide_cron_schedule_update,aide_update_cronjob_name,aide_update_cron_sched_hr,aide_update_cron_sched_wkd to allow customization of the cron job for database updates.

## Version 2.9-000003 (2020-11-23) (i869415)
### Enhancement - Added Splunk DSP and proc exclusions
* Added file path exclusions for Splunk DSP and /proc.
* AIDE should not scan the DSP Splunk or /proc directories.

## Version 2.9-000002 (c5304116)
### Allow both compressed and uncompressed db filename
* If compression is not available, aide drops the .gz from filename.

## Version 2.9-000001 (i826342)
### Correct package from installed to present
* Present works in both yum and apt, installed causes issues in apt.

## Version 2.8-000001 (2019-10-07) (c5295459)
### Initial forked version established with the following features
* Sourced from [ahuffman.aide](https://galaxy.ansible.com/ahuffman/aide) on ansible-galaxy; the original source code is available in [ahuffman's GitHub repository](https://github.com/ahuffman/ansible-aide).
* The main defaults were updated with several updates:
* Removed a commented out variable and updated the `aide_report_url` variable to use the correct .log file variable.
* Additionally, the `aide_rules` variable was updated with our default AIDE configuration to use the same paths and algorithms.
* The main task was updated to follow best practices.
* Updated crontab to cron.d with the `cron_file` parameter.
* Appended the `aide_cron_schedule_check` and `aide_update_db` variables with a `|bool` for best practice of a boolean variable.
* Added an ad-hoc check of the AIDE database to the tasks with the default variable `aide_check_db` set to `false`.
