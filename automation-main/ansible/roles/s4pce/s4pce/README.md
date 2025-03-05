SPR (SAP Product Repository)
============================

Ansible role for managing the S4/Hana Private Cloud Edition

Requirements
------------

* EFS synchronized with SPR S3
* AWS CLI
* Azure CLI
* Boto
* Boto3
* Botocore

Role Variables
--------------

| Name                                    | Type     | Description |
| --------------------------------------- | -------- | ----------- |
| s4pce_terraform_instance_list           | default  | True to generate a terraform instance list |
| s4pce_terraform_instance_list_location  | default  | Location of where to write the terraform instance list |
| cloud_provider                          | default  | Targets cloud provisioner to define specific attributes (i.e. "ami" or "image") |

Dependencies
------------

N/A

Example Playbook
----------------

```
- hosts: all
  gather_facts: false

  tasks:
  - name: "Call S4/Hana PCE Role"
    include_role:
      name: s4pce
```

Example Playbook with Azure Provisioner
----------------------------------------------
```
- hosts: all
  gather_facts: false

  tasks:
  - name: "Call S4/Hana PCE Role with Azure Provisioner"
    include_role:
      name: s4pce
    vars:
    - cloud_provider: "azure"
```

Example for variable ProductComponent creation for tagging and monitoring.
--------------------------------------------------------------------------

Valid outputs of s4pce_productcomponent are:

-  `sap_default`
-  `sap_application_java`
-  `sap_application_abap`
-  `sap_application_bobj`
-  `sap_application_cloudconnector`
-  `sap_application_data_services`
-  `sap_hanacockpit`
-  `sap_application_hana_ee`
-  `sap_application_information_steward`
-  `sap_application_lumira`
-  `sap_application_webdispatcher`
-  `sap_database_hana`

Example execution:

    `ansible-playbook playbook.name -i defaults -i path/to/inventory/folder/`

```
- hosts: all
  gather_facts: false
  become: false
  tasks:
  # This will output the following variables: s4pce_productcomponent
  - name: "Generate role dynamic variables"
    include_role:
      name: s4pce
      tasks_from: general/variables-create.yml
    vars:
      s4pce_variables_create_nodetype: "{{ spr_nodetype }}"
      s4pce_variables_create_productname: "{{ spr_productname }}"

  - name: "Display ProductComponent Classification for monitoring"
    debug:
      var: s4pce_productcomponent
```



License
-------

BSD

Author Information
------------------

* Louis Lee (louis.lee@sapns2.com)
* Dexter Le (dexter.le@sap.com)
