Distributed Calculate Disks role
============================

Ansible role for calculating disk space for Distributed systems

Requirements
------------

### General Requirements

* Ansible 2.16+
* Boto
* Boto3
* Botocore
* EFS synchronized with SPR S3

### AWS Requirements

* aws cli  

### Azure Requirements

* azcopy
* az cli

Role Input Variables
--------------
| Name | Type | Description |
|------|------|-------------|
| spr_nodetype | groupvars | The nodetype must be specified for determining disk calculation. See `Example Playbook` for more details |
| distributed_calculate_disks_test_app_swap | bool(default: false) | Test if `/swap` disk creation is successful |
| distributed_calculate_disks_test_app_sapmnt | bool(default : false) | Test if `/sapmnt` disk creation is successful |
| distributed_calculate_disks_test_db_hana | bool(default: false) | Test if hana db disks creation are successful |
| distributed_calculate_disks_test_usr_sap | bool(default: false) | Test if `/usr/sap` disk creation is successful |

Role Output Variables
--------------
| Name | Type | Description |
|------|------|-------------|
| distributed_calculate_disks_output_custom_volume_map | dictionary | Contains the calculated disks in the form of a map suitable for shared SCS ansible role `disk-management`. See `Example Playbook` for more details. Refer to [disk-management](https://gitlab.core.sapns2.us/scs/shared/ansible/roles/-/tree/main/disk-management) for input variable requirements |

Dependencies
------------

* To run the `Testing Suite`, the [disk-management](https://gitlab.core.sapns2.us/scs/shared/ansible/roles/-/tree/main/disk-management) scs shared ansible role must be executed with the `distributed_calculate_disks_output_custom_volume_map` variable.

Example Playbook
------------
spr_nodetype grouping:
```
- hosts: all
  tasks:
  - name: "Dynamic Group Assignment"
    ansible.builtin.group_by:
      key: "{{ item }}"
    when: "item != 'undefined'"
    loop:
    - "{{ spr_nodetype|default('undefined')|lower }}"

  - name: Calculate disks for APP hosts (HA or SDDR)
    ansible.builtin.include_role:
      name: distributed-calculate-disks
      tasks_from: app-ha-or-sddr-nodes.yml

# Output generated from role:
distributed_calculate_disks_output_custom_volume_map:
  swap:
    mount_point: '/swap'
    size: 64
```
Run Integration Tests for DB hosts:
```
- hosts: all
  tasks:
  - name: Run Integration Tests for DB hosts
    ansible.builtin.include_role:
      name: distributed-calculate-disks
      vars_from: test-db.yml
```

Testing
------------

* Each test can be manually toggled in the `defaults/main.yml`, `vars` directory, or directly in the playbook running this role.
* There is no `test-all.yml` vars file as it is only possible to test `app` or `db` host specifically.

License
------------

BSD

Author Information
------------

dexter.le@sap.com
