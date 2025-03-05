# Latest Version
2.9-000031

# Version History
## Version 2.9-000031 (2025-02-04) (i746373)
### Enhancement - support SLES 15
* support sles 15

## Version 2.9-000030 (2024-09-18) (c5361285)
### Enhancement - Add Tenable-SC and Trend Micro log ports
* add ports for deepsecmng(trend) and tenable_sc

## Version 2.9-000029 (2024-05-1) (i746373)
* add variables to support ubuntu 22.04

## Version 2.9-000028 (2024-01-8) (i561481)
* Added port list variable for gitlab_docker

## Version 2.9-000027 (2024-01-05) (i571239)
### Enhancement - Add SLES 15 Support
* Add SLES 15 tasks for installing and configuring collectd

### Enhancement - Deprecate "yes" argument
* Remove "yes" arguments in favor of "true"

## Version 2.9-000026 (2023-08-24) (i571239)
### Enhancement - Adding port for SAP Router
* Added port list variable for SAP Router

## Version 2.9-000025 (2023-03-31) (i558332)
### Enhancement - Add freeradius ports
* Add freeradius ports and new cloudwatch freeradius preset

## Version 2.9-000024 (2022-11-29) (i552364)
### Enhancement - Adding port for SAP cloud connector
* Added port list variable for cloudconnector (SAP cloud connector)

## Version 2.9-000023 (2022-10-18) (c5279079)
### Enhancement - Adding ports for more products
* Added empty ports list variables for bizx, bizx_app, icontent, lms, lms_web, pi

## Version 2.9-000022 (2022-05-06) (i869415)
### Enhancement - Adding 'gardener-shoot' preset support
* Added a ports list variable to support the new 'gardener-shoot' application preset selection.

## Version 2.9-000021 (2021-05-21) (i868402)
### Enhancement - Remove legacy cpids port
* Remove monitoring for port 1717 on CPIDS instance types

## Version 2.9-000020 (2021-04-29) (i513825)
### Feature - Add File-Transfer ports
* Added the file_transfer ports alongside the new cloudwatch file_transfer preset

### Bugfix - remove duplicate `ports_base` variable
* Removed duplicate `ports_base` default from `defaults/main.yml`

## Version 2.9-000019 (2021-03-05) (i868402)
### Enhancement - Update for S4PCE
* Update product list for S4PCE

## Version 2.9-000018 (2020-12-18) (c5295459)
### BugFix - Add ignore SSL host verification for Fiori Launchpad
* Add VerifyHost set to `false` for Fiori Launchpad (WebDispatcher) SSL verifications

## Version 2.9-000017 (2020-11-21) (c5309377)
### Feature - Add Postfix ports
* Added the postfix ports alongside the new cloudwatch postfix preset

### Bugfix - Don't set AWS region
* Don't set the AWS region, when on an EC2 instance it's smart enough to figure it out on its own!

## Version 2.9.000016 (2020-11-19) (i869415)
### Bugfix - Fixed placing of collectd.conf file on Ubuntu systems
* Modified role to place the collectd.conf template at the correct location for Ubuntu systems.
* Collectd was using the default collectd.conf file on Ubuntu systems, causing 'rrdtool' errors.
* Corrected conditional check for 'ansible_os_family' Ansible fact to the correct value for Ubuntu.

## Version 2.9.000015 (2020-11-06) (c5295459)
### Enhancement - Add missing `ports_bastion` variable
* Added missing `ports_bastion` variable that was causing the role to fail

## Version 2.9.000014 (2020-10-08) (i513825)
### Bugfix - remove `yajl` package for Amazon Linux
* `yajl` package not found in standard Amazon Linux EPEL repository, so it has been removed from the package installation list for Amazon Linux machines

## Version 2.9.000013 (2020-09-20) (i869415)
### Bugfix - Add missing 'ports_gitlab' variable
* Added a missing 'ports_gitlab' variable that was causing the role to fail.

## Version 2.9.000012 (2020-09-03) (i511522)
### Bugfix - Create subdirectories in /opt/collectd-plugins
* Create /opt/collectd-plugins/cloudwatch/config directory to resolve scp-bastion-hardening error

## Version 2.9-000011 (2020-09-01) (i511522)
### Bugfix - Removed awslabs plugin
* Removed awslabs plugin that pushed collectd data to cloudwatch agent (native support now)

## Version 2.9-000010 (2020-08-26) (i869415)
### Bugfix - Added missing presets and fix template file
* Added missing port variables for different application presets.
* Fix conditional in collectd.conf.j2 template file.

## Version 2.9-000009 (2020-08-25) (i839460)
### Enhancement - support for other presets
* Added support for all other application presets (variants)

## Version 2.9-000008 (2020-08-10) (i839460)
### Enhancement - support base preset
* Added support for 'base' product / application preset

## Version 2.9-000007 (2020-08-03) (i514383)
### Bugfix - Fixing typo
* Adding forgotten `and`

## Version 2.9-000006 (2020-07-31) (i514383)
### Bugfix - Added support for python3 via a open PR
* Modified the git clone of https://github.com/awslabs/collectd-cloudwatch.git to reference python3-compatible PR

## Version 2.9-000005 (2020-07-30) (i514383)
### Bugfix - Validating RHEL 8 compatibility
* Removes RHEL dependency that was causing errors
* Installs yajl as a dependency

## Version 2.9-000004 (2020-07-01) (i826342)
### Bugfix - Package set for Ubuntu differs
* ubuntu uses collectd-core

## Version 2.9-000003 (2020-03-26) (i868402)
### Bugfix - Multiple localhost runs
* set delegate_to:localhost to only run once.

## Version 2.9-000002 (2020-02-12) (i869415)
### Bugfix - Fixed conditional for SAP availability logs
* Fixed a conditional in collect.conf template causing the role to fail when ran for non-SAP or non-HANA systems.

## Version 2.9-000001 (2020-02-11) (c5295459)
### Initial version established with the following features
* Variable for integrating Collectd with Cloudwatch
* SAP App, CPIDS, HANA, Webdispatcher, and OpenVPN ports defined in variables
* Leverage `git` module to pull most recent AWS code local to  user's workstation
* Copies AWS collectd-cloudwatch integration code from user's workstation to target
* Ensures `collectd` and `collectd-curl` packages are installed
* Programmatically determines availability.log location and registers variable
* Updates Collectd whitelist and Collectd conf file based on application and ports monitored
* Includes the default collectd.conf for future reference
* Includes Jinja template for collectd.conf, whitelist.conf, and plugin.conf
