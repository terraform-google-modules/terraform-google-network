# Latest Version
2.9-000057

# Version History
## Version 2.9-000057 (2024-11-21) (i548337)
### Bugfix - Remove warm arg as this is deprecated in ansible 2.12+
* Remove warm arg as this is deprecated in ansible 2.12+

## Version 2.9-000056 (2024-11-07) (i516349)
### Bugfix - Updated Exemptions
* Updated exemptions to align with other hardening roles

## Version 2.9-000055 (2024-09-24) (i516349)
### Bugfix - Added tests and updated changelogs
* Added templated tests directory and playbook
* Updated changelog filename

## Version 2.9-000054 (2023-08-18) (i571239)
### Enhancement - Modify STIGs for Q2-2023 Quarterly Update
* Exempt `DISA-STIG-RHEL-08-020270` for automatically expiring temporary accounts within 72 hours
* Add `DISA-STIG-RHEL-08-010019` for ensuring Vendor GPG keys are utilized properly

## Version 2.9-000053 (2023-05-19) (i571239)
### Enhancement - Modify STIGs for Q1-2023 Quarterly Update
* Removed `DISA_STIG_RHEL_08_010510` task as it is no longer supported
* Added `DISA_STIG_RHEL_08_040342` task for enforcing FIPS related key-exchange for SSH

## Version 2.9-000052 (2023-04-06) (i570094)
### Bugfix - Ensure that SSH server connections use only expected SSH ciphers
* Update 'DISA_STIG_RHEL_08_010291' task to ensure that file '/etc/crypto-policies/back-ends/opensshserver.config' includes only ciphers expected in Tenable's RHEL8 DISA STIG audit file v1r8

## Version 2.9-000051 (2023-03-30) (i548472)
### Bugfix - Set `failed_when` to false
* Set `failed_when` to false for task `"[DISA_STIG_RHEL_08_010320] - Get the system commands are group-owned by root or a system account"`
* This task should never fail since the following task has an assert that defines a failure

## Version 2.9-000050 (2023-01-27) (i537609)
### Bugfix - Added `ansible-core` as a package exception
* Added `ansible-core` to list of exclusions when running `dnf update`

### Bugfix - Fixed typo in OpenSSHServer cipher
* Fixed typo where `@` was missing from a cipher

## Version 2.9-000049 (2022-12-30) (i570094)
### Bugfix - Ensure that SSH server connections use only DoD-approved encryption
* Update 'DISA_STIG_RHEL_08_010291' task to include only DoD approved cipher entries in SSH server config file ‘/etc/crypto-policies/back-ends/opensshserver.config’

## Version 2.9-000048 (2022-12-16) (i537609)
### Bugfix - Fixed conditional for fapolicyd tasks
* Updated conditionals for the `DISA_STIG_RHEL_08_040137` task to check which `ansible_distribution_version` to configure fapolicyd for.

## Version 2.9-000047 (2022-10-24) (i544961)
### Enhancement - Add Federal DoD banner variables file
* Update to allow banner text for Federal DoD inclusion within the Federal SMS

## Version 2.9-000046 (2022-08-26) (i870123)
### Bugfix - Prevent SSH sessions from disconnecting even when in use
* Due to bug in Rekey session logic that exists in RHEL8, ensure there is a client keepalive count

### Bugfix - Ensure new users get a home directory upon initial login
* DISA-STIG configuration now has a "with-mkhomedir" setting to grant new users a home directory

## Version 2.9-000045 (2022-08-12) (i537609)
### Bugfix - Fixed task that configures GnuTLS encryption
* Updated `DISA_STIG_RHEL_08_010295` task to use upstream content for configuring GnuTLS encryption

## Version 2.9-000044 (2022-07-15) (i537609)
### Enhancement - Added new fapolicyd task for RHEL 8.6
* Added new fapolicyd task for RHEL 8.6 as it is using a newer version of fapolicyd
* Added conditional to new and old tasks to ensure the proper task is ran for each minor OS version

## Version 2.9-000043 (2022-06-15) (c5337390)
### Enhancement - ClientAlive settings for bastion role
* Specifically setting the ClientAliveInterval and ClientAliveCountMax
* Also specifically setting that RHEL_08_010161 is false as the Bastion STIG hardening takes place after the machine is domain joined.

### Bugfix - Kerberos Keytabs
* Removed the default of applying RHEL_08_010161 as this breaks any domain joined machine.

## Version 2.9-000042 (2022-05-24) (c5323009)
### Bugfix - Added task: Configure the RHEL 8 GnuTLS library to use only DoD-approved encryption
* Fixed GnuTLS library is configured to only allow DoD-approved SSL/TLS Versions

## Version 2.9-000041 (2022-03-18) (c5332214)
### Bugfix - Added notify: restart auditd to relevant tasks that were missing it
* Fixed an issue where some auditd tasks were not being properly restarted upon configuration changes.

## Version 2.9-000040 (2022-02-02) (i537609)
### Bugfix - Removed password lifetime STIG from certain variable files
* Removed STIG DISA_STIG_RHEL_08_020200 from several variable files as it is a documented exemption.

## Version 2.9-000039 (2022-01-13) (i869415)
### Bugfix - Turning noexec mount option STIG into exemption
* Moved STIG RHEL-08-040125 to the exemptions due to it preventing applications from running such as AWS CLI and SAPAPP/HANA.

## Version 2.9-000038 (2021-12-21) (i869415)
### Bugfix - Updated SAPAPP and HANA variables
* Updated the 'sap.yml' and 'hana.yml' variable files to not enable firewalld.
* Updated the 'sap.yml' and 'hana.yml' variable files to not enable noexec and nosuid mount options on /tmp.
* Updated the 'sap.yml' variable file to allow the running of initialization files from /tmp.

## Version 2.9-000037 (2021-12-8) (i537609)
### Enhancement - Added new NS2 STIG for configuring ssh_deletekeys setting
* Added NS2 STIG 'NS2_STIG_RHEL_08_001050'
* Created new task to set ssh_deletekeys setting to prevent duplicate host keys in hardened images.

## Version 2.9-000036 (2021-11-15) (i869415)
### Bugfix - Fix Firewalld and authselect issues
* Fixed an issue with Firewalld where the required services and protocols were not added.
* Fixed an issue where authselect would enable the custom profile even if no related STIGs were set to true.
* Fixed an issue in tasks that modify mount options.
* Fixed issues related to mount options.
* Commented out a STIG that can't be ran on our images so that the 'all' preset functions again.
* Fixed STIGs related to user password expiration so that it works with Ansible version 2.9.

## Version 2.9-000035 (2021-11-09) (i869415)
### Enhancement - Complete refactor
* Reviewed and re-wrote the tasks for every RHEL 8 DISA STIG in version 1, release 3.
* Ensured that all tasks have a prefix identifying the STIG that the task is for.
* Ensured that every task is idempotent.
* Documented new exemptions.

## Version 2.9-000034 (2021-08-20) (i869415)
### Bugfix - Added missing STIGs to 'primary.yml'
* Added missing STIG variables to the 'primary.yml' variables file associated with the 'ClientAliveCountMax' and 'ClientAliveInterval' SSHD settings

## Version 2.9-000033 (2021-06-28) (i869415)
### Bugfix - Fixing auditd log file rotation
* Updated the auditd configuration file to properly rotate the auditd log file when necessary.
* Added an exemption for the auditd log file rotation STIG 'RHEL-08-030050'.

### Bugfix - Fixed STIGs involving /etc/fstab
* Fixed issues with STIGs searching /etc/fstab and failing due to missing filesystems.

### Enhancement - Added all-stigs.yml file
* Added the 'all-stigs.yml' variables file and the 'all' variables mapping to the role.

### Enhancement - Changed AIDE cron job to use crontab
* Updated the task that sets the AIDE cron job to use the crontab instead of a cron file.

### Enhancement - Ensuring random passwords are set
* Uncommented a task and added an NS2 STIG variable for setting random passwords on local user accounts.

## Version 2.9-000032 (2021-07-26) (i869415)
### Enhancement - Added bastion presets
* Added the bastion related application presets and 'bastion.yml' vars file to be consistent with the RHEL 7 DISA STIG role.

### Enhancement - Added new custom NS2 STIG for LoginGraceTime
* Added NS2 STIG for 'LoginGraceTime' SSHD setting.
* Added Molecule test for this SSHD setting.

### Enhancement - Fixed X11Forwarding STIG
* Fixed the X11Forwarding STIG to have it properly disabled.

## Version 2.9-000031 (2021-07-21) (i516349)
### Documentation - Updated Exemptions
* Updated `EXEMPTIONS.md` to provide justification for 'RHEL-08-030050' with change in automation

## Version 2.9-000030 (2021-06-25) (i516349)
### Bugfix - Adding missing variables file
* Added `all-stigs` variables file to provide capability to apply all hardening to target system regardless of availability

## Version 2.9-000029 (2021-06-07) (c5323009)
### Bugfix - AIDE Ansible role compatibility
* Added and modified tasks to ensure AIDE Ansible role compatibility.
* Added tasks to configure the 'STIG_DEFAULT' and 'NORMAL' AIDE rules.
* Renamed the AIDE cron job variable to be 'aide_cronjob_name' so that it is consistent with the AIDE Ansible role.
* Added a task to configure AIDE rules to ensure that the audit related files are covered.

## Version 2.9-000028 (2021-06-03) (i869415)
### Enhancement - Updated login banner STIG
* Updated the login banner STIG task to use a generic variable for the banner content.
* Added a 'businesses/' directory and 'sms-aus.yml' variables file for SMS AUS specific variable customizations.

## Version 2.9-000027 (2021-06-02) (i869415)
### Bugfix - Added missing STIG variable
* Added a missing STIG variable for 'DISA-STIG-RHEL-08-040172'.
* Updated the 'main.yml' and 'primary.yml' variable files with the new STIG variable.

## Version 2.9-000026 (2021-04-12) (i869415)
### Enhancement - Updated the kdump STIG
* Updated the kdump STIG 'DISA_STIG_RHEL_08_010670' to disable kdump instead of enabling it.
* The STIG has updated to say that kdump should only be enabled if absolutely necessary.
* Updated the variable files containing the kdump STIG variable.

## Version 2.9-000025 (2021-04-06) (i868402)
### Enhancement - Update Cron job name
* Rename AIDE Cron job to match name everywhere else

## Version 2.9-000024 (2021-03-17) (i516349)
### Documentation - Updated README
* Included metadata table for STIG development and tracking in `README.md`
* Updated metadata from `failing_nessus` to `tenable-fail`

## Version 2.9-000023 (2021-03-05) (i869415)
### Bugfix - Disabled firewalld STIG for Docker and Kubernetes
* Disabled two firewalld related STIGs for Docker and Kubernetes presets due to their system requirements.

### Bugfix - Fixed a shell command for finding shosts files
* Changed the failure condition of a task that searches for shosts files.

## Version 2.9-000022 (2021-03-05) (i869415)
### Bugfix - Disabled firewalld STIG for SAPAPP and HANA
* Disabled an additional STIG for SAPAPP and HANA presets due to them requiring that firewalld be disabled.

## Version 2.9-000021 (2021-03-04) (i869415)
### Enhancement - Removed tasks that were tagged with 'never'
* Removed all tasks that were tagged 'never' since they would not run anyways.
* Tasks tagged with 'never' could potentially run and cause problems with other tag executions that use the 'always' tag.
* Removed the 'never' tag from a task that was not supposed to have it.

## Version 2.9-000020 (2021-03-02) (i535751)
### Bugfix - AIDE configuration bug
* Task: "Ensure aduit tools are protected by AIDE" spelling error; "xattr" was replaced with "xattrs"
* Tasks: "Ensure xattrs rule is applied on all files and directory selections" loop fix
* Tasks: "Ensure acl rule is applied on all files and directory selections" loop fix
* Replaced instances of notifies with notify
* Added a default true to ec2_user_minimum_password_lifetime_check

# Version History
## Version 2.9-000019 (2021-01-27) (i869415)
### Enhancement - New and updated STIGs
* Added command to the firewalld handler to ensure the firewalld.service is started.
* Added missing STIG variables and tasks that are new in the Version 1, Release 1 STIG benchmark.
* Updated auditd tasks to configure the 32 bit rules in addition to the usual 64 bit rules.
* Fixed various other STIGs used in the Golden Oracle Linux 8.3 image.

## Version 2.9-000018 (2021-01-22) (i869415)
### Enhancement - Adding and updating STIGs
* Updated existing STIGs to be more accurate and consistent to ensure better coverage.
* Added missing STIGs and tasks to ensure more coverage.

## Version 2.9-000017 (2021-01-19) (i516349)
### Documentation - Updated Exemptions
* Updated `EXEMPTIONS.md` to provide justification for unapplied STIGS
* Reordered exemptions based off STIG ID
* Updated Rule ID for easier mapping to security tooling
* Updated inaccurate changelog

## Version 2.9-000016 (2021-01-07) (i537609)
### Documentation - Updated Exemptions
* Updated `EXEMPTIONS.md` to provide justification for unapplied STIGs

## Version 2.9-000015 (2020-12-23) (i516349)
### Bugfix - Disabling clamav configuration
* Removing clamav from primary stig list as proper defaults
* Clamav role should be used until daemon capability has been codified

## Version 2.9-000014 (2020-12-21) (i537609)
### Bugfix - Hold Ansible package from being updated
* Fixed issue where Ansible updates itself during hardening causing an error

## Version 2.9-000013 (2020-12-15) (i869415)
### Enhancement - Added 'tertiary.yml' variables file and updated some tasks
* Added a 'tertiary.yml' variables file that has roughly the maximum amount of STIGs set to true that still allow for a functioning system.
* This 'tertiary.yml' variables file is used in conjunction with the 'redhat8-openscap-remediation.yml' Ansible playbook to achieve roughly 85% OpenSCAP coverage.
* Refreshed and cleaned up some tasks.
* Added support for Oracle Linux 8.

### Bugfix - Fixed the inclusion of variables files and auditd
* Fixed the inclusion of variables files to allow for specific STIGs to be enabled.
* Fixed an incorrect DISA STIG configuration that would break the auditd service due to incorrect file permissions.
* Fixed the inclusion of the 'base.yml' variables file to be consistent with the usage of other 'variables' files.
* The 'main.yml' variables file will be used when no 'application_preset_selection' is provided, which enables zero DISA STIGs.
* This allows for specific DISA STIGs to be turned on via their corresponding variables.

## Version 2.9-000012 (2020-12-03) (i869415)
### Enhancement - Added 'base.yml' variables file
* Added a copy of the 'primary.yml' variables file to the role named 'base.yml' to aid in the selection of STIGs.

## Version 2.9-000011 (2020-09-16) (i839460)
### Enhancement - Modified several stig values
* Added banner (though they are in exemptions file, it's notificatino of a nessus issue and can be enabled
* Disabled ssh and command line auto-logout
* disabled firewalld on sap and hana variants

## Version 2.9-000010 (2020-09-14) (i511522)
### Bugfix - kdump stig vars added for sap and hana
* Added kdump stig vars to sap and hana vars to align with requested settings

## Version 2.9-000009 (2020-09-10) (i839460)
### Enhancement - Added exemption
* Added /var/log permissions to global exemptions list for freshclam
* Added world writable file to hana variant exemption list

## Version 2.9-000008 (2020-08-28) (i839460)
### Bugfix - Corrected typo for Base variant
* Corrected typo for base variant in main.yml

## Version 2.9-000007 (2020-08-28) (i537609)
### Enhancement - Variant Stig IDs
* Updated required specific stig IDs in variant customization files

## Version 2.9-000006 (2020-08-27) (i537609)
### Enhancement - Added additional products to lookup table
* Added several products to the main variable file so main task file can properly include variable filesa
* Customized several products to selectively disable fips

## Version 2.9-000005 (2020-08-25) (i839460)
### Enhancement - Disabled two stig IDs
* DISA_STIG_RHEL_08_010200: false # SSH timeout after 10 minutes
* DISA_STIG_RHEL_08_030050: false # Audit log full setting to notify (it should be rotate)

## Version 2.9-000004 (2020-08-18) (i839460)
### Bugfix - changed customize_business to application_preset_selection as stigs are product customized
* Mapped stig customizations to product instead of business
* Changed ns2 back to base to match default business
* Added summary lines to each STIG-ID in the configuration files

## Version 2.9-000003 (2020-08-14) (i839460)
### Bugfix - Changed business to 'ns2' from 'base' as a default, as base is the product and ns2 is the business
* Changed business to 'ns2' from 'base' as a default, as base is the product and ns2 is the business

## Version 2.9-000002 (2020-08-13) (i839460)
### Enhancement - Added many tasks to become compliant with the RHEL8 Draft STIG
* Added many tasks to become compliant with the RHEL8 Draft STIG
* Added support for line of business customizations
* Added support for the 'none' business which allows application of individual stigs

## Version 2.9-000001 (2020-05-06) (i839460)
### Initial forked version established with the following features
* Forked stig role from RedHatOfficial/ansible-role-rhel8-stig
* Added many tasks (tagged with SAPNS2) to become compliant with the ssg-rhel8-ds-1.2 baseline
* Added ClamAV, package_clamav_configured option enabled by default
* Disabled fapolicyd by default
* Added in legacy /etc/default/grub edits for security scanner
