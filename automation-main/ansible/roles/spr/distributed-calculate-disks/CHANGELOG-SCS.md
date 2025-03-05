## 2025-03-04 | i571239
### ['ansible', 'spr'] | [MR 154](https://gitlab.core.sapns2.us/scs/ste/automation/-/merge_requests/154)
* [Disks Jira Link](https://jira.tools.sap/browse/SCSTE-1816)
* _Add `distributed-calculate-disks` ansible role for calculating disk size for distributed systems_
* _Add `distributed-mount-nfs` ansible role for managing nfs mounts for distributed systems_
* _Add_ `distributed-nw-disks-create.yml` runbook
* _Initial implementation of disks create with test suite for validating final state of system_
* [HSR Jira Link](https://jira.tools.sap/browse/SCSTE-1888)
* _Add `distributed-hana-config` ansible role for managing and configuring distributed hana db instances_
* _Add_ `setup-hana-sync-replication.yml` runbook for hana config provisioning on distributed db instances

# Latest Version
2.16-000001

# Version History
## 2.16-000001 (2024-08-23) (i571239)
### Initial version established with the following features
* Test suite for disk creation and calculation
* Calculates disk and storage space required for distributed systems
