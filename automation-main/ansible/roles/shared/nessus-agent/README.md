Nessus Agent
============

Installs and configures Tenable Nessus agents.

Requirements
------------

* Anisble 2.9+
* RHEL 7.7+, Amazon Linux 1+, Suse 12+, Ubuntu 14+
* Access to AWS S3 bucket with Nessus RPM(s)

Role Variables
--------------
* For a complete list of `nessus_s3_bucket_name`, `nessus_manager_address`, `nessus_registration_key`, and `nessus_agent_group` variables, please refer to this Confluence page https://nsqconflu2.sapgss.com/display/CS/Nessus+Agent+Linking+Reference.

| Variable Name | Default | Description | Value Options |
| ------------- | ------- | ----------- | ------------- |
| binary_location | `aws_s3` | Location of Nessus Agent binaries. | `aws_s3` or `local` |
| binary_local_folder | | (**mandatory** when `binary_location` is set to `local`) Full local Ansible controller path to folder containing the Nessus Agent binaries | e.g. `/tmp/nessus_agent_binaries/` (download binaries from AWS S3 binaries bucket e.g. `ns2-cre-sms-binaries/media/tenable/` and then copy into local Ansible controller folder) |
| nessus_s3_bucket_aws_region | `us-gov-west-1` | (**mandatory** when `binary_location` is set to `aws_s3`) AWS region containing S3 bucket to download Nessus Agent binaries | (AWS Docs - Regions)[https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-available-regions] |
| nessus_package_version | `8.1.0` | Version of Tenable Nessus agent to install | [Tenable Nessus Agent Releases](https://docs.tenable.com/releasenotes/Content/nessusagent/nessusagent.htm) |
| nessus_manager_port | `8834` | Port number to communicate with Tenable Nessus Manager on | |
| nessus_s3_bucket_name | | (**mandatory** when `binary_location` is set to `aws_s3`) Name of the AWS S3 bucket containing the Nessus Agent packages | e.g. `ns2-cre-sms-binaries` |
| nessus_s3_bucket_path | | (**mandatory** when `binary_location` is set to `aws_s3`) Path within the S3 bucket to the folder containing the Nessus Agent packages | e.g. `media/tenable` |
| nessus_manager_address | | URI to the Tenable Nessus Manager | e.g. `nessus-manager.sms.cre.sapns2.internal` |
| nessus_registration_key | | Tenable manager registration key | |
| nessus_agent_group | | Nessus Scanner scan group name | e.g. `CRE-SCP-CF`, `CRE-SCP-IAS`, `CRE-SCP-AuditLog`, `CRE-SCP-BigData`, `CRE-SCP-Gardener`, `CRE-SAC`, `CRE-IBP`, `CRE-SMS`, `CRE-HCM` |

Example Playbooks
-----------------
Binary location AWS S3 bucket.
```
- hosts: all
  gather_facts: true
  tasks:

    - name: Install Tenable Nessus Agent
      include_role:
        name: nessus-agent
      vars:
        binary_location: aws_s3
        nessus_s3_bucket_name: ns2-cre-sms-binaries
        nessus_s3_bucket_path: media/tenable
        nessus_manager_address: nessus-manager.sms.cre.sapns2.internal
        nessus_registration_key: <REDACTED>
        nessus_agent_group: CRE-HCM
```
Binary location local Ansible controller.
```
- hosts: all
  gather_facts: true
  tasks:

    - name: Install Tenable Nessus Agent
      include_role:
        name: nessus-agent
      vars:
        binary_location: local
        binary_local_folder: /tmp/nessus_agent_binaries
        nessus_manager_address: nessus-manager.sms.cre.sapns2.internal
        nessus_registration_key: <REDACTED>
        nessus_agent_group: CRE-HCM
```

Author Information
------------------

* Don Nguyen (don.nguyen@sapns2.com)
* Alijohn Ghassemlouei (alijohn.ghassemlouei@sapns2.com)
* Devon Thyne (devon.thyne@sapns2.com)
