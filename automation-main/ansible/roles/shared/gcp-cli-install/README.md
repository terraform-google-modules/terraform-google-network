gcp-cli-install
==================

This Ansible role installs the Google Cloud SDK for CLI commands and tools that can be used to work with the Google Cloud Platform. This role is meant to be ran via the `gcp-image-export.yml` Ansible playbook which will call this role before exporting so the GCP CLI exists on all golden images within GCP or the `gcp-cli-install.yml` Ansible playbook which will only install the Google Cloud SDK.

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

The following playbook will run the `gcp-cli-install` role:
```
- hosts: all
  gather_facts: true
  vars:

  tasks:
    - name: Call the gcp-cli-install role to configure an instance that will be exported to GCP
      include_role:
        name: gcp-cli-install
```

License
-------

BSD

Author Information
------------------

* Rex Tran (i537609) rex.tran@sapns2.com
