Network File Share (NFS)
========================

This role will be used to manage the mounting of network file share (NFS) volumes on linux machines. Can optionally support mounting NFS leveraging AWS EFS access points.

Requirements
------------

* Ansible 2.9+
* (Optional) when leveraging feature to mount using AWS EFS access points
    * OpenSSL 1.0.2+
    * Python 3.4+
    * Access to pull down pre-built [aws-efs-utils](https://github.com/aws/efs-utils) RPM/DEB
        * for instructions see [Building AWS EFS Utilities](#building-aws-efs-utilities)
* Validated Cloud Providers:
  * AWS
  * Azure

Role Variables
--------------

| Variable Name | Default | Description | Value Options |
| ------------- | ------- | ----------- | ------------- |
| nfs_dictionary | | (**mandatory**) dictionary of network file shares to configure | see file [defaults/main.yml](defaults/main.yml) for detailed structure |
| nfs_remove_all | `false` | flag to toggle feature to remove all network file shares on/off | |
| nfs_sync | `false` | flag to synchronize nfs shares from nfs_dictionary to remote state on/off | |
| nfs_default_owner | `root` | default owner for network file share mount path | |
| nfs_default_group | `root` | default group for network file share mount path | |
| nfs_default_mode | `0755` | default mode for network file share mount path | |
| nfs_aws_efs_utils_s3_bucket | | (optional, only needed when leveraging feature to mount using AWS EFS access points) s3 bucket to pull down pre-built aws-efs-utils RPM/DEB files, will assume package availablle through package manager if not provided | e.g. `ns2-cre-sms-binaries` |
| nfs_aws_efs_utils_s3_path | | (optional, must be passed when `nfs_aws_efs_utils_s3_bucket` is defined) path within s3 bucket to pull down pre-built aws-efs-utils RPM/DEB files | e.g. `media/efs/
| nfs_set_sssd_home | | (optional) when defined, will set the SSSD `override_homedir` for user home directories | e.g. `/nfs/home/%u@%d` |
| nfs_enable_cloudwatch_logging | `false` | flag to to enable the CloudWatch Logs feature in amazon-efs-utils | [true|false] |

Building AWS EFS Utilities
--------------------------

#### RedHat Systems

From a system of each RedHat major version needed, execute script to download, build RPM file, then upload to necessary location(s) for access within the required environment(s).

```
bash roles/nfs/files/build-aws-efs-utils-rpm.sh
```

#### Debian Systems

From a system of each Debian major version needed, execute script to download, build DEB file, then upload to necessary location(s) for access within the required environment(s).

```
bash roles/nfs/files/build-aws-efs-utils-deb.sh
```

Examples
--------

### Role Inclusion

Example inclusion of role in a playbook to mount EFS using DNS for storing user home directories to `/nfs/home`:
```
- name: Configure shared file system mounts
  include_role:
    name: nfs
  vars:
    nfs_dictionary:
      shared_home:
        path: "/nfs/home"
        src: "fs-<RANDOM-ID>.efs.us-gov-west-1.amazonaws.com"
    nfs_set_sssd_home: "/nfs/home/u%@d%"
```

Example inclusion of role in a playbook to unmount EFS for hana staging data from `/hana/staging`:
```
- name: Remove shared file system mount
  include_role:
    name: nfs
  vars:
    nfs_dictionary:
      hana_staging:
        path: "/hana/staging"
        state: "absent"
```

Example inclusion of role in a playbook to mount AWS EFS access point for `/accesspoint/example`:
```
- name: Remove shared file system mount
  include_role:
    name: nfs
  vars:
    nfs_dictionary:
      example_access_point:
        path: "/accesspoint/example"
        src: "fs-<RANDOM-ID>.efs.us-gov-west-1.amazonaws.com"
        src_root: "/path/to/folder"
        access_point_id: "fsap-<RANDOM-ID>"
        owner: "<POSIX-user>"
        group: "<POSIX-group>"
        mode: 0755
```

Example inclusion of role in a playbook to mount NFS in Azure Commercial for storing user home directories to `/nfs/home`:
```
- name: Configure shared file system mounts
  include_role:
    name: nfs
  vars:
    cloud_provider: "azure"
    nfs_dictionary:
      shared_home:
        path: "/nfs/home"
        src: "<azure-storage-acct>.file.core.windows.net"
        src_root: "/<azure-storage-acct>/<azure-storage-share>"
    nfs_set_sssd_home: "/nfs/home/u%@d%"
```

Example inclusion of role in a playbook to mount NFS in Azure Government for storing user home directories to `/nfs/home`:
```
- name: Configure shared file system mounts
  include_role:
    name: nfs
  vars:
    cloud_provider: "azure"
    nfs_dictionary:
      shared_home:
        path: "/nfs/home"
        src: "<azure-storage-acct>.file.core.usgovcloudapi.net"
        src_root: "/<azure-storage-acct>/<azure-storage-share>"
    nfs_set_sssd_home: "/nfs/home/u%@d%"
```

### Playbook Execution

There is currently the [nfs-configure.yml](https://gitlab.core.sapns2.us/golden-ami-dev/ansible-roles/blob/master/playbooks/nfs-configure.yml) playbook used to orchestrate execution of this role.

Example playbook execution to mount EFS using IP address for storing user home directories to `/nfs/home`:
```
ansible-playbook playbooks/nfs-configure.yml \
    -c local -i localhost, \
    -e nfs_set_sssd_home='/nfs/home/u%@d%' \
    -e '{"nfs_dictionary":{ "shared_home":{ "path":"/nfs/home","src":"10.XXX.XXX.XXX" }}}'
```

Example playbook execution to mount EFS using commandline-passed variables file for storing user home directories to `/nfs/home`:
```
ansible-playbook playbooks/nfs-configure.yml \
    -c local -i localhost, \
    -e @nfs_vars.yml
```
`nfs_vars.yml` contents:
```
nfs_dictionary:
  shared_home:
    path: "/nfs/home"
    src: "10.XXX.XXX.XXX"
    state: "present"

nfs_set_sssd_home: "/nfs/home/u%@d%"
```

Example playbook execution to unmount EFS for hana staging data from `/hana/staging`:
```
ansible-playbook playbooks/nfs-configure.yml \
    -c local -i localhost, \
    -e '{"nfs_dictionary":{ "hana_staging":{ "path":"/hana/staging","state":"absent" }}}'
```

Example playbook execution to mount AWS EFS access point for `/accesspoint/example`:
```
ansible-playbook playbooks/nfs-configure.yml \
    -c local -i localhost, \
    -e '{"nfs_dictionary":{ "shared_home":{ "path":"/accesspoint/example","src":"10.XXX.XXX.XXX","src_root":"/path/to/folder","owner":"<POSIX-user>","group":"<POSIX-group>","mode":"0755" }}}'
```

Example playbook execution to sync mount EFS for maintaining parity utilizing `/accesspoint/example`. This removes any preexisting EFS mounts:
```
ansible-playbook playbooks/nfs-configure.yml \
    -c local -i localhost, \
    -e nfs_sync=true \
    -e '{"nfs_dictionary":{ "shared_home":{ "path":"/accesspoint/example","src":"10.XXX.XXX.XXX","src_root":"/path/to/folder","owner":"<POSIX-user>","group":"<POSIX-group>","mode":"0755" }}}'
```

Example playbook execution to mount NFS in Azure Commercial using for storing user home directories to `/nfs/home`:
```
ansible-playbook playbooks/nfs-configure.yml \
    -c local -i localhost, \
    -e cloud_provider=azure \
    -e nfs_set_sssd_home='/nfs/home/u%@d%' \
    -e '{"nfs_dictionary":{ "shared_home":{ "path":"/nfs/home","src":"<azure-storage-acct>.file.core.windows.net","src_root":"/<azure-storage-acct>/<azure-storage-share>" }}}'
```

Example playbook execution to mount NFS in Azure Government using for storing user home directories to `/nfs/home`:
```
ansible-playbook playbooks/nfs-configure.yml \
    -c local -i localhost, \
    -e cloud_provider=azure \
    -e nfs_set_sssd_home='/nfs/home/u%@d%' \
    -e '{"nfs_dictionary":{ "shared_home":{ "path":"/nfs/home","src":"<azure-storage-acct>.file.core.usgovcloudapi.net","src_root":"/<azure-storage-acct>/<azure-storage-share>" }}}'
```

Author Information
------------------

* Devon Thyne (devon.thyne@sapns2.com)
