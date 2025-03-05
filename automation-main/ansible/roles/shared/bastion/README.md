bastion
=========

Provisions a bastion with commonly required settings and packages.

Requirements
------------

* IAM Permisions
  * ec2:DescribeInstances required for the hostname rename
* Configured repositories required for jinja2 and other package installations

Role Variables
--------------

| variable name                         | default              | description |
| ------------------------------------- | -------------------- | ------------|
| bastion_ansible_logging               | True                 | Enable ansible logging |
| bastion_ansible_logging_config_folder | /etc/ansible         | Location of the ansible logging config folder |
| bastion_ansible_logging_path          | /var/log/ansible.log | File to write ansible logs to |
| ------------------------------------- | -------------------- | ------------|
| bastion_terraform_setup               | True                 | Setup terraform on host |
| bastion_terraform_setup_version       | 0.13.5               | Version of terraform to install.  Required if not using tfenv |
| bastion_terraform_setup_tfenv         | False                | Use tfenv to manage terraform versions |
| ------------------------------------- | -------------------- | ------------|
| bastion_jinja2_update                 | False                | Update Jinja2 using pip |
| ------------------------------------- | -------------------- | ------------|
| bastion_boto_install                  | False                | Update boto using pip |
| ------------------------------------- | -------------------- | ------------|
| bastion_saml2aws_setup                | False                | Install saml2aws |
| bastion_saml2aws_version              | 2.26.2               | Version of saml2aws to install |
| ------------------------------------- | -------------------- | ------------|
| bastion_cron_jobs                     | [\<blank\>]          | List of dictionaries.  Specify custom cron jobs here.  See Defaults for examples |
| bastion_additional_packages           | [\<blank\>]          | List of additional packages to install |


Example Playbook
----------------

    - hosts: bastion
      tasks:
      - name: "Provision Bastion"
        include_role:
          name: bastion
          vars_from: business/sms.yml
        tags:
          - always

License
-------

BSD

Author Information
------------------

louis.lee@sapns2.com
