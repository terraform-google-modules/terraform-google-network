# Latest Version
2.16-000016

# Version History
## Version 2.16.5-000016 (2024-08-19) (i548447)
### Bugfix - Add additional GPG keys
* Add additional GPG keys, reference https://setup.vector.dev

## Version 2.16.5-000015 (2024-05-08) (i743694)
### Bugfix - fixes metadata collection failure when ran against host within any cloud provider
* Removed when conditions ansible_ec2_None is defined & ansible_ec2_None == "None"

## Version 2.12-000014 (2024-05-06) (c5349422)
### Bugfix - fixes vector start failure
* Fixes vector start failure due to yaml syntax errors

## Version 2.12-000013 (2024-03-05) (i743694)
### Bugfix - fixes metadata collection failure when running against non-aws hosts
* Added fail_when to task that fetches ec2 metadata

## Version 2.9-000012 (2023-04-27) (i552364)
### BUGFIX - Fixes vector start failure due to missing vector internal metric source and transform
* Added vector internal metric source and transform to agent config
* Fixes vector start failure due to missing vector internal metric source and transform

## Version 2.9-000011 (2023-04-24) (i571239)
### Enhancement - Add Suse 15 support
* Added zypper support for Suse 15
* Added rpm support for Suse 15

## Version 2.9-000010 (2023-04-21) (i552364)
### Enhancement - GCP Cross Project Logging
* Added support to supply vector version as variable for repo installs
* Added support for vector downgrade

## Version 2.9-000009 (2023-04-17) (c5309336)
### Enhancement - GCP Cross Project Logging
* Setup Vector configs for GCP Cross Project Logging.
* Fixed SAP SFTP Vector Config.
* Fixed various Vector config files.
* Dynamic Vector configs for Cross Project Log Collection.
* Use Vector 0.28.2 due to issues with 0.29.0
* Updated test to reflect recent changes.

## Version 2.9-000008 (2023-02-15) (c5309336)
### Enhancement - Vector Metadata
* Send host IP with vector log events.

## Version 2.9-000007 (2023-01-24) (c5309336)
### Enhancement - Vector Improvements
* Locally zip vector config files before copying them to the remote host.
* Split log transforms into 2 stages: metadata and parsing.
* Increased the open file limit for hosts with Vector running.
* Enabled the Vector API so that we can do health checks and monitor vector status.
* Bugfixes in vector configuration.
* Disable firewalld on vector aggregators.
* Increased concurrency for Firehose.
* Remove log rotated logs from Vector file watchers.

## Version 2.9-000006 (2022-11-02) (c5335697)
### Enhancement - Add new SAP log collection
* Adds new log collection for SAP sftp logs

## Version 2.9-000005 (2022-09-13) (c5309336)
### Enhancement - GCP Sink and Azure Subscription Logging
* Added support for reading from EventHub streams
* Updated the VCS to Splunk VRL to handle EventHub fields
* Added support for GCP Operation Logs Sink Vector config
* Added support for GCP Project Logs ingest via PubSub
* General code cleanup

## Version 2.9-000004 (2022-08-24) (c5309377)
### Enhancement - Add GCP support
* Adds support for GCP to fetch metadata and configures Vector to send the data as appropriate

## Version 2.9-000003 (2022-08-16) (c5309336)
### Enhancement - Vector Logs Refactor
* Refactor vector configs to be namespaced by folder.
* Added new vector config tests
* Updated role to support the aggregator and agent deployments
* Added new vector remapping function for Vector

## Version 2.9-000002 (2022-02-17) (c5309377)
### Enhancement - Add new SAP log collection
* Adds new log collection for various SAP logs

### Enhancement - reduce vector internal logs to warn level
* Set the vector logs to only warn, this reduces the amount of logs that vector itself generates and then sends to the cloud

### Bugfix - Restart vector when deploying new configurations
* Fixes an issue whereby the playbook was not restarting vector when new configuration files were deployed

## Version 2.9-000001 (2022-02-01) (c5309377)
### Initial Version - Add new vector role
* Adds a new vector role for deploying log collection
