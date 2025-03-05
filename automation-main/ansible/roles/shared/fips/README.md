fips
====

Enables or disables Federal Information Processing Standards (FIPS) mode on a bios based Red Hat Enterprise RHEL 7, RHEL 8, or Ubuntu 18, or SLES 15 Linux system

**Table of Contents:**

[[_TOC_]]

Requirements
------------

* Requires valid repositories enabled to install required packages to enable FIPS e.g., dracut-fips for RHEL 7,8
  * Package repositories containing the FIPS related packages must be enabled on RHEL 7 systems using the following:
    ```
    ansible-playbook /etc/ansible/playbooks/repository-management.yml \
      -i localhost, -c local \
      -e "redhat_repo=true repo_enable=true application_preset_selection=base"
    ```
* Requires package repository mirrors enabled to install FIPS packages, for Ubuntu 18
* Requires package repository (LTSS) mirrors enabled to install FIPS packages: dracut-fips and pattern-fips for SLES 15

Role Variables
--------------

| Variable | Type | Choices | Default | Comment |
|-|-|-|-|-|
| fips_mode_enabled | boolean | true, false | true | Whether to enable FIPS (true) or disable FIPS (false) |
| fips_reboot_host | boolean | true, false | false | Whether to reboot the instance after enabling/disabling fips |


Example Playbook
----------------

```
- hosts: localhost
  vars:
    fips_mode_enabled: yes
    fips_reboot_host: yes
  roles:
    - fips
```

License
-------

BSD

Author Information
------------------

* Louis Lee (louis.lee@sapns2.com)
* Sean-Thomas Saloom (sean-thomas.saloom@sapns2.com)
* Dexter Le (dexter.le@sap.com)
