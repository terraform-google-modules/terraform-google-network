tag-management
=====================

This role is used to configure Tags on AWS Instances and their associated disks.
It handles automatic tagging of values based on data collected from the instances.
And also allows tags to be defined at runtime.
When run without any paramters, only automatic values are set, and all existing
non-auto generated values are preserved.
When run with tag variables defined, any defined variables will be set if the existing
tag value is blank, or forced if the aws_tag_force_overwrite variable is set to true.

Requirements
------------

* Anisble 2.8+
* Boto
* Boto3

Role Variables
--------------

* aws_tag_delegate_local: Defaults to `true`. Flag to determine whether to query tag information from each remote host, or only query tag information from the ansible controller
* aws_ip_address: `public` or `private` as strings to assist Ansible during fact gathering
* aws_region: AWS region where the ansible is being executed against
* aws_tag_business: Defaults to 'build'. Line of business which the resource is related to e.g., labs,build,ibp,scp,sac,hcm
* aws_tag_build_user: User who is responsible for creating the resource
* aws_tag_customer: (shc and ibp only) Name of the customer
* aws_tag_description: Friendly description of the purpose of the system
* aws_tag_db_type: (shc and ibp only) Database type e.g., oracle, sybase, hana
* aws_tag_domain: Active Directory domain the system has been joined to
* aws_tag_environment: Related management plane e.g. staging, production, management
* aws_tag_generated_by: The technology that was used to create the resource once e.g., ansible or terraform
* aws_tag_managed_by: The technology that is used to continuously maintain the resource e.g., ansible or terraform
* aws_tag_operating_system: Operating system major/minor release e.g., Red Hat Enterprise Linux Server release 7.6 (Maipo)
* aws_tag_patch_group: Group of systems that are related to
* aws_tag_provision_date: Date that the system was provisioned
* aws_tag_product_name: Application name e.g., Hana Cockpit SPS04
* aws_tag_db_hostname: (shc and ibp only) Database Hostname
* aws_tag_db_sid: (shc and ibp only) Database SID
* aws_tag_tenant_sid: (shc and ibp only) Tenant SID
* aws_tag_force_sap: Force SAP tags regardless of AMI name
* aws_tag_force_overwrite: Force an overwrite of user defined tags.
* aws_tag_null_context_control: Assumes that tags will be owned by Terraform Null Context and will only attempt to control tags that are outside of it's control.

Dependencies
------------

N/A

Additional Information
----------------------

Ansible Tagging Standards:
https://gitlab.core.sapns2.us/golden-ami-dev/ansible-roles/blob/master/CONTRIBUTING-ANSIBLE.md#general-tags


Example Playbooks
----------------

```
- hosts: all
  gather_facts: yes
  roles:
    - ../roles/tag-management

```


License
-------

BSD

Author Information
------------------

Will Rivera (c5290493) william.rivera@sapns2.com
