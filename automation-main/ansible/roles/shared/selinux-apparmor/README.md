selinux-apparmor
================

Installs selinux or apparmor packages and starts the respective services accordingly.

Requirements
------------

* Anisble 2.9+
* Red Hat Enterprise Linux (RHEL) 7
* Suse Linux Enterprise Server 11

Role Variables
--------------

| Variable Name       | Type     | Default Value   | Description                                           |
| ------------------- | -------- | --------------- | ----------------------------------------------------- |
| apparmor_configure  | boolean  | true            | Whether to modify the AppArmor configurations.        |
| selinux_configure   | boolean  | true            | Whether to modify the SELinux confingurations.        |
| reboot_if_needed    | boolean  | false           | Whether to reboot the system if required by the role. |

Dependencies
------------

N/A

Example Playbook
----------------

Including an example of how to use the selinux/apparmor role:
```
- hosts: all

  vars:
    apparmor_configure: true
    selinux_configure: true
    reboot_if_needed: false

  tasks:
  - name: Configure selinux/apparmor
    include_role:
      name: ../roles/selinux-apparmor
```

License
-------

BSD

Author Information
------------------

Matt Bittner (i869415) matthew.bittner@sapns2.com
