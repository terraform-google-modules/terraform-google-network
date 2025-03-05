Distributed Hana Config role
============================

Ansible role for provisioning Hana DB hosts for Distributed systems

Requirements
------------

### General Requirements

* Ansible 2.16+
* Boto
* Boto3
* Botocore
* [distributed-nw-disks-create.yml](../../../playbooks/spr/distributed/distributed-nw-disks-create.yml) runbook ran to provision disks
* [spr](../spr/README.md) ansible role

### AWS Requirements

* aws cli  

### Azure Requirements

* azcopy
* az cli

Role Input Variables
--------------
| name | type | description |
|------|------|-------------|
| distributed_hana_config_test_db_hana_sync | bool(default: false) | Wait and check for HSR to be enabled on primarydb. **NOTE: This test may exceed 30 minutes if enabled.**|
| distributed_hana_config_sap_hana_hsr_hana_sid | string(default: "") | The instance SID to use |
| distributed_hana_config_spr_hostname | string(default: "") | The instance hostname to use |
| distributed_hana_config_sap_hana_hsr_primary_ip | string(default: "") | The primary ip address, used for delegating primarydb for hsr |
| distributed_hana_config_sap_hana_hsr_hana_primary_hostname | string(default: "") | The primary hostname, used for delegating primarydb for hsr |
| distributed_hana_config_sap_hana_hsr_secondary_ip | string(default: "") | The secondary ip address, used for delegating secondarydb for hsr |
| distributed_hana_config_sap_hana_hsr_hana_secondary_hostname | string(default: "") | The secondary hostname, used for delegating secondarydb for hsr |
| distributed_hana_config_sap_hana_hsr_alias | string(default: "") | The alias used for hsr |
| distributed_hana_config_sap_hana_hsr_rep_mode | string(default: "") | The replication mode used for hsr (i.e. Active mode) |
| distributed_hana_config_sap_hana_hsr_oper_mode | string(default: "") | The operation mode used for hsr |
| distributed_hana_config_sap_hana_hsr_hana_db_system_password | string(default: "") | The database system password |

Role Output Variables
--------------
| name | type | description |
|------|------|-------------|
| distributed_hana_config_output_checksr | string(default: "") | Output to check if hsr is enabled or disabled |

Dependencies
------------

* N/A

Example Playbook
------------
```
# Run Integration Tests only on primarydb
- hosts: all
  tasks:
  - name: Run Integration Tests
    ansible.builtin.include_role:
      name: distributed-hana-config
      vars_from: test-all.yml
    vars:
      distributed_hana_config_sap_hana_hsr_hana_sid: "{{ sap_hana_hsr_hana_sid }}"
    when: sap_hana_hsr_role == 'primary'
```

Testing
------------

* Each test can be manually toggled in the `defaults/main.yml`, `vars` directory, or directly in the playbook running this role.

License
------------

BSD

Author Information
------------

dexter.le@sap.com
