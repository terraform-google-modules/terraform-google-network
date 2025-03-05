# Latest Version
2.16-000048

# Version History
## Version 2.16-000048 (2024-10-14) (i743694)
### Enhancement - Add volume migration functionality
* Added compat-bug, ebs-clone, folder-tar, fstab-clone, directories-validate to tasks
* Added hana-start, hana-stop, sapapp-hardstart, sapapp-hardstop, sapapp-softstart, sapapp-softstop ymls to tasks
* Added hana-rebuild-profile, sapapp-rebuild-profile ymls to tasks
* Added required commands for migrating volumes to RHEL 9.2 to fstab-clone yml
* Added commands to hana-start yml needed for sapstartsrv to start Hana DB after migration
* Added commands to sapapp-hardstart yml needed for sapstartsrv to start App server after migration
* Updated sapadm uid & ps4adm uid for pce in hana-rebuild-profile & sapapp-rebuild ymls
* Added default password used for new systems to the default file
* Added wait_time parameter to creating ebs snapshot task

# Version History
## Version 2.16-000047 (2024-07-24) (i568675)
### Enhancement - Add spr_azure_customer_sftp_file_share variable to S4PCE customer inventory template
* Added new `spr_azure_customer_sftp_file_share` variable for use in SPR automation when configuring SFTP on Azure hosts
  * This was done to prevent potential conflicts with the `spr_azure_customer_file_share` variable when mounting `/usr/sap/trans` vs. `/usr/sap/interfaces`
  * The `spr-sftp.yml` SPR playbook has also been updated to reflect these changes

## Version 2.16-000046 (2024-07-11) (i743652)
* Add support for nwjava and properly classified java products in variables create task

## Version 2.9-000045 (2024-06-17) (i568675, i868402)
### Update inventory to support SFTPGo File Transfer
* Added SFTPGo File Transfer variables to inventory

## Version 2.9-000044 (2024-04-03) (i571239)
### Add cloud_provider variable to specify certain attributes in the inventory
* Add support for Azure inventory using `image` instead of `ami` within `terraform_inventory.j2`
* Add support for Azure inventory using `image_owner` instead of `ami_owner` within `terraform_inventory.j2`

## Version 2.9-000043 (2024-03-14) (c5350301)
### Allow frun products continue to exists for VMs, Disks, Hostname entries creation
* Add the support for frun when create disks is invoked.

## Version 2.9-000042 (2023-10-12) (C5356919)
### Allow ilm and bobj products continue to exists for VMs, Disks, Hostname entries creation
* Add the support for ilm and bobj when create disks is invoked. But no application provisioning possible.

## Version 2.9-000041 (2023-09-28) (C5356919)
### Decommission: Remove ilm product
* Remove support for ilm when create disks is invoked

## Version 2.9-000040 (2023-09-26) (C5356919)
### Enhancement - Updated variables create role for spr product bobj_bip, lumira
* Add support when create disks for new products like bobj_bip, lumira

## Version 2.9-000039 (2023-09-21) (c5350301)
### Enhancement - Updated variables create role for spr product access_control_s4hana
* Add support when create disks for new product access_control_s4hana

## Version 2.9-000038 (2023-06-30) (C5356919)
### Enhancement - Updated variables create role for spr product lama_ent_java, cors, plc
* Add support when create disks for new products like LaMa Ent, CORS and PLC

## Version 2.9-000037 (2023-05-30) (C5256103)
### Enhancement - Updated variables create role for spr product gbtr
* Add support when create disks for new product gbtr

## Version 2.9-000036 (2023-04-13) (C5256103)
### Enhancement - Updated variables create role for spr product gts_eds4hana
* Add support when create disks for new product gts edition for s4hana

## Version 2.9-000035 (2023-03-31) (C5353501)
### Enhancement - Add support for contentserver
* Add support for contentserver when creating terraform instance output

## Version 2.9-000034 (2022-10-24) (i868402)
### Enhancement - Change terraform instance output
* Sorts the terraform instance auto tfvars
* Minimize number of changes to output

## Version 2.9-000033 (2022-08-30) (c5335697)
### Enhancement - Updated Variables-Create for Azure sftp
* Added `spr_interfaces_efs_mount` to terraform_inventory.j2

## Version 2.9-000033 (2022-05-10) (i870146)
### Enhancement - Updated Variables-Create for hs customer0016
* Added `non_spr_productname` to terraform_inventory.j2

## Version 2.9-000032 (2022-07-08) (i868402)
### Enhancement - non_spr product
* Ignore non_spr products

## Version 2.9-000031 (2022-06-07) (i868402)
### Enhancement - sftp_interface
* Adds new product sftp_interface
* Update Variables create

## Version 2.9-000030 (2022-04-07) (i868402)
### Enhancement - Watchman improvements
* Moved Watchman related files to SPR Role
* Added predefined target sets
* Now matches on hostname instead of sids

## Version 2.9-000029 (2022-03-29) (i514383)
### Enhancement - Update Variables-Create with Phase 3 SPR Products
* Update the variables-create task file to account for Phase 3 products

## Version 2.9-000028 (2022-02-22) (i868402)
### Enhancement - New monitoring class for opentext
* Add new output for opentext
* Adds support for subnet override

## Version 2.9-000027 (2022-02-14) (i868402)
### Enhancement - New monitoring class for saprouter
* Add new output for saprouter

## Version 2.9-000026 (2022-01-26) (i868402)
### Bugfix - Adds missing product types
* Updates missing product type that will generate an error otherwise.
### Enhancement - New output s4pce_apptype
* New output to be used with telegraf, vector, and tagging

## Version 2.9-000025 (2022-01-24) (i868402)
### Bugfix - Adds new product type
* Updates missing product type that will generate an error otherwise.

## Version 2.9-000024 (2022-01-19) (i868402)
### Bugfix - Updates Template landscapes
* Updates the landscapes in the template to expected values

## Version 2.9-000023 (2022-01-18) (c5323009)
### Bugfix - Updated galaxy_info variables missing breaking molecule test runner
* Added role_name and namespace variables if missing broke molecule test runner

## Version 2.9-000022 (2021-11-04) (i868402)
### Enhancement - Adds additional instances to Customer0002
* Adds additional instances to CRE-Customer0002

## Version 2.9-000021 (2021-10-18) (i868402)
### Enhancement - Watchman
* Update to latest version of watchman
* Install bzip libraries
### Bugfix - Watchman
* Bugfix - lowercase SID
* Bugfix - ensure user group exists
* Bugfix - add ssh-keyscan

## Version 2.9-000020 (2021-09-10) (i868402)
### Enhancement - Moved inventory files
* Moved inventory files under SPR role

## Version 2.9-000019 (2021-08-16) (i868402)
### Enhancement - Deprecate CRE Support0001 PRD
* Deprecates CRE-Support0001 PRD landscape

## Version 2.9-000018 (2021-08-16) (i868402)
### Enhancement - Add Customer0003
* Add CRE-customer0003
* Add USC-Support0001
* Added `CRE` prefix to names

## Version 2.9-000017 (2021-07-27) (i868402)
### Enhancement - Normalizing more product names
* renamed content_server to contentserver
* sync up the different inventories

## Version 2.9-000016 (2021-07-26) (i868402)
### Enhancement - Update name dpagent
* update eimdp_agent to dpagent
* update dp_agent to dpagent
### Enhancement - Custom customer tags
* Add custom customer domain tag
* Add custom customer hostname tag

## Version 2.9-000015 (2021-07-01) (i868402)
### Enhancement - Update product list
* Update product list for allproducts
* Update Support0001 inventory with phase2 items

## Version 2.9-000014 (2021-06-23) (i868402)
### Enhancement - Update instances for support0001
* Update instance list for phase2 of support0001

## Version 2.9-000013 (2021-05-05) (c5323009)
### Bugfix - Updated ns2-scp-dev.sapns2.us domain to gitlab.core.sapns2.us
* Updated issue_tracker_url variable using old gitlab domain to new core services domain

## Version 2.9-000012 (2021-05-03) (i868402)
### Enhancement - Update inventory list
* Update Port list for audit requirements

## Version 2.9-000011 (2021-04-01) (i868402)
### Enhancement - Update inventory list
* Update management inventory list

## Version 2.9-000010 (2021-03-15) (i868402)
### Enhancement - Deprecate Support0001 QA Landscape
* Deprecates Support0001 QA Landscape
* New "allproducts' template for use with future customers
* Adds default ports to all apps for privatelinks.

## Version 2.9-000009 (2021-03-05) (i868402)
### Enhancement - Update Variables Create
* Update Cloudwatch dynamic variables

## Version 2.9-000008 (2021-03-04) (i868402)
### Enhancement - Allow watchman to monitor/replicate multiple folders
* Split out watchman configuration from watchman install
* Allow watchman to target different folders
* Create multiple watchlists and triggers.
### Enhancement - Update iptables preset selection
* Fix incorrect app classification

## Version 2.9-000007 (2021-02-26) (i868402)
### Enhancement - Dynamic Variable Creation
* Dynamically create variables for various other roles.

## Version 2.9-000006 (2021-02-23) (i868402)
### Enhancement - Endpoint Ports
* Add support for Endpoint Creation (terraform template)

## Version 2.9-000005 (2021-02-19) (i868402)
### Enhancement - Watchman Service and Logging
* Setup Watchman as a service
* Setup logrotate for watchman

## Version 2.9-000004 (2021-02-12) (i868402)
### Enhancement - Watchman Replication
* new tasks for sshkey setup
* new tasks for watchman setup and replication

## Version 2.9-000003 (2021-02-03) (i868402)
### Bugfix - Wrong SID
* Wrong SIDs listed in Support0001

## Version 2.9-000002 (2021-01-27) (i868402)
### Bugfix - Wrong Product Groups
* Wrong Product Groups listed in Support0001

## Version 2.9-000001 (2021-01-22) (i868402)
### Initial version established with the following features
* Generates Terraform instance list
