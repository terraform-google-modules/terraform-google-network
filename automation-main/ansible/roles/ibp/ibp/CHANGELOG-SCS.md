# 2025-02-04 i571239
* Updated `amazon.aws.ec2` module references to `amazon.aws.ec2_instance` in `general/ebs-clone.yml`
* Removed deprecated `args warn` in `general/folder-tar.yml` and `general/fstab-clone.yml`

# 2025-02-03 i571239
* Added operations task for copying gzip files and extracting to directories
* Added operations task to initiate migration

# 2025-01-31 i868402
* Fixes a bug where Ansible runs in an elevated profile which doesn't have the proper (IAM) permissions.
* Adds a missing region input to the task.

# 2024-12-16 i868402
* New Changelog format
* Code to dynamically and correctly configure ActiveMQ
* Removed conditionals, and set to always start HANA DB after TAR Extraction
* Revert hostfile entries `cpids` back to `ns2cpids` as this is a deeper change.

## Version 2.16-000065 (2024-06-14) (i743694)
### Enhancement - added yum packages to Hana/CPIDS. updated paths for Kotyo, Java, Happic, Tomcat
* Added compat-sap-c++-11 and libabtomic
* Updated Java Home path
* Updated Kotyo path
* Updated Happic file path
* Updated Tomcat file path
* Removed Old validation method for CPIDS Test CPIDS URI http://127.0.0.1/DSoD/session/logon
* Changes are only valid for CPIDS version:   1.0.11.52-HF3

## Version 2.9-000064 (2023-10-17) (c5355631)
### Bugfix - relink symlink for release 2005
* Symlinks the compat-sap-c++-6.so and compat-sap-c++-9.so for release 2005 and newer

## Version 2.9-000063 (2023-09-18) (c5355631)
### Enhancement - Hostfile update for DoD
* Host file include entries for all incoming connections to Fiori/SDI/CPIDS to WDISP
* `all_incoming_connections_to_wdisp` set to `False` in role defaults

## Version 2.9-000062 (2023-02-14) (i535751)
### Bugfix - Host Agent Database
* Bugfix in deploying the correct host when provisioning database

## Version 2.9-000061 (2022-07-29) (i868402)
### Enhancement - Migrate Inventory
* Migrate Inventory files to variables repo.

## Version 2.9-000060 (2022-07-21) (i868402)
### Bugfix - Syntax
* Syntax Bugfix in CPIDS Provisioning

## Version 2.9-000059 (2022-07-20) (i555365)
### Enhancement - Customer0015 Inventory
* Added inventory file for Customer0015

## Version 2.9-000058 (2022-07-15) (i868402)
### Bugfix - Syntax
* Syntax Bugfix in Hana Provisioning

## Version 2.9-000057 (2022-07-15) (i868402)
### Enhancement - Updated inventory
* New Customer0014

## Version 2.9-000056 (2022-06-30) (c5335697)
### Enhancement - add yum packages to HANA/CPIDS
* Add compat-sap-c++-10 and libstdc++.so.6 which are required by DB > 16.0

## Version 2.9-000055 (2022-03-02)  (c5335697)
### Enhancement - Updated inventory
* New Customer0013

## Version 2.9-000054 (2022-04-18)  (i535751)
### Enhancement - Inventory File for ibp-dev-g golden0001 landscape
* Adding SID `N00` to golden staging env.

## Version 2.9-000053 (2022-05-06)  (i514383)
### Enhancement - Inventory File for ibp-dev-g golden0001 landscape
* Moving inventory file for golden0001 off the ibp development bastion into Gitlab

## Version 2.9-000052 (2022-04-04)  (i868402)
### Enhancement - Audit Customers
* Added Support0001
* Added Support0002

## Version 2.9-000051 (2022-03-02)  (i868402)
### Enhancement - Updated inventory
* Updated Customer0006 new landscape
* New Customer0012

## Version 2.9-000050 (2022-03-04)  (c5335697)
### Enhancement - Support0003 inventory
* add cpids tasks for migration
* updated ebs-clone

## Version 2.9-000049 (2022-02-18)  (i511522)
### Enhancement - Support0003 inventory
* Removed produciton app and db from support0003 inventory
* Added sapapp and hana tar source paths

## Version 2.9-000048 (2022-02-08) (i511522)
### Enhancement - Wait times
* Increasing wait times for Sapapp and CPIDS

## Version 2.9-000048 (2022-02-08) (i511522)
### Enhancement - Update cre-ibp-s03
* Update cre-ibp-s03 for new deployment

## Version 2.9-000047 (2022-02-01) (i868402)
### Bugfix - Resolve Provisioning errors
* Rewrote dbrebuild_2.sh as ansible
* Correctly placed permissions on critical files
* Forcibly uninstall and reinstall localsecurestore cleanly.

## Version 2.9-000046 (2022-01-18) (c5323009)
### Bugfix - Updated galaxy_info variables missing breaking molecule test runner
* Added role_name and namespace variables if missing broke molecule test runner

## Version 2.9-000045 (2021-11-01) (i511522)
### Enhancement - Updated customer inventory files
* Updated customer inventory files
  * cpids2 to cpids
  * removed customer0002 test instances

## Version 2.9-000044 (2021-07-13) (i868402)
### Enhancement - Adding inventories
* Add CRE Inventories

## Version 2.9-000043 (2021-06-14) (i868402)
### Enhancement - CPIDS Hana2.0
* Update required symlink for CPIDS/Hana2.0

## Version 2.9-000042 (2021-06-02) (i868402)
### Enhancement - Support ansible execution with hostnames/cnames
* Updates the hostfile template to explicitly use the ipaddress value.

## Version 2.9-000041 (2021-05-05) (c5323009)
### Bugfix - Updated ns2-scp-dev.sapns2.us domain to gitlab.core.sapns2.us
* Updated README.md for references using old gitlab domain to use new core services domain

## Version 2.9-000040 (2021-03-05) (i868402)
### Enhancement - Update Variables Create
* Update Cloudwatch dynamic variables

## Version 2.9-000039 (2021-02-17) (i868402)
### Enhancement - CPIDS Patch Support
* Changed CPIDS Provisioning for Java8 and Kotyo tomcat
* Changes startup and stop scripts to support Java8 and Kotyo tomcat
* Removed duplicate code in provisioning and linked to startup script.

## Version 2.9-000038 (2021-02-13) (i868402)
### Enhancement - Repoman update
* Support new Repository Management Role

## Version 2.9-000037 (2021-02-11) (i511522)
### Enhancement - invenory-create task created
* Added task file to dynamically create ibp ansible inventories from terraform output
* Added shell scripts to determine newest release of cpids, webdispatcher, and sap
* Added jinja template for ibp-ansible-inventory

## Version 2.9-000036 (2020-11-30) (i868402)
### Bugfix - Add User Expiry Report to CPIDS
* User Expiry report as requested by ops.

## Version 2.9-000035 (2020-11-07) (i868402)
### Bugfix - EBS Clone timeout hotfix
* Increased wait timeout for Instance Stop/Start from default of 5 minutes to 10 minutes.

## Version 2.9-000034 (2020-11-07) (i868402)
### Bugfix - EBS Clone Type hotfix
* Make new EBS Volumes GP2 which remove the 1TB EBS limit

## Version 2.9-000033 (2020-10-19) (i868402)
### Bugfix - fstab clone bug
* Fix fstab clone to be more resilient in its search

## Version 2.9-000032 (2020-10-19) (i868402)
### Enhancement - EBS Snapshot Migration Automation
* Task general/ebs-clone - Generic task to clone ebs volumes between two instances
* Task general/folder-tar - Generic task to tar and gzip a number of files
* Task general/fstab-clone - Generic task to clone the fstab contents between two instances
* Task provisioning/hana-rebuild-profile - Task to Rebuild using the Snapshot Method
* Task provisioning/sapapp-rebuild-profile - Task to Rebuild using the Snapshot Method
* Task provisioning/webdispatcher-rebuild-profile - Task to Rebuild using the Snapshot Method

## Version 2.9-000031 (2020-09-24) (i868402)
### Enhancement - Migration Tasks
* Task provisioning/hana-rebuild - Generic rebuild task for hana systems
* Task provisioning/hana-tar-rebuild - Specific rebuild task for hana systems from tar. Future iteratations should use the generic task
* Task provisioning/sapapp-rebuild - Generic rebuild task for sapapp systems
* Task provisioning/sapapp-tar-rebuild - Specific rebuild task for sapapp systems from tar. Future iteratations should use the generic task
* Task general/compat-bugfix - Hotfix/workaround for the SAP Compat libary issue.

## Version 2.9-000030 (2020-09-04) (i511522)
### Enhancement - Rhel 8 support
* symlink compat-sap-c++-9 to libstdc++.so.6

## Version 2.9-000029 (2020-08-25) (i868402)
### Enhancement - Variablize default domain in hostfile
* Variablize the dns fqdn in the hostfile
* set default dns fqdn to ibp.cre.sapns2.us

## Version 2.9-000028 (2020-07-30) (i861009)
### Feature - Added release tar sync task
* Added task to sync release tars from s3 staging buckets to the staging efs drive

## Version 2.9-000027 (2020-07-29) (i861009)
### Enhancement - Use Hostvars
* Use hostvars instead of reading in the inventory file

## Version 2.9-000026 (2020-07-27) (i868402)
### Bugfix - Syntax errors
* Fixed regex search for LJS Stopped
* Hide the ignore error output
* minor typo fixes

## Version 2.9-000025 (2020-07-22) (i861009)
### Enhancement - IBP Start/stop improvements
* Un-hardcoded LJS version
* Add cpids start/stop to ibp hard start/stop scripts

## Version 2.9-000024 (2020-07-06) (i868402)
### Enhancement - Subfolder refactor
* Refactored all tasks into subfolders
* Refactored all files into subfolders
* Refactored all templates into subfolders

## Version 2.9-000023 (2020-07-06) (i868402)
### Bugfix - remove symlink for release 2005
* Previous bugfix was not persistant
* Removing symlink in favor of replacing file /usr/lib64/libstdc++.so.6
### Bugfix - Adjust conditional for Hana Hardstart
* Changes conditional for hana hardstart to catch incorrect 'connection refused'

## Version 2.9-000022 (2020-06-18) (i868402)
### Bugfix - relink symlink for release 2005
* Relinks the compat-sap-c++-6.so symlink for release 2005 and newer

## Version 2.9-000021 (2020-06-18) (i868402)
### Enhancement - Combine ibp-provisioning and ibp-operations role
* Combined the two roles to `ibp`
* Change include_role to include_task.  Should not have an include_role inside a role

## Version 2.9-000020 (2020-06-18) (i868402)
### Bugfix - Missing region data
* Adds region to ec2_instance_info task in S3 discovery.

## Version 2.9-000019 (2020-06-18) (i511522)
### Enhancement - S3 bucket discovery logic simplified
* Removed looping of dictionary items to find VPC ID

## Version 2.9-000018 (2020-06-18) (i861009)
### Feature - webdispatcher hard start/stop
* Added hard start and hard start scripts for webdispatcher
* Updated the ibp-operations-hardstart/stop playbooks

## Version 2.9-000017 (2020-06-01) (i868402)
### Enhancement - dr automation
* fixed changed task file paths: tasks/disaster-recovery-prerequisites.yml
* fixed changed task file paths: tasks/disaster-recovery-setup.yml
* fixed changed task file paths: tasks/hana-ssfs-transfer.yml
* show results in cpids-backups: tasks/operations/cpids-backup.yml
* new task: tasks/provisioning/dr-cpids-provision.yml
* new task: tasks/provisioning/dr-hostfile-install.yml
* new task: tasks/provisioning/dr-sapapp-provision.yml
* removed newline: templates/operations/sql-cpids-backup.j2
* new template: templates/provisioning/ibp-hostfile-dr.j2

## Version 2.9-000016 (2020-06-15) (i861009)
### Feature - ibp application start stop
* Added hardstart/stop scripts for ibp-app (sapapp/hana)
* Added hardstart/stop playbooks
* Fixed hardstop not correctly identifying sidadm processes to kill (sappapp/hana)

## Version 2.9-000015 (2020-06-03) (i861009)
### Enhancement - webdispatcher start stop
* Added softstart softstop for Web Dispatcher
* Updated playbooks for softstart and softstop

## Version 2.9-000014 (2020-05-29) (i861009)
### Enhancement - CPIDS start stop
* Added softstart softstop for CPIDS
* Updated playbooks for softstart and softstop

## Version 2.9-000013 (2020-05-27) (i868402)
### Enhancement - ibp upgrade
* Updates defaults vault
* New sql: change-log-mode-overwrite.sql
* New vars: vars/upgrades/example-upgrade-scope.yml
* New task: tasks/general/xml-validation.yml
* New task: tasks/operations/hana-logging-off.yml
* update comment in tasks/operations/hana-softstop.yml
* New task: tasks/operations/hana-version/yml
* update with retry: tasks/provisioning/cpids-provision.yml
* New task: tasks/upgrades/hana-server-upgrade.yml
* New task: tasks/upgrades/sapapp-client-upgrade.yml
* New task: tasks/upgrades/sapapp-stackxml-update.yml
* New task: tasks/upgrades/saphostagent-upgrade.yml

## Version 2.9-000012 (2020-05-20) (i861009)
### Enhancement - app start stop
* Added softstart softstop for ibp app
* Added playbooks for softstart and softstop

## Version 2.9-000011 (2020-05-14) (i868402)
### Enhancement - CPIDS backups
* New default variables for cpids provisioning
* Additional default value added to ibp-defaults
* Added no_log to defaults-decrypt
* Added cpids webserver configuration (happic and tomcat)
* Changed the cpids validation to check the latest
* Created generic hdbuserstore key creation task

## Version 2.9-000010 (2020-05-11) (i868402)
### Enhancement - CPIDS backups
* Adds incron for CPIDS
* Adds hdb keys for CPIDS
* Adds backup task for CPIDS
* moves and reorganizes incron and backup files

## Version 2.9-000009 (2020-04-28) (i868402)
### Enhancement - setup dr improvements
* new file: sql-hana-set-jwt-parameter.j2
* added additional values to sql-hana-set-replication-parameters.j2
* decoupled playbook variables from role variables
* modified task files to support new changes

## Version 2.9-000008 (2020-04-17) (i868402)
### Enhancement - takeover & failback
* new task: disaster-recovery-failback
* new task: disaster-recovery-validate-sync

## Version 2.9-000007 (2020-04-09) (i868402)
### Enhancement - disaster recovery
* completed disaster recovery setup.
* documented task: defaults-decrypt
* documented task: incron-setup
* documented task: variables-create
* modified task: hdbuserstorekey-create
* modified task: s3-discovery
* new task: disaster-recovery-prerequisites
* new task: disaster-recovery-setup
* new task: hana-softstart
* new task: hana-softstop
* new task: hana-ssfs-transfer
* new task: sqlcmd-run
* new file: sql-hana-backup.j2
* new file: sql-hana-set-replication-parameters.j2
* new file: HANA_Configuration_PatchLevel.sql
* new file: HANA_Replication_SystemReplication_Overview.sql
* new file: change_log_mode_normal.sql
* new file: show_log_mode.sql
* updated README.md

## Version 2.9-000006 (2020-04-06) (c5295459)
### Bugfix - hana-provision
* Add `become` statement to user prompt task

## Version 2.9-000005 (2020-03-31) (i868402)
### Enhancement - incron & disaster recovery
* Add S3 discovery
* Adds incron setup to provisioning steps
* Adds ibp-defaults decryption task
* Adds hdbuserstore key setup task

## Version 2.9-000004 (2020-03-25) (i868402)
### Enhancement - Refactor
* Removed unneccesary vars/main
* Refactored ibp-hostfile.j2 to work with new hostvar template
* webdispatcher-provision works without global become:true now. other various tweaks
* hana-provision works without global become:true now. other various tweaks
* sapapp-provision works without global become:true now. other various tweaks
* cpids-provision works without global become:true now. other various tweaks
* Variables-create task will dynamically set vars based on host

## Version 2.9-000003 (2020-03-03) (i868402)
### Bugfix - webdispatcher provisioning
* Tar name has changed from wdisp to webdispatcher.

## Version 2.9-000002 (2020-01-13) (i868402)
### Enhancement - common staging EFS
* Default var ibp_staging_hana which can refer to either old or new efs path
* Default var ibp_staging_sap which can refer to either old or new efs path
* Added path variable to task files.
* Added additional path substitution where needed in task files.
* Made sure sapinst is executable

## Version 2.9-000001 (2019-12-12) (i868402)
### Initial version established with the following features
* Provisions IBP HANA DB
* Provisions IBP SAPAPP
* Provisions IBP CPIDS
* Provisions IBP Webdispatcher
