WIP: PoC Distributed NFS Mounts role
============================

Ansible role for managing NFS mount creation for Distributed systems

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
| name | type | description |
|------|------|-------------|
| distributed_nfs_mounts_subdir | list(default: []) | Subdirectories to create on the NFS mount. For example, ['a', 'b'] will create subdirectories at the root of the nfs mount: '/nfs_root/a' and '/nfs_root/b' |
| distributed_nfs_mounts_test_app_mounts_efs | bool(default: false) | Toggle to test if app host efs are mounted |
| distributed_nfs_mounts_test_staging_mount_efs | bool(default: false) | Toggle to test if staging efs are mounted |

Role Output Variables
--------------

N/A

Dependencies
------------

* Device must be mounted on host with the [nfs](https://gitlab.core.sapns2.us/scs/shared/ansible/roles/-/tree/main/nfs) scs shared ansible role.

Example Playbook
------------
```
# Run Integration Tests
- hosts: all
  tasks:
  - name: Run Integration Tests
    ansible.builtin.include_role:
      name: distributed-nfs-mounts
      vars_from: test-all.yml
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
