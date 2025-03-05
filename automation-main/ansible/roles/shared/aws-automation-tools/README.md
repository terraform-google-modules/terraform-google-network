aws-automation-tools
====================

A collection of management tools to use with an AWS environemnt.

A service account with an appropriate level of access will be required.
Service Account credentials are expected to be integrated through a seperate vault role

Requirements
------------
* Ansible v2.9+
* AWS Service Account
* Boto
* Boto3

Role Variables
--------------
| Variable Name                       | type    | default value | description |
| -------------                       | ----    | ------------- | ----------- |
| aws_access_key                      | string  |               | key retrieved from Vault |
| aws_autoamation_directory_create    | bool    | no            | for future functionality |
| aws_automation_cron_setup           | bool    | no            | trigger cronbox provisioning |
| aws_automation_instance_cleanup     | bool    | no            | trigger the instance cleanup task |
| aws_automation_instance_rename      | bool    | no            | trigger the instance renaming task |
| aws_automation_instance_shutdown    | bool    | no            | trigger instance shutdown task |
| aws_automation_vpc_create           | bool    | no            | for future functionality |
| aws_region                          | string  | us-gov-west-1 | aws region |
| aws_secret_key                      | string  |               | key retrieved from Vault |

### Instance Cleanup Variables
These variables are specific to the Instance Cleanup Task

| Variable Name                       | type    | default value | description |
| -------------                       | ----    | ------------- | ----------- |
| search_date                         | string  | *calculated*  | use in instance cleanup to determine oldest instance |

### Create VPC Variables
These variables are specific to the Instance Cleanup Task

| Variable Name                       | type    | default value              | description |
| ----------------------------------- | ------- | -------------------------- | ----------- |
| vpc_vars                            | string  | create-vpc-vars.yml        | The vars file to be used for VPC creation |
| vpc_name                            | string  | example                    | Name tag of the VPC to create |
| vpc_octet                           | string  | 10.20                      | First two octets of a /16 CIDR block for the new VPC |
| vpc_subnets                         | dict    | *see create-vpc-vars file* | Dictionary of Subnets to create within the VPC |
| vpc_security_groups                 | dict    | *see create-vpc-vars file* | Dictionary of Security groups to create within the VPC |

Dependencies
------------

N/A

Example
-------
This is an example of triggering an instance cleanup

```
    - hosts: localhost
      connection: local
      vars:
        aws_automation_instance_cleanup: yes
      roles:
      - aws-automation-tools
```

License
-------

BSD

Author Information
------------------

Louis.Lee@SAPNS2.com
Mo.Musau@SAPNS2.com
