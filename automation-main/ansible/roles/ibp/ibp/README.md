ibp
================

This role will initial provisioning of IBP instances after they have been created.  Where possible the "tar installation" method will be used.
This role can also be used to setup disaster recovery replication

Requirements
------------

* Please review the IBP setup instructions here: https://gitlab.core.sapns2.us/ibp-cpids-dev/ibp/blob/master/IBP-Infrastructure-Setup.md
* Instances have been domain joined with playbook ibp/ibp-domain-join.yml
* Instances have EBS/EFS volumes mounted with with playbook ibp/ibp-create-disks.yml
* Ansible inventory file populated using ibp/ibp-ansible-inventory-template.yml as a template (instructions below)
* Location of latest source locations. See link above
* Local IP address for all instances to update the host file.  See variable notes below
* Connectivity to the instances.  Typically VPN and/or  private keys
* For disaster recovery: Appropriate instance deployed in disaster recovery landscape.

Role Variables
--------------

General Variables:
* default_password: This is the default password for all new systems.  This will be changed after the handover to ops.
* ibp_staging_hana: Location to find the tar source
* ibp_staging_sap: Location to find the tar source
* sqlcmd_folder: Used by disaster recovery.  Where to find the sql command files
* replication_pair: Used by disaster recovery. Intentionally blank to initialize the variable for the script

Inventory Variables:
* The majority of the variables are derived from the host file.  Please setup using instructions below.

Ansible Inventory File
----------------------

Setup instructions:
1. Copy from the ibp playbooks folder ibp-ansible-inventory-template.yml to the execution location.
```
cp ansible-roles/ibp/ibp-ansible-inventory-template.yml ./ibp_customer00_hosts
```

2. Update the following:
    * efs_staging_ip: ip address of the common staging efs
    * efs_usrsaptrans_ip: ip address of the customer's usersaptrans efs
    * saphostagent_source: path to the SAP Host Agent install files.
    * customer_number: the IBP customer number

3. In the `product groups` section:
    * Fill in the appropriate ip addresses under the host section for each `product` (webdispatcher,cpids,ibpapp,ibpapp)
    * Fill in the correct `RELEASE NAME` for webdispatcher and cpids

4. In the `landscape groups` section:
    * Fill in the appropriate ip addresses under the hosts section for each `landscape` (staging,tests,production,disaster_recovery)
      * If a landscape does not exist or have any instances, leave hosts section blank.
    * Fill in the appropriate SID for each landscape sid.
      * If the landscape does not exist, you MUST leave the sid blank.
    * Fill in the appropriate `RELEASE NAME` for each landscape

Dependencies
------------
n/a

Example Playbook
----------------

The playbook below will set the aws region and hostname of each instance.
```
- name: "Play1:  Set Region"
  hosts: all
  vars:
    hostfile_path: '<path to the ansible inventory>'

  pre_tasks:
  - name: "Read in vars file"
    include_vars:
      file: "{{ hostfile_path }}"

  - name: "Generate role dynamic variables"
    include_role:
      name: ibp
      allow_duplicates: yes
      tasks_from: variables-create.yml

  tasks:
  - name: "Set the host file"
    include_role:
      name: ibp
      allow_duplicates: yes
      tasks_from: hostfile-install.yml

  - name: "Set AWS Region to {{ aws_region }}"
    shell: "/usr/local/bin/aws configure set region {{ aws_region }}"
    become: yes

...
```

Notes
-----
* These notes are left for historical purposes as the playbook and role now fulfills all requirements automatically.
* IBP Must be built in the correct order:  HANA DB, SAPAPP, CPIDS, and finally Webdispatcher.
* Volume Sizing:

Minimum Defaults:

| ServerTYPE | EC2 Type   | RAM |
| ---------- | ---------- | --- |
| HDB        | r5.8xlarge | 256 |
| APP        | r5.xlarge  | 32  |
| CPIDS      | r5.xlarge  | 32  |
| WDISP      | m5.xlarge  | 16  |

Sizing Chart:

| ServerTYPE | FileSystem     | Storage |
| ---------- | -------------- | ------- |
| HDB        | /hana/data     | 2 * RAM
||              /hana/log     | 0.5 * RAM
||              /hana/shared  | 1 * RAM (max 1TB)
||              /usr/sap      | 50GB
||              /hana/backups | 2 * RAM
||              /hana/staging | EFS
| App        | /usr/sap       | 50GB
||             /sapmnt        |50 GB
||            /sap/staging    | EFS
||            /usr/sap/trans  | EFS
||            SWAP            | See SAPNOTE https://gitlab.core.sapns2.us/snippets/134
| CPIDS      | /hana/data     | 2 * RAM
||              /hana/log     | 0.5 * RAM
||              /hana/shared  | 1 * RAM (max 1TB)
||              /usr/sap      | 50GB
||              /hana/backups | 2 * RAM
||              /hana/staging | EFS
| WDISP      | /usr/sap       | 50GB
||            /sap/staging    | EFS

SWAP Sizing:
* Physical Memory (RAM) Recommended Swap-Space
* \< 32 GByte 2 x RAM
* 32 - 63 GByte 64 GByte
* 64 - 127 GByte 96 GByte
* 128 - 255 GByte 128 GByte
* 256 - 511 GByte 160 GByte
* 512 - 1023 GByte 192 GByte
* 1024 - 2047 GByte 224 GByte
* 2048 - 4095 GByte 256 GByte
* 4096 - 8191 GByte 288 GByte
* \> 8192 GByte 320 GByte


License
-------

BSD

Author Information
------------------

louis.lee@sapns2.com
