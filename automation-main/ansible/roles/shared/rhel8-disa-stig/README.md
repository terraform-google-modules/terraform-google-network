DISA STIG for Red Hat Enterprise Linux 8
========================================

Ansible Role for configuring the DISA STIGs for Red Hat Enterprise Linux 8

Requirements
------------

* Ansible version 2.9 or higher.
* A RHEL 8 system.
* RHEL 8 DISA STIG Version 1, Release 3

Role Variables
--------------

* Default variables can be found in the [defaults/main.yml](./defaults/main.yml) variables file.
* The list of available STIG ID variables can be found in the [vars/main.yml](.vars/main.yml) variables file.
* `application_preset_selection` string used to select one of the variable file mappings found in the `product_stig_map` variable within the [vars/main.yml](.vars/main.yml) variables file.

Example Role Usage
------------------

Given the following `redhat8-harden.yml` playbook, the role can be ran using the command `ansible-playbook -i <IP_ADDRESS>, redhat8-harden.yml -e "application_preset_selection='base'"`. This will apply all STIGs associated with the `base` preset as per the `product_stig_map` variable in [vars/main.yml](.vars/main.yml):

```
- name: RHEL 8 DISA STIG
  hosts: all
  gather_facts: true
  tasks:

  - name: Run the 'rhel8-disa-stig' role to configure DISA STIGs
    include_role:
      name: rhel8-disa-stig
```

The following command will apply all STIGs listed in the [vars/all-stigs.yml](./vars/all-stigs.yml) variables file:

```
ansible-playbook -i <IP_ADDRESS>, redhat8-harden.yml -e "application_preset_selection='all'"
```

Tenable and OpenSCAP Results
----------------------------

The latest compliance scan results from OpenSCAP and Tenable Nessus can be found in the [files/](./files/compliance) directory of the role. Note that these scan files do not take into consideration the DISA STIGs that are documented as exemptions in the [EXEMPTIONS.md](./EXEMPTIONS.md) file. These scan results were taken from a system after the following was performed to it:

1. Enable `base` repositories and update all packages on the system.
2. Run the `rhel7-disa-stig` Ansible role with the `-e "application_preset_selection='all'"` extra var.
3. Reboot the system via the `reboot` command.

The following is a table documenting the role's current compliance with Tenable Nessus and OpenSCAP DISA scans.

| Date         | Tenable Nessus Compliance | OpenSCAP DISA Compliance |
| ------------ | ------------------------- | ------------------------ |
| `2021-11-10` | `84.59%`                  | `94.35%`                 |

License
-------

* BSD-3-Clause

Author Information
------------------

* Matt Bittner (Matthew.Bittner@SAPNS2.com)
* Lance Wray (Lance.Wray@SAPNS2.com)
* Jay Senseman (Jay.Senseman@SAPNS2.com)
* Dexter Le (dexter.le@sap.com)
* Red Hat Ansible RHEL 8 DISA STIG role ([https://github.com/RedHatOfficial/ansible-role-rhel8-stig/graphs/contributors](https://github.com/RedHatOfficial/ansible-role-rhel8-stig/graphs/contributors))
* ComplianceAsCode project ([https://github.com/complianceascode/content/blob/master/Contributors.md](https://github.com/complianceascode/content/blob/master/Contributors.md))
