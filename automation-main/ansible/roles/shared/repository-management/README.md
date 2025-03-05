Repository Management
=====================

This playbook calls the 'repository-management' Ansible role to enable or disable repositories that pull from NS2 provided repository S3 buckets. Predefined lists of repositories can be selected to be enabled or disabled via the 'application_preset_selection' variable. Additionally, the role can attempt to automatically get the list of repositories that were used to create the image that the system was created from.

Requirements
------------

* Anisble 2.9+
* NS2 provided repository S3 buckets.
* Sudo privileges to the system.
* Supported operating systems:
  * RHEL 7.4 through 7.9
  * RHEL 8.0 through 8.4
  * Ubuntu 18.04
  * Amazon Linux 1 and 2
  * SLES 15

Role Variables
--------------

| Variable Name                | Type | Default Value   | Description |
| -------------                | ---- | --------------- | ----------- |
| repo_enable                  | bool | `false` | Whether to enable the repositories that are selected via the 'application_preset_selection' variable. |
| repo_disable                 | bool | `false` | Whether to disable the repositories that are selected via the 'application_preset_selection' variable. |
| repo_delete                  | bool | `false` | Whether to remove all repositories and repository files that were setup by this Ansible role. |
| repo_force                   | bool | `false` | Whether to force the re-downloading of the repository file and the re-enabling of the repositories within it. |
| application_preset_selection | list | `['base']` | The preset list of repositories to enable/disable that is listed under 'repository_list[ <operating_system> ]' |
| automatic_preset_selection   | bool | false | Whether to dynamically get the list of repositories to enable/disable via the 'application_preset_selection' value that was used to create the image that this system was created from. |
| repo_dns_list                | list | See `defaults/main.yml` | A list of repository servers to download the repository file from. |
| repository_list              | dict | See `defaults/main.yml` | A dictionary for each operating system containing preset lists of repositories to enable/disable. |

Dependencies
------------

**Repository S3 Buckets:** This role downloads a repository file from a repository server hosted in an AWS S3 bucket. The available repository server addresses are listed in the `repo_dns_list` variable found in the `defaults/main.yml` variables file. The role will download the repository file from the first address in the list that it can connect to. Repository files are stored on RHEL systems at `/etc/yum.repos.d/` and on Ubuntu systems at `/etc/apt/sources.list.d/`.

Example Playbooks
----------------

The following playbook will download a repository file from S3 and enable repositories associated with the `hana` and `epel` presets:
```
- hosts: all
  gather_facts: true
  vars:
    repo_enable: true
    application_preset_selection: ['hana','epel']

  tasks:
    - name: Call the repository-management role to add or remove repositories from the system
      include_role:
        name: repository-management
```

The following playbook will disable repositories associated with the `base` preset:
```
- hosts: all
  gather_facts: true
  vars:
    repo_disable: true
    application_preset_selection: ['base']

  tasks:
    - name: Call the repository-management role to add or remove repositories from the system
      include_role:
        name: repository-management
```

License
-------

BSD

Author Information
------------------

* Matt Bittner (i869415) matthew.bittner@sapns2.com
* Dexter Le (i571239) dexter.le@sap.com
* Rex Tran (i537609) rex.tran@sap.com
