# Latest Version
2.9-000061


# Version History
## Version 2.9-000061 (2025-02-04) (i746373)
### Bugfix - SLES 15 support
* add chost product file

## Version 2.9-000060 (2025-01-09) (i537609)
### Bugfix - Fixed an issue with a non-existent directory for SLES 15
* Added task to create temporary directory for cloudwatch agent RPM before downloading RPM

## Version 2.9-000059 (2024-11-13) (c5360422)
### Enhancement - Added custom metrics enable/disable flag to enable/disable metrics gathering through CloudWatch
* Added custom metrics enable/disable flag to enable/disable metrics gathering through CloudWatch

## Version 2.9-000058 (2024-11-05) (i561481)
### Enhancement - Add efs-utils log support to bastion
* Add log groups for efs-utils to bastion and bastion_redhat products

## Version 2.9-000057 (2024-08-12) (c5361285)
### Enhancement - Add tenable-sc and trend deep security manager logging. Remove tenable-sc references from nessus
* added /vars/product/deepsecmng.yml for trend deep security manager
* added /vars/product/tenable-sc.yml for tenable security center
* Removed Tenable security center references from nessus.yml

## Version 2.9-000056 (2024-07-19) (i558332)
### Bugfix - Fix consul logging
* Update consul logging to catch legacy logs as well as new logs e.g. consul/consul.log

## Version 2.9-000055 (2024-06-04) (i561481)
### Enhancement - Add efs-utils log support
* Add log group for efs-utils logs to file-transfer vars

## Version 2.9-000054 (2024-06-01) (i746373)
### Enhancement - Add aws-cloudwatch-agent/vars/product/btp_cloudfoundry.yml
* Add aws-cloudwatch-agent/vars/product/btp_cloudfoundry.yml to support Stemcells

## Version 2.9-000053 (2024-03-03) (i552364)
### Enhancement - Add /var/log/clamdscan.log to cloudwatch agent
* Add /var/log/clamdscan.log to cloudwatch agent

## Version 2.9-000052 (2024-02-29) (i537609)
### Enhancement - Add RHEL 9 Support
* Modify main.yml to support RHEL 9

## Version 2.9-000051 (2024-01-08) (i561481)
### Bugfix - Fix gitlab_docker filename
* Fix gitlab_docker filename and Variable

## Version 2.9-000050 (2024-01-05) (i571239)
### Enhancement - Add SLES 15 Support
* Add Suse task for installing cloudwatch agent
* Add variable for cloudwatch agent rpm package and signature
* Modify main.yml to support SLES 15

## Version 2.9-000049 (2023-12-26) (i561481)
### Enhancement - new variables file
* Add variable files for docker gitlab deployments

## Version 2.9-000048 (2023-08-24) (i571239)
### Enhancement - new variables file
* Add variable files for SAP Router

## Version 2.9-000047 (2023-03-31) (i558332)
### Enhancement - add freeradius log support
* Add log group for freeradius logs

## Version 2.9-000046 (2022-11-17) (i552364)
### Enhancement - new variables file
* Added variable files for SAP cloud connector

## Version 2.9-000045 (2022-11-08) (i548472)
### Enhancement - Adding SMS inventory
* Added inventory directory to pass different variables depending on host for the SMS

## Version 2.9-000044 (2022-10-17) (c5279079)
### Enhancement - new variables files
* Added variable files for bizx, bizx_app, icontent, lms, lms_app, pi
* Removed "list_<app-name>" lists of log groups from all app yml files

## Version 2.9-000043 (2022-05-06) (i869415)
### Enhancement - New Gardener Shoot variables file
* Added variable file for new 'gardener-shoot' application preset selection.

## Version 2.9-000042 (2022-03-22) (c5309336)
### Enhancement - SAP Router Logs
* Add sap router logs to CloudWatch agent config for sapapp

## Version 2.9-000041 (2022-01-18) (c5323009)
### Bugfix - Updated galaxy_info variables missing breaking molecule test runner
* Added role_name and namespace variables if missing broke molecule test runner

## Version 2.9-000040 (2021-11-10) (c5309377)
### Enhancement - Explicitly enable the CWA in systemd
* Somewhere along the line the defaults changed in the cloudwatch package and it was no longer enabled by default

## Version 2.9-000039 (2021-04-29) (i513825)
### Enhancement - ship File-Transfer logs
* Added log group to ship SFTP File Transfer system logs to CloudWatch

## Version 2.9-000038 (2021-03-17) (i868402)
### Enhancement - S4PCE
* Update log paths for Lumira
* Update log paths for BOBJ
* Update log paths for App Java

## Version 2.9-000037 (2021-03-05) (i513825)
### Bugfix - RPM download permissions
* Download RPM files as root to avoid potential `/tmp` priviledge restrictions

## Version 2.9-000036 (2021-03-05) (i868402)
### Enhancement - S4PCE
* Sets default environment values if not defined.
* adds additional logging variables for S4PCE Products

## Version 2.9-000035 (2021-03-04) (i869415)
### Bugfix - Fixed issue with proxy use
* Fixed an issue where if a proxy is not used, a few variables would be undefined when running a collectd handler.

## Version 2.9-000034 (2021-02-19) (i513825)
### Enhancement - Systemd proxy configurations
* Apply proxy configuration environment variables via systemd unit file

## Version 2.9-000033 (2021-01-04) (i516349)
### Documentation - Added notes about GitLab RPM vs container installs
* Added comment notes explaining which preset should be used for RPM-based installs and containerized deployments of GitLab.

## Version 2.9-000032 (2021-01-04) (i516349)
### Bugfix - Reverting MD5 workaround
* Converted shell module to yum to accommodate for newly added SHA256 support on RPM for agent installation

## Version 2.9-000031 (2020-12-17) (c5309336)
### Enhancement - CloudWatch Timestamps
* Add timestamp formatting to CloudWatch configs

## Version 2.9-000030 (2020-12-02) (c5309377)
### Bugfix - Add systemd always restart policy
* Forces systemd to always attempt to restart CloudWatch if it ever stops running

### Bugfix - Bypassing MD5 checksums
* Converted yum module to shell to accomodate for lack of SHA256 support on RPM for agent installation

## Version 2.9-000030 (2020-11-24) (i869415)
### Enhancement - Added kubernetes product vars file
* Added a product vars file for kubernetes.

## Version 2.9-000029 (2020-11-21) (c5309377)
### Bugfix - Cleanup legacy
* Remove the region value unless it is set by the caller in the cloudwatch configuration
* Cleanup the old cloudwatch configuration file if it exists so we don't have two competing configuration files

### Feature - Add Postfix
* Adds postfix as a new preset selection

## Version 2.9-000028 (2020-11-10) (i869415)
### BugFix - Removed containerized GitLab log groups
* Removed containerized GitLab log groups since the Docker log driver is now collecting these logs automatically.

## Version 2.9-000027 (2020-11-06) (c5295459)
### BugFix - Remove hardcoding of AWS CloudWatch version
* Removed hardcoding of AWS S3 bucket location back to latest

### Documentation - Added note regarding FIPS issues
* Added a note with date and AWS support case regarding installation on FIPS-enabled instances

## Version 2.9-000026 (2020-10-19) (c5295459)
### BugFix - Temporary hardcode of Agent version
* Updated RPM and SIG locations within AWS S3 bucket to version 1.246396.0

### Enhancement - Update Agent JSON configuration
* Updated `amazon-cloudwatch-agent.json` to be located within `cwa_temp_path` variable path

## Version 2.9-000025 (2020-10-09) (i513825)
### Enhancement - added `cwa_enable_repositories` flag
* Added default variable to be able to toggle on/off the behavior to enable repositories using the `repository-management` role within the `aws-cloudwatch-agent` role
* Use case is for Amazon Linux machine where `ansible_os_family` is still `redhat` but current implementation of `repository-management` does not support Amazon Linux

## Version 2.9-000024 (2020-09-24) (i868402)
### Bugfix - Fix collectd variable bug
* Fix infinite loop caused when calling collectd role and the calling playbook has already
  defined different values for both cw_preset_selection and application_preset_selection

## Version 2.9-000023 (2020-09-11) (i511522)
### Bugfix - Added bastion product vars file
* Added bastion product vars file for bastion provisioning

## Version 2.9-000022 (2020-09-09) (i839460)
### Bugfix - removed rhel_repo
* Removed rhel_repo from repository-managemnent role call to prevent overwriting of existing repositories

## Version 2.9-000021 (2020-09-09) (i861009)
### Enhancement - Removed relative paths
* Removed relative path for include_role task

## Version 2.9-000020 (2020-09-04) (i511522)
### Bugfix - file_path spelling mistake
* Changed file-path to file_path in /vars/product/default.yml

## Version 2.9-000019 (2020-08-31) (i511522)
### Enhancement - Added additional log groups for application variants
* Added default log group for application variant docker
* created symlink sapapp -> sap for that application variant to work properly

## Version 2.9-000019 (2020-09-01) (i511522)
### Bugfix - Native collectd metrics
* Removed use of awslabs collectd plugin and configure for native integration

## Version 2.9-000019 (2020-08-31) (i861009)
### Feature - docker support
* Added docker product type

## Version 2.9-000019 (2020-09-02) (i857914)
### Enhancement - Added Nessus Agent log paths
* Added Nessus Agent log paths to the 'default.yml' file

## Version 2.9-000018 (2020-08-26) (i869415)
### Bugfix - Fixed invalid json
* Fixed invalid json format in the 'amazon-cloudwatch-agent.json.j2' file.

## Version 2.9-000017 (2020-08-24) (i857914)
### Enhancement - Expanding log groups for tenable
* Adds tenable.sc log groups as recommended by the vendor
* Breaks out tenable nessus log groups as recommended by the vendor

## Version 2.9-000016 (2020-08-19) (i516349)
### Bugfix - Removed unnecessary dimensions
* Removing unneeded dimensions e.g., imageid and instancetype as they are causing issues globally
* Reduced dimensions to just instanceid and moved them into each metric
* Paramterized asg dimension with jinja

### Enhancement - Normalized variable names
* Renamed `default_log_stream_name` to `cwa_default_log_stream_name`
* Renamed `log_stream_timezone` to `cwa_default_log_stream_timezone`

### Enhancement - Reduced timezone variables (c5309377)
* Added timezone via jinja for loop rather
* Removed timezone line in vars to keep lists

### BugFix - Fix dependency on CPIDS and WebDispatcher
* Update variables file for CPIDS and WebDispatcher application presets

## Version 2.9-000015 (2020-08-03) (i869415)
### Enhancement - Added log groups for containerized GitLab
* Adding log groups for containerized GitLab.

## Version 2.9-000014 (2020-08-10) (i839460)
### Enhancement - Standardized lines of business
* Properly added support for base application preset
* Renamed 'application' to 'product' directory to better standardize on naming (ProductName tag)

## Version 2.9-000013 (2020-08-03) (i514383)
### Enhancement - Adding request ubuntu loggroups
* Adding four requested ubuntu loggroups to the default list of loggroups:
*   /var/log/cron.log
*   /var/log/auth.log*
*   /var/log/kern.log
*   /var/log/mail.log

## Version 2.9-000012 (2020-07-25) (c5309377)
### Bugfix - Fix enabling of EPEL on non-RHEL systems
* Don't attempt to enable epel on anything but Red Hat like systems

## Version 2.9-000011 (2020-07-24) (i514383)
### Enhancement - Refactoring role
* Eliminates unused cloudwatch log stream retention code
* Reorganizes lines of business from multiple lists in the defaults/main.yml file into individual files under the `vars/applications/` directory.

## Version 2.9-000010 (2020-07-23) (i535751)
### Deprecation
* Deprecation of epel dependence in meta file, now managing epel repo through repository-management
* Documentation now shows epel management example through repository-management instead of epel role

## Version Version 2.9-000009 (2020-07-22) (i514383)
### Enhancement - Refreshing role to support RHEL 8
* Incorporates EPEL deprecation
* Installs additional dependencies for collectd RHEL 8 compatability
* Adds `ansible_distribution_major_version == '8'`

## Version 2.9-000008 (2020-07-20) (i869415)
### Enhancement - Added '/var/log/syslog' file to defaults
* Added the '/var/log/syslog' file to the 'default' application_preset_selection.
* Makes the 'default' application_preset_selection compatible with Ubuntu.

## Version 2.9-000007 (2020-03-31) (i869415)
### Enhancement - Added `gitlab` application_preset_selection values
* Added the application_preset_selection values for `gitlab`.

## Version 2.9-000006 (2020-03-16) (c5295459)
### Enhancement - Add Ansible log group
* Added `/var/log/ansible.log` log group for Ansible logging
* Updated log group names to more adequately align with log file path
* Removed the following unusable CloudWatch Log Groups
*   `hana_compileserver_ip`
*   `hana_hdb_sap`
*   `hana_hdbinst_log`
*   `hana_indexserver_ip`
*   `hana_indexserver_ip_executed_statements`
*   `hana_index_server_ip_loads`
*   `hana_indexserver_oom`
*   `hana_indexserver_rtedumps`
*   `hana_nameserver_history`
*   `hana_nameserver_oom`
*   `hana_nameserver_rtedumps`
*   `hana_preprocessor_ip`
*   `hana_preprocessor_oom`
*   `hana_rsutil_ip`
*   `hana_scriptserver_alert`
*   `hana_scriptserver_ip`
*   `hana_stdout`
*   `hana_system_availability`
*   `hana_webdispatcher_oom`
*   `hana_webdispatcher_rtedumps`
*   `hana_xsengine_ip`

## Version 2.9-000005 (2020-03-13) (c5295459)
### Bugfix - Remove /var/log/*
* Until a more permanent fix can be found, removing the `/var/log/*` log group
* Found to cause memory consumption issues with small AWS instance types

### Enhancement - Update default log paths
* Identify and prescribe better log group paths for the following logs:
*  `/var/log/consul/consul-*.log`
*  `/var/log/vault/vault_audit.log`
*  `/var/log/clamscan.log`
* Added `"timezone": "UTC"` to CloudWatch Logs configuration

## Version 2.9-000004 (2020-03-07) (i516349)
### Bugfix - Adjusting package gpg check
* Removing gpg check even with signature being loaded
* Similar [issue raised upstream](https://github.com/christiangda/ansible-role-amazon-cloudwatch-agent/issues/3) with similar resolution

## Version 2.9-000003 (2020-02-07) (c5295459)
### Enhancement - Add Collectd integration
* Add `cloudwatch_integrate` variable, defaulting to true, for collectd integration
* Create ability to dynamically update CPIDS and WebDispatcher logs and lists for agent config
* Add `include_role` for collectd to integrate Collectd and Cloudwatch together

## Version 2.9-000002 (2020-01-03) (c5295459)
### Enhancement - Adding cpu usage
* Adding aggregated cpu usage across all available cores to agent collectd metrics

## Version 2.9-000001 (2019-12-27) (i516349)
### Bugfix - Adding handler to reload systemd
* Adding handler to ensure executions of the role picked up configuration changes

### Enhancement - Renaming role for clarity
* Renaming role for clarity as cloudwatch alarms role exists

## Version 2.8-000011 (2019-11-14) (c5295459)
### Bugfix - Fixing aide, audit, and tuned log file locations
* Adding  `/var/log/aide/aide.log` to file_path variable
* Adding `/var/log/audit/audit.log` to file_path variable
* Adding `/var/log/tuned/tuned.log` to file_path variable

## Version 2.8-000010 (2019-11-06) (i516349)
### Enhancement - Adding sap available log to log ingestion
* Adding `/usr/sap/*/*/work/available.log` to ensure capturing sap system availability

## Version 2.8-000009 (2019-11-22) (c5290493)
### Enhancement - Added logging of disk usage and memory back into configuration.
* Disk and memory logging required for aws-cloudwatch-alarms role. Which calls this role.

## Version 2.8-000008 (2019-09-10) (i516349)
### Bugfix - Fixing Tenable Nessus log group names
* Removing extra slash from AWS CloudWatch logstream group name

## Version 2.8-000007 (2019-08-29) (i516349)
### Enhancement - Removing custom CloudWatch metrics
* Removed custom CloudWatch metrics from default configuration

## Version 2.8-000006 (2019-08-15) (i516349)
### Enhancement - Adding Tenable Nessus log paths
* Added Tenable Nessus log directories

## Version 2.8-000005 (2019-08-15) (i869415)
### Enhancement - Move log stream retention modification tasks and fix amazon-cloudwatch-agent.json template
* Fixed bug in `amazon-cloudwatch-agent.json` template when `application_preset_selection=default`.
* Move log stream retention modification tasks to its own task file. Only ran when `modify_log_stream_retention=true`.

## Version 2.8-000004 (2019-08-05) (i514383)
### Enhancement - CloudWatch Log retention period task
* Added four tasks to tasks/configure.yml that change the default log retention period based on the parameter passed for `application_preset_selection`
* Updated defaults/main.yml to include lists of default log groups, sorted by `application_preset_selection` values: default, openvpn, sap, or hana

## Version 2.8-000003 (2019-07-19) (i514383)
### Enhancement - JSON Template Variable
* Updated the variable `logs_default` to include /var/log/aide, /var/log/audit, and /var/log/tuned
* Removed the /linux/ prefix from all log group names

### Bugfix - Removing `copytruncate`
* Removed occurances of the `copytruncate` variable from the templates/logrotate/aws-cwa.j2 file. `copytruncate` truncates the original log file to zero size in place after creating a copy, instead of moving the old log file and optionally creating a new one. There is a small amount of time between copying the file and truncating it, so some logging data may be lost when using this method

## Version 2.8-000002 (2019-07-19) (i516349)
### Bugfix - JSON Template Variable
* using jinja templating properly to escape curly brace as previous variable was not using the correct syntax for cloudwatch

## Version 2.8-000001 (2019-07-02) (i514383)
### Initial version established with the following features
* the aws-cloudwatch role installs and configures CloudWatch
* the aws-cloudwatch ansible-playbook calls the aws-cloudwatch role and the epel role

## Version 2.8-000000 (2019-07-19) (i514383)
### Upstream
* Sourced from [amazon_cloudwatch_agent](https://galaxy.ansible.com/christiangda/amazon_cloudwatch_agent) on ansible-galaxy; the original source code is available in [christiangda's GitHub repository](https://github.com/christiangda/ansible-role-amazon-cloudwatch-agent).
* Two variables were added to the source code.
*   `application_preset_selection`, which takes four arguments: `default`, `hana`, `openvpn`, and `sap`. `application_preset_selection` automatically updates the CloudWatch configuration file to record a set of pre-selected log groups for the hana, openvpn, and sap applications.
*   `default_log_stream_name`, which takes two arguments: `instance_id`, which is the default, and `hostname`.
* The template configuration file for the CloudWatch agent, template/agent/amazon-cloudwatch-agent.json.j2, was modified to allow the list of logs collected and the log stream names to be variablized and easily updated via the command line when running the playbook.
* The defaults/main.yml file was updated to include the `application_preset_selection` and `default_logstream_name` variables.
* The playbook aws-cloudwatch.yml was updated to use the existing EPEL role in the NS2-ansible-roles GitLab repository, instead of one pulled from the internet.
