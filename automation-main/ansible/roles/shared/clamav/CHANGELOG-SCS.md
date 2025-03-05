# Latest Version
2.16-000033

# Version History
## Version 2.16-000033 (2024-07-29) (i511522)
### Bugfix - Add logic for BOSH Stemcell support
* Added task to check if user `vcap` exists
* Add conditional to freshclam command to run `--user=root` when host is BOSH Stemcell

## Version 2.16-000032 (2024-07-25) (i511522)
### Bugfix - Fix RHEL 8.1 > 8.5 install logic
* Update RHEL 8.1 > 8.5 install logic as it is currently not functional

### Bugfix - Change freshcam logic to "or" instead of "and"
* Update freschlam logic to or so that the database is created if var is set or doesnt exist

### Bugfix - Introduce shared object to enable ClamAV in FIPS mode
* Create a shared object that is preloaded before invocations of clamav and freshclam
* Once upstream pull request is accepted this will be removed

## Version 2.16-000031 (2024-07-15) (i548447)
### Bugfix - Add freshclam.conf template
* Add existing freshclam.conf template back to configuration tasks
* Move freshclam initialization to configure file

## Version 2.16-000030 (2024-07-02) (i577821)
### Bugfix - Updated operators for clamav install
* Operators updated for clamav install for 8.1 to 8.5 RHEL VMs so the condition succeeds.

## Version 2.16-000029 (2024-06-26) (i746373)
### Bugfix - Set user to root for freshclam db initalize
* Set user to root for freshclam db initalize.

### Bugfix - Update freshclam to initialize when main.cvd does not exist
* Move freshclam initialize and check if freshclam is initialized

## Version 2.16-000027 (2024-06-11) (i548447)
### Bugfix - Do not run adhoc scan if clamav_targeted_scan_script set to true
* Remove condition clamav_targeted_scan_script check on adhoc clam scan task

## Version 2.16-000026 (2024-05-23) (i516349)
### Bugfix - Adjusted default behavior for clamd
* Updates clamd to default to disabled rather than enabled

### Enhancement - Light Refactor
* Splits apart tasks for easier management
* Adds capability to remove clamd service and files
* Updates metadata and README with authors

### Feature - Remove ClamAV Daemon
* Adds task for removing clamd and associated files

## Version 2.16-000025 (2024-05-10) (i743694)
### Enhancement - Added enhancements to facilitate implementation of clamsap
* Added clamd task to start and enable the service

## Version 2.16-000024 (2024-05-02) (i743694)
### Enhancement - Added enhancements to facilitate implementation of clamsap
* Added additional tasks have been added to the clamav setup that installs and configures clamd. Clamd added to list of packages/dependencies to install
* j2 template file was created to push setting parameters for clamd within scan.conf
* clamd task to start and enable the service as well as reload daemon has been added.
* task that changes the name of clamd service from clamd@.service to clamd.service

## Version 2.9-000023 (2023-06-28) (i548447)
### Bugfix - Enable epel yum repository
* As epel may not be enabled for all application presets we need to specify to enable during clamav install
* Add check to ensure clamAV is installed as dnf shell command return code does not ensure task installs clamav package
* Change cron hour from 0 to 2 to help reduce high CPU alerts when clamav is running while other security agents are running

## Version 2.9-000022 (2023-05-18) (i587430)
### Feature - Enable HTTP Proxy support for updates
* Added settings `clamav_freshclam_http_proxy_address` and `clamav_freshclam_http_proxy_port` for configuring HTTP Proxy for freshclam updates

## Version 2.9-000021 (2021-09-29) (i537609)
### Bugfix - Added task to install ClamAV on incompatible versions of RHEL
* Added task to install ClamAV using the `--nobest` flag for versions of RHEL that don't have access to the `libjson-c.so.4` package
* Also added conditionals to installation tasks to differentiate between compatible and incompatible RHEL versions

## Version 2.9-000020 (2022-01-18) (c5323009)
### Bugfix - Updated galaxy_info variables missing breaking molecule test runner
* Added role_name and namespace variables if missing broke molecule test runner

## Version 2.9-000019 (2021-09-14) (c5323009)
### Enhancement - Leave clamav scan results on the filesystem
* Added task to create directory /etc/ns2-scan-results if flag is set to true
* Added task to copy clamav.log into ns2-scan-results directory if flag is set to true

## Version 2.9-000018 (2021-05-05) (c5323009)
### Bugfix - Updated ns2-scp-dev.sapns2.us domain to gitlab.core.sapns2.us
* Updated issue_tracker_url variable using old gitlab domain to new core services domain

## Version 2.9-000017 (2021-04-16) (i513825)
### Bugfix - Update variable name
* `clamav_cron_week` -> `clamav_cron_weekday`
* This variable represents which day of the week (e.g. Mon, Tues, Wed) that the scan runs, not which week of the month
* This means that the default clamav behavior everywhere has been to run scans every day at midnight, not once per week as the documentation somewhat indicates

### Enhancement - Added optional targeted clamscan script
* Added optional flag (defaults to `false` as to not affect any existing systems) to drop a generic clamav scan script on host systems
* This generic targeted scan script can be used on-demand to conduct clamav scans against target files/directories
* To be used by specific systems, such as a SFTP file transfer mechanism that will automatically want to conduct clamav scans against individual files that get submitted for file-transfer

### Enhancement - Added optional database management flags
* Added flag to allow role to initialize ClamAV database on-demand as a part of role configuration steps
* Added flag to allow for the regular scheduling of ClamAV database updates independent of performing any scans

### Bugfix - Removal script cron job name
* Ensure the `clamav` removing taskfile attempts to remove the cronjob with the proper name

## Version 2.9-000016 (2021-04-07) (i869415)
### Enhancement - Added 'lock_timeout' parameter when installing ClamAV
* Added the 'lock_timeout' parameter when installing ClamAV via Yum so that it will wait longer for Yum to become available before failing.
* This allows for the role to be used in parallel with more things since it will wait for Yum to become available.

## Version 2.9-000015 (2021-03-08) (i826342)
### Bugfix - Script points at /usr/bin/date which breaks on systems where date is in /bin
* Update to prevent failure when date is not in /usr/bin

## Version 2.9-000014 (2021-03-03) (i869415)
### Bugfix - Fixed issue when no cron entries are specified
* Fixed a task that looks for cron entries of ClamAV so that it will not fail if no cron entries are found.

## Version 2.9-000013 (2021-02-03) (i511522)
### Enhancement - Remove legacy cron entries
* Added task to remove legacy cron entries during clamav configuration

## Version 2.9-000012 (2021-01-22) (i513825)
### Bug - Ignore scanning data directory for HashiCorp Consul
* Ingnore scanning directory `/opt/consul` for systems running HashiCorp Consul

## Version 2.9-000011 (2020-12-23) (i516349)
### Enhancement - Adjusting cron name
* Aligning to DISA STIG role for cronjob name
* Removing outdated DISA STIG vulnerability identifiers

## Version 2.9-000010 (2020-11-23) (i869415)
### Enhancement - Added Splunk DSP and proc exclusions
* Added file path exclusions for Splunk DSP and /proc.
* ClamAV was crashing when trying to scan the now excluded Splunk DSP directories.

## Version 2.9-000009 (2020-10-28) (i535751)
### Enhancement - Added support for Ubuntu
* Added conditional to be able to run on Ubuntu using packages clamav
* Stop and disable freshclam service on start when running on Ubuntu (sets up service automatically)
* Updated syntax for package commands to run faster

## Version 2.9-000008 (2020-09-04) (i861009)
### Enhancement - Removed relative paths
* Removed relative path for include_role task

## Version 2.9-000007 (2020-08-03) (i535751)
### Enhancement - Compatible with RHEL 8 confirmed
* Verifying compatability with REHL 8.0, 8.1, 8.2
* Removed yum's enable repo epel and rhel-7-server-rpms

## Version 2.9-000006 (2020-07-29) (i535751)
### Deprecation
* Removed epel management in the role, now is fully handled in the playbook

## Version 2.9-000005 (2020-07-20) (i535751)
### Deprecation
* Deprecation of epel dependence in meta file, now managing epel repo through repository-management
* Documentation now shows epel management example through repository-management instead of epel role

## Version 2.9-000004 (2020-07-01) (i869415)
### Enhancement - Added support for SLES
* Added conditional to be able to run on SUSE Enterprise Linux.

## Version 2.9-000003 (2020-04-17) (i826342)
### Bugfix - clamav-update is not a package on ubuntu
* Remove incorrect package.
* Script should pull updated defs.

## Version 2.9-000002 (2019-11-26) (i869415)
### Bugfix - Specified which repos to install clamav from
* Specified which repos to enable when installing clamav and its dependencies.

### Enhancement - Added ability to remove ClamAV
* Added ability to remove ClamAV from the system.

## Version 2.9-000001 (2019-11-13) (i869415)
### Initial version established with the following features
* Installs ClamAV.
* Sets up or removes a cron job for it.
* Runs a ClamAV scan.
