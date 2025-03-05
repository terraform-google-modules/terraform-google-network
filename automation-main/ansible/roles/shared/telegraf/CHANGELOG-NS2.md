# Latest Version
2.12-000009

# Version History
## Version 2.12-000009 (2024-03-05) (i743694)
### Bugfix - fixes metadata collection failure when running against non-aws hosts
* Added fail_when to task that fetches ec2 metadata

## Version 2.9-000008 (2023-04-13) (i571239)
### Enhancement - Add Suse 15 support
* Add zypper support for Suse 15 OS

## Version 2.9-000007 (2023-03-07) (i552364)
### Bugfix - Update template for telegraf monitoring
* Fixes error -- AnsibleError: template error while templating string: expected token 'end of statement block', got '+'

## Version 2.9-000006 (2023-02-17) (i552364)
### Bugfix - Fix gpgkey of telegraf yum install
* Fix - Use gpgkey "https://repos.influxdata.com/influxdata-archive_compat.key" vs "https://repos.influxdata.com/influxdb.key"

## Version 2.9-000005 (2022-12-20) (i552364)
### Enhancement - Add GCP support
* Adds ECS compliant labels.customer, labels.environment and labels.product tags in telegraf.j2 template

## Version 2.9-000004 (2022-08-24) (c5309377)
### Enhancement - Add GCP support
* Adds support for GCP to fetch metadata and configures Telegraf to send the data as appropriate

## Version 2.9-000003 (2022-08-16) (c5309336)
### Bugfix - Fix metadata values
* Fixed metadata values for Azure metadata

## Version 2.9-000003 (2022-04-11) (c5309377)
### Enhancement - Use upstream telegraf binary
* Remove the need for our custom built telegraf binary and instead use the upstream version from InfluxDB directly

## Version 2.9-000002 (2022-04-07) (c5309377)
### Bugfix - Remove debug file in /tmp
* Fixes an issue whereby debug output was left in /tmp and was filling the disk

## Version 2.9-000001 (2022-02-01) (c5309377)
### Initial Version - Add new telegraf role
* Adds a new telegraf role for deploying log collection
