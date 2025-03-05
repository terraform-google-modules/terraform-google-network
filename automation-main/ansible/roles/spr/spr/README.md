SPR (SAP Product Repository)
============================

Ansible role for managing the SAP Products Repository.

Requirements
------------

### General Requirements

* Ansible 2.9+
* Boto
* Boto3
* Botocore
* EFS synchronized with SPR S3

### AWS Requirements

* aws cli  

### Azure Requirements

* azcopy
* az cli

Role Variables
--------------

| Name                      | Type     | Description |
| ------------------------- | -------- | ----------- |
| spr_tar_extract_overwrite | default  | Overwrite control for the tar extraction task |
| spr_tar_extract_async     | default  | Synchronous or Asynchronous method for tar extraction
| ------------------------- | -------- | ----------- |
| efs_staging_ip            | groupvar | IP Address of the Staging EFS |
| spr_file_swpm_sapinst     | groupvar | Executable location of the SWPM sapinst binary |
| spr_saphostagent_source   | groupvar | Source folder of saphostagent |
| spr_domain                | groupvar | FQDN of the target host |
| spr_application_source    | groupvar | Source folder of the application TAR image |
| spr_db_source             | groupvar | Source folder of the database TAR image |
| spr_product               | groupvar | Used to dynamically group the target host into product type |
| spr_landscape             | groupvar | Used to dynamically group the target host into landscape type |
| spr_file_ini_params       | groupvar | Parameter file used to configure the application |
| spr_file_instkey          | groupvar | PKey file used in application provisioning |
| spr_hostname              | hostvar  | Hostname of the target host |
| spr_sid                   | hostvar  | SAP ID of the target host |
| spr_storage_account_name  | hostvar  | Name of the Azure storage account to push incremental hana backups |

Dependencies
------------

N/A

Example Playbook
----------------
```
- hosts: all
  gather_facts: true

  tasks:
  - name: "Call SPR Role"
    include_role:
      name: spr
```

FAQ and Debugging
-----------------

1. `No Profile used.\n=>sapparam: SAPSYSTEMNAME neither in Profile nor in Commandline`

_RESOLUTION_: On the application server, go to the directory `/sapmnt/G00/profile` and note the names of the profile files. Ensure that the value of `instance_list` in the [defaults/main.yml](defaults/main.yml) file accurately reflects the profile file names.

2. `java.lang.NoClassDefFoundError` or `java.lang.ClassNotFoundException`

_RESOLUTION_: The SWPM version is not compatible with the product. SWPM 1.0 should be used for all JAVA stack products and SAP SCM Optimizer. SWMP 2.0 should be used for all ABAP stack products.

3. `Connect failed: com.sap.db.jdbc.exceptions.JDBCDriverException: SAP DBTech JDBC: Cannot connect to jdbc:sap://hdb-g01:30013 [SAP DBTech JDBC: [2]: general error: database 'G01' not connected].`

_RESOLUTION_: This error indicates that the application cannot connect to the database. Validate that the database is running and that it was renamed correctly. Validate that the firewall is down on both the application and the database server. Validate that the hostfile correctly reflects the customer hostname and fqdn. Validate that the database license isn't expired.

License
-------

BSD

Author Information
------------------

louis.lee@sapns2.com

katja.cresanti@sapns2.com

sean-thomas.saloom@sapns2.com
