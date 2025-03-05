# Latest Version
2.12-000001

# Version History
## Version 2.12-000001 (2024-05-30) (c5360422)
### Enhancement - Added custom metrics enable/disable flag to enable/disable metrics gathering through CloudWatch
* Added custom metrics enable/disable flag to enable/disable metrics gathering through CloudWatch
* If metrics gathering is disable the CloudWatch alarms for custom metrics are not configured

## Version 2.12-000000 (2023-06-21) (i511522)
### Enhancement - Ansible 2.12 compatibility
* Update comparison syntax for ansible 2.12 compatibility

## Version 2.9-000019 (2023-03-10) (c5355631)
### Enhancement - Modify description of cloudwatch alarm to include customer number and sid
* Used jinja conditionals to modify description of Create CloudWatch EC2 Auto-Recovered Instance Alert task

## Version 2.9-000018 (2023-03-03) (i552364)
### Bugfix - Fixed jinja2 templating error in the when statement
* Reduced period to 60secs for inactive host alarm

## Version 2.9-0000117 (2022-05-12) (i870146)
### Bugfix - Fixed jinja2 templating error in the when statement
* Removed `{{ }}` in the when statements to fix jinja2 templating error

## Version 2.9-0000116 (2022-03-31) (i514383)
### Bugfix - Disable port, url, and availability log alarms for s4
* Disable port, url, and availablity log alarms for s4

## Version 2.9-000015 (2022-03-31) (i868402)
### Bugfix - ec2_metric_alarm missing unit
* Some calls to ec2_metric_alarm had "unit" undefined

## Version 2.9-000014 (2022-01-18) (c5323009)
### Bugfix - Updated galaxy_info variables missing breaking molecule test runner
* Added role_name and namespace variables if missing broke molecule test runner

## Version 2.9-000013 (2021-10-28) (i511522)
### Enhancement - Add ok_actions to all alarms
* Add ok_actions to SNS topic to resolve VictorOps incidents automatically

## Version 2.9-000012 (2021-05-21) (i868402)
### Enhancement - Remove legacy cpids port
* Remove monitoring for port 1717 on CPIDS instance types

## Version 2.9-000011 (2021-05-05) (c5323009)
### Bugfix - Updated ns2-scp-dev.sapns2.us domain to gitlab.core.sapns2.us
* Updated issue_tracker_url variable using old gitlab domain to new core services domain

## Version 2.9-000010 (2021-03-19) (i868402)
### Enhancement - Alarm Creation Throttle
* Adds an optional throttle to alarm creation

## Version 2.9-000009 (2021-03-05) (i868402)
### Enhancement - S4PCE products
* Update code for S4PCE Products
### Enhancement - Create Volume alarms in parallel
* Fixed code to create volume alarms in parallel instead of serially.

## Version 2.9-000008 (2020-10-21) (i868402)
### Bugfix - cw_preset variable
* Don't overwrite the preset variable if it's already defined

## Version 2.9-000007 (2020-10-21) (i868402)
### Enhancement - Allow no email and no sms
* Don't try to create an sns_topic when no email or sms provided.

## Version 2.9-000006 (2020-10-19) (c5295459)
### Enhancement - Alter CloudWatch Agent to specifically 1.246396.0
* Add conditionals for `aws_sns_text_numbers` and `aws_sns_subscription_email`

## Version 2.9-000005 (2020-10-15) (c5295459)
### Enhancement - Adds SMS-based SNS alerting
* Adds ability to add multiple SMS notifications

### BugFix - update cURL response in URL monitoring metric
* Updates URL monitoring metric alarming with updated collectd metric dimensions

## Version 2.9-000004 (2020-09-04) (i861009)
### Enhancement - Removed relative paths
* Removed relative path for include_role task

## Version 2.9-000003 (2020-09-01) (i511522)
### Bugfix - Updating collectd alarms
* Updated collectd alarms to point to cloudwatch agent natively integrated collectd metrics

## Version 2.9-000002 (2020-08-17) (i516349)
### Bugfix - Removing dimensions
* Removed unnecessary dimensions no longer in use

## Version 2.9-000001 (2020-06-14) (i861009)
### Feature - Create new alarm
* Create alarm to email alert for inactive instances

### Enhancement - Minor improvements
* Guarantees SNS topic exists
* Now requires the subscription email to be set

## Version 2.8-000006 (2020-02-27) (c5295459)
### Enhancement - Update Alarm name to key off Business tag
* Update Alarm name `set_fact` to key off the Business tag, rather than Node
* Update Alarm name for when Business is `ibp` to maintain consistent naming
* Update Alarm name for when Business is not `ibp` for consistent naming
* Update Alarm name for IBP's `Webdispatcher` to be full name, rather than abbreviation

## Version 2.8-000005 (2020-02-10) (c5295459)
### Enhancement - Add Collectd alarms
* Add application ports to role defaults for creating Cloudwatch alarms
* Break out disk alarms from other, more basic, alarm creation
* Renamed `configure_alarms.yml` to `configure_disk_alarms.yml`
*  - Updated header information to include the output of Cloudwatch alarms
* Created new `configure_basic_alarms.yml` and included autorecover, CPU, and memory alarms
* Added the following additional alarms to `configure_basic_alarms.yml`
*  - Port monitoring alarm based on application port
*  - Availability log alarm for SAP systems (CPIDS, WebDispatcher, SapApp, and HANA)
*  - CPIDS URL alarm based on cURL Collectd information for CPIDS instances
*  - WebDispatcher URL alarm based on cURL Collectd information for Webdispatcher instances
* Updated `main.yml` to facilitate breaking apart the disk and basic monitoring yml files
*  - Moved `Alarm name` task before individual alarm yml file calls
*  - Reconfigured tasks to include calling both disk and basic monitoring
* Create Jinja template for CPIDS and WebDispatcher URL monitoring and aws cli commands

## Version 2.8-000004 (2020-02-07) (c5295459)
### Enhancement - Alarm CPU Utilization
* Add CloudWatch alarm for CPU utilization. Defaults to 95% and notifies SNS topic.
* Add CloudWatch alarm for memory utilization. Defaults to 90% and notifies SNS topic.

### Bugfix - Resolve role name
* Fixed aws-cloudwatch-agent role name after role renaming

## Version 2.8-000003 (2020-01-06) (c5295459)
### Enhancement - Alarm Auto-Recover
* Add CloudWatch alarm for an instance to auto-recover and notify the SNS topic
* Aligns CloudWatch alarm with current Terraform provisioning code

## Version 2.8-000002 (2019-11-05) (c5290493)
### Enhancement - Role Path Fix
* Updated role references to relative paths to ensure AWX compatibility.

## Version 2.8-000001 (2019-10-18) (c5290493)
### Initial version established with the following features
* Install Cloudwatch agent and configure automatically.
* Configure cloudwatch alarms for disk usage.
* optionally configure SNS subscriptions.
