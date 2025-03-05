domain-join
===========

Joins a Red Hat or Ubuntu host to an Active Directory Domain

Supported Platforms
------------
Note: This role has only been validated against the AWS cloud environment.

* RHEL
  * 8.2/8.4/8.6/8.8
  * 7.6/7.7/7.9
* Ubuntu
  * 16.04
  * 18.04

Requirements
------------
* Red Hat or Ubuntu host
* Valid source to install the following Red Hat packages. These are typically found in the base Red Hat repository.
  * realmd
  * oddjob
  * oddjob-mkhomedir
  * sssd
  * samba-common-tools
  * nfs-utils (if using `domain_shared_filesystem`)
* Valid source to install the following Ubuntu packages.
  * realmd
  * oddjob
  * oddjob-mkhomedir
  * sssd
  * samba-common-bin
  * krb5-config
  * packagekit
  * nfs-common (if using `domain_shared_filesystem`)

Role Variables
--------------
* `domain_user`: (required) The AD account with domain join privilege
* `domain_password`: (required) The credentials for the AD Account
* `domain_sudo_group`: (required) The Security group in AD that will be given Sudo rights
* `domain_require_sudo_password`: (optional) If true, sets behavior to require users to authenticate when invoking sudo
* `domain_fqdn`: (required) The fully qualified domain name
* `domain_dns1`: (required) IP address of the primary AD DNS server
* `domain_dns2`: (required) IP address of the secondary AD DNS server
* `domain_set_dns`: (Boolean) Defaults to false. Sets whether resolv.conf should be updated
* `domain_force_join`: (Boolean) Defaults to false. When true, unjoins any domain first
* `domain_set_hostname`: (Boolean) Defaults to false. When true, sets system hostname to last 15 characters of instance id. Ubuntu 16 host hostnames are always set.
* `domain_user_home_path`: Default `/home`, Folder to store domain user home directories
* `domain_full_home_directories`: (Boolean) Default false, Set to true to set domain user home directory paths to `/user@domain` as opposed to default of `/user`
* `domain_chroot_home_directories`: (Boolean) Default false, Set to true to use override_homedir without %u option
* `domain_reset_cache`: (Boolean) Flag to set to ensure that the SSSD cache is emptied so that any new RBAC changes can get picked up immediately
* `domain_log_level`: (Optional) SSSD log level (recommended: 3)
* `custom_default_user`: (Optional) Specify a custom default user to preserve remote access to the system for during the domain-join process
* `domain_krb5_store_password_if_offline`: (Optional) Value to set the krb5_store_password_if_offline flag in the sssd config file; Valid options are 'True' and 'False'
* `sssd_ignore_group_members`: (Optional) If true, set ignore_group_members = True
* `sssd_ldap_group_nesting_level`: (Optional) By default, use sssd default ldap_group_nesting_level of 2, otherwise use defined value
* `remove_invalid_config_options`: (Optional) If true, remove invalid config options
* `realm_no_log`: (Optional) If true, then show results of realm join command

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```
    - hosts: servers
    - tasks:
      - name: Domain Join
        include_role:
          name: domain-join
        vars:
          domain_password: ''
          domain_user: ''
          domain_sudo_group: ''
          domain_fqdn: ''
          domain_dns1: ''
          domain_dns2: ''
          domain_force_join: false
```

Author Information
------------------
* louis.lee@sapns2.com
* matthew.bittner@sapns2.com
* bert.regeer@sapns2.com
* devon.thyne@sapns2.com
