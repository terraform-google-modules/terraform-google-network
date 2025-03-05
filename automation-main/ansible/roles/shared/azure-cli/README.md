azure-cli
==================

This Ansible role installs the Azure CLI that can be used to work with the Azure Cloud. This role is meant to be ran via the `azure-image-export.yml` Ansible playbook which will call this role before exporting so the Azure CLI exists on all golden images within Azure or the `azure-cli.yml` Ansible playbook which will only install the Azure CLI.

Dependencies
------------

* Ansible v2.9+
* Internet access
* A RHEL 7, RHEL 8, or Ubuntu 18.04 system.
* Sudo privileges to the instance.
* Supported operating systems:
  * RHEL 7.9
  * RHEL 8.1 through 8.4
  * Ubuntu 18.04

Role Variables
--------------

* None

Example Playbooks
----------------

The following playbook will run the `azure-cli` role:
```
- hosts: all
  gather_facts: true
  vars:

  tasks:
    - name: Call the azure-cli role to configure an instance that will be exported to GCP
      include_role:
        name: azure-cli
```

License
-------

BSD

Author Information
------------------

* Rex Tran (i537609) rex.tran@sapns2.com
