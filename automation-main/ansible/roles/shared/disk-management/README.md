disk-management
===============

Creates AWS EBS volumes, Azure disks, and GCP disks and configures them with linux volume management (LVM)

Supported Platforms
------------

AWS
AZURE
GCP

NOTE: Automatic resizing is currently disabled for Azure as volumes cannot be resized while their host is still running.

Supported platforms for delegation hosts:
* AWS
  * RHEL 7.5/7.6/7.7
  * RHEL 8.1/8.2
  * UBUNTU 16.04/18.04
* Azure
  * UBUNTU 16.04
* GCP
  * RHEL 7.5/7.6/7.7
  * RHEL 8.1/8.2
  * UBUNTU 16.04/18.04

Requirements
------------

* Ansible 2.9
    * `gather_facts: yes` must be set
* AWS CLI 1.16      (Amazon)
* Azure CLI 2.0.69  (Azure)
* boto/boto3
* parted

Role Variables
--------------

| variable name           | description |
| -------------           | ----------- |
| disk_create             | boolean value; when set to true, disks will be created |
| disk_resize             | (inactive feature) boolean value; when set to true, disks will be resized |
| task_delegation         | Inventory host to delegate Azure/AWS cli tasks to. Default to `localhost`. Set to `none` if not delegating, which installs dependencies to target host. |
| disk_encryption         | boolean value; when set to true, disks other than swap will be encrypted with default aws kms key for that region |
| disk_preset_selection   | reference to predefined list of volumes and relevant settings |
| azure_resource_group    | The resource group we'll be targeting in Azure. Default to `''`. When set, Azure specific tasks will be used rather than AWS |
| azure_disk_type         | The Azure disk type to create/resize. Options include: Standard_LRS, StandardSSD_LRS, Premium_LRS, UltraSSD_LRS |
| gcp_service_account_file      | The path to the GCP service account file used to create disks. Not set by default. When set, GCP specific tasks will be run |
| gcp_auth_kind           | GCP auth type to use. One of application, serviceaccount or machineaccount |

Dependencies
------------

The following dependencies are required on the delegation host, or the host that all credentials and cloud provider dependencies are configured on. The dependencies differ by platform and cloud provider.

* AWS Dependencies:
  * AWS CLI
  * AWS IAM permissions necessary to list, describe, create, destroy, and tag volumes
  * RHEL 7.7:
    * Install python3.6 with yum
    * Set python interpreter to `/usr/bin/python3`
  * RHEL 7.5/7.6
    * Install python2-boto
  * Ubuntu 16.04
    * Install parted, python3-pip, python3-wheel, and python3-packaging with yum
    * Install boto3 with pip
    * Set python interpreter to `/usr/bin/python3`
* Azure dependencies
  * Azure service principle credentials configured as **localhost** environment varibles
  * Ubuntu 16.04
    * Install python3-pip, python3-wheel, and python3-packaging with yum
    * Install ansible[azure], and msrestazure with pip
    * Set python interpreter to `/usr/bin/python3`
* GCP dependencies
  * gcloud cli
  * GCE default service account credentials
  * Python libraries:
    * requests
    * google-auth

Any other delegation host platforms are not directly supported.

Example Playbook
----------------

The following playbook will create two 5GB disks, one with a disk type of `io1` and the other `gp2`, with a logical volume group per disk e.g., (vg_opt_123456 and vg_nessus_123456) with logical volumes (lv_opt, lv_nessus) with an XFS filesystem on the local host:

```
- hosts: localhost
  vars:
    disk_create: true
    disk_resize: true
    disk_preset_selection: 'custom'

  - name: Include disk management role to create, attach, parition, format, and mount disks
    include_role:
      name: disk-management
    vars:
      custom:
        opt:                                    # name of the logical volume group
          mount_point: '/opt'
          size: 5                               # size of volume in gigabytes
        nessus:
          mount_point: '/nessus'
          type: io1
          size: 5
```

The following playbook will remotely create six disks with static default values for a hana system as defined in the `defaults/main.yml` file:

```
- hosts: 10.10.0.10
  vars:
    disk_encryption: true
    disk_preset_selection: 'sap_hana'

  - name: Include disk management role to create, attach, parition, format, and mount disks
    include_role:
      name: disk-management
```

The following playbook will create three disks with static default values on a nitro-based sap application central service (cs) as defined in the `defaults/main.yml` file:

```
- hosts: localhost
  vars:
    disk_create: true
    disk_preset_selection: 'sap_cs'

  - name: Include disk management role to create, attach, parition, format, and mount disks
    include_role:
      name: disk-management
    vars:
      sap_cs:
        sapmnt:
          size: 50
        usr_sap:
          size: 50
        swap:
          size: 20                          #twice the current ram
```

The following playbook will create two standard SSD type disks with static default values on an Azure virtual machine:

```
- hosts: localhost
  vars:
    disk_create: true
    disk_preset_selection: 'custom'
    azure_resource_group: 'golden-build'
    disk_storage_account_type: 'StandardSSD_LRS'

  - name: Include disk management role to create, attach, parition, format, and mount disks
    include_role:
      name: disk-management
    vars:
      custom:
        opt:                                    # name of the logical volume group
          mount_point: '/opt'
          size: 5                               # size of volume in gigabytes
        nessus:
          mount_point: '/nessus'
          size: 5
```

The following will create create three encrypted pd-standard disks on a GCP Compute Engine

```
- hosts: all
  vars:
    disk_create: true                          # Set to true to enable creation
    disk_resize: false                          # Set to true to enable resizing
    task_delegation: 'localhost'                # Set the delegation host for performing cloud provider interface tasks
    disk_encryption: true
    disk_encryption_key_default: 'key-name'
    disk_encryption_keyring_default: 'keyring-name'
    disk_preset_selection: 'custom'
    gcp_service_account_file: '~/service-account.json`

  tasks:
  - name: Include disk management role to create/resize disks, including attachment, partitioning, formatting, and mounting
    include_role:
      name: disk-management
    vars:
      custom:
        data1:                                   # name of the logical volume group
          mount_point: '/data1'                  # mount point on host
          size:15                                # size of volume in gigabytes
        data2:                                   # name of the logical volume group
          mount_point: '/data2'                  # mount point on host
          size: 20                               # size of volume in gigabytes
        data3:                                   # name of the logical volume group
          mount_point: '/data3'                  # mount point on host
          size: 10                               # size of volume in gigabytes

...
```

License
-------

BSD

Issues
------

* volume group renaming should be a task handled by this role
* default values for hana and sap app presets should be auto-calculated with user-defined overrides
* the module used to attatch disks to Azure VMs (azure_rm_manageddisk) is not idempotent

Author Information
------------------

Vighnesh Sivakumar (vighnesh.sivakumar@sapns2.com)
Alijohn Ghassemlouei (alijohn.ghassemlouei@sapns2.com)
Matthew Bittner (matthew.bittner@sapns2.com)
Will Rivera (william.rivera@sapns2.com)
Lance Wray (lance.wray@sapns2.com)
