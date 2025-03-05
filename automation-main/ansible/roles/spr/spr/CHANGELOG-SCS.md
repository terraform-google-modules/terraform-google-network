## 2025-03-03 | i868402
### ['enhancement', 's4pce', 'terraform'] | [MR 146](https://gitlab.core.sapns2.us/scs/ste/automation/-/merge_requests/146)
* [Jira Link]()  No Jira Link <!-- ACTION: Add Jira link-->
* Replace local-exec curl with data.http module, removes requirements on curl packages.
* Update Provider requirements
* Default US Region specific customization to false. Marked for relocation later.
* Added hidden advanced switch to turn off customer gateway deployment. This a production thing and just adds time to our test deployments. There's nothing we can use those for.

## 2025-02-24 | c5353501
### ['ansible', 'enhancement', 'spr'] | [MR 119](https://gitlab.core.sapns2.us/scs/ste/automation/-/merge_requests/119)
* [Jira Link](https://jira.tools.sap/browse/SCSTE-471)
* Update of spr role defaults variables to point to new `solman` release

## 2025-02-21 | i744710
### ['ansible', 'enhancement', 'spr'] | [MR 127](https://gitlab.core.sapns2.us/scs/ste/automation/-/merge_requests/127)
* [Jira Link](https://jira.tools.sap/browse/SCSTE-2588)
* Upgrade spr role defaults to point to new `access control` release

## 2025-02-20 | i743652
### ['ansible', 'bug', 'spr'] | [MR 143](https://gitlab.core.sapns2.us/scs/ste/automation/-/merge_requests/143)
* [Jira Link](https://jira.tools.sap/browse/SCSTE-3657)
* Fix bug that fails to start `hana` when no processes are returned with GetProcessList

## 2024-01-31 i751125
* Updated default values in defaults/main.yml to point to new FRUN Folder

## 2024-01-28 i744710
* Updated default values in defaults/main.yml to point to new bwnetweaver folder version 31
* Restructure product folder path for bwnetweaver

## 2024-01-21 i744710
* Updated default values in defaults/main.yml to point to new SSO Folder

## 2025-01-10 i577821
* Updates to watchman-trigger-action templates in spr/templates/general

## 2024-12-19 i751125
* Update default values in defaults/main.yml to new data provisioning agent (dpagent) release
* Also aligned version field to have one level only. Hence, dpagent list item in `spr_application_source_list` is changed to include remaining subdirectory structure

## 2024-12-26 i751125
* Update default values in defaults/main.yml to include new cpids agent release

## 2024-12-23 i743652
* Fix RHEL 8.8 spr HANA provisioning to use the correct version of libstdc++

## 2024-12-13 i751125
* Update default values in defaults/main.yml to new cloudconnector release

## 2024-12-11 i743652
* Fix - support license expiration set as `unlimited`
* Fix `hana-start` task, checking the status immediately after a HANA restart causes false negatives

## 2024-11-19 i743147/i743652
* Updated default values in defaults/main.yml to point to new `ADS` tar
* Remove nested directory from `ADS` product version variable
* Update `rebuild` playbook to include validation host OS users
* Output HANA license expiration date in fail msg

## 2024-11-20 i744710
* Update default values in defaults/main.yml to new SAP_CAR release

## 2024-12-09 i743652
* Add playbook and supporting role tasks to validate SPR upgrade development hosts. The playbook validates
  * HANA DB License expiration and
  * check that SPR Product artifacts are uploaded to S3

## 2024-12-02 i744710
* Updated default values for ehp8_erp

## 2024-11-20 i744710/i743652
* Add support for restrictive SPR product folder/file permissions (e.g. 0700/0600) during SPR provisioning

## 2024-11-12 i744710
* Updated default values in defaults/main.yml to point to new s4hana_addons release
* Create unique path for s4hana_addons product

## 2024-11-12 i743147
* Update default values in defaults/main.yml to point to the newest SLT tars

## 2024-11-05 i743147
* Updated default values for fiori_fes 2024-Q4 release cycle

## 2024-10-23 i743147
* Use new changelog format
* Updated default values for BW4HANA 2024-Q4 release cycle

## Version 2.16-000357 (2024-11-01) (i743147)
### Enhancement - SPR Upgrade 2024Q4 SAP Host Agent
* Upgrade host agent default minimum version folders

## Version 2.16-000356 (2024-11-01) (i743147)
### Enhancement - SPR Upgrades Solution Manager
* Updated default values in defaults/main.yml to point to new SOLMAN TARs

## Version 2.16-000355 (2024-10-28) (i744710)
### Enhancement - SPR Upgrade SAP_Global_Batch_Tracebility
* Updated default values in defaults/main.yml to point to new `gbtr` upgrade path

## Version 2.16-000354 (2023-10-18) (i743147)
### Enhancement - SPR Update SAP CRM 7.0 EHP4 release cycle
* update default values in defaults/main.yml to point to new tars in CRM Tars
  `crm:
    version: EHP4_FOR_SAP_CRM_7.0_SPS22`

## Version 2.16-000353 (2023-10-09) (i743147)
### Enhancement - SPR 2024Q42 Upgrade SAP ATTP SPS04 Upgrades
* Updated default values in defaults/main.yml for SAP ATTP

## Version 2.16-000452 (2024-10-16) (i743147)
### Enhancement - SPR Upgrade 2024-Q3 release cycle for s4hana_foundation
* Updated default values in defaults/main.yml to point to new S/4HANA Foundation 2023 Tars images

## Version 2.16-000351 (2024-10-02) (i743147)
### Enhancement - SPR Upgrade gts
* Update default values in defaults/main.yml to point to new tars in GTS Tars

## Version 2.16-000350 (2024-08-30) (I744710)
### Enhancement - SPR Upgrade 2024-Q3 release cycle - SAP Router
* Automatically retrieve filename from `router` media directory
* Update spr role default variables to the new `router` and folder structure

# Version 2.16-000349 (2024-09-20) (i743147)
### Enhancement - Update bobj provisioning task to install packages based on OS
* Removed rhel 8 prerequiste package from bobj-bip-install.yml

## Version 2.16-000348 (2024-08-30) (I744710)
### Enhancement - SPR Upgrade 2024-Q3 release cycle for GTS ED for S4HANA
* Updated default values in defaults/main.yml point to new gts_ed4hana

## Version 2.16-000347 (2024-08-30) (i743147)
### Enhancement - SPR Upgrade 2024-Q3 release cycle for Access Control and SAP Host Agent
* Updated default values in defaults/main.yml point to new access control tar images
* Upgrade host agent default minimum version folders

## Version 2.16-000346 (2024-08-22) (i743147)
### Enhancement - SPR Upgrades -  FIORI CARAB 2024-Q3  release cycle
* Updated default values in defaults/main.yml to point to new FIORI CARAB software

# Version 2.16-000345 (2024-08-29) (i743652)
### Enhancement - Define default SWPM for optimizer
* Define default swpm1 version for optimizer when spr_nlb_port is defined

# Version 2.16-000344 (2024-08-27) (i743652)
### Enhancement - Define default SWPM for contentserver
* Use swpm1 version for contentserver when spr_nlb_port is defined

# Version 2.16-000343 (2024-08-27) (i743652)
### BugFix - Revert dataservices hana version to fix hana rename bug
* Fix default values in defaults/main.yml for data_services/bobj_bip db versions

## Version 2.16-000342 (2024-07-24) (i568675)
### Enhancement - Add spr_azure_customer_sftp_file_share variable to SPR defaults
* Added new `spr_azure_customer_sftp_file_share` variable for use in SPR automation when configuring SFTP on Azure hosts
  * This was done to prevent potential conflicts with the `spr_azure_customer_file_share` variable when mounting `/usr/sap/trans` vs. `/usr/sap/interfaces`
  * The `spr-sftp.yml` SPR playbook has also been updated to reflect these changes

# Version 2.16-000341 (2024-08-20) (i743147)
### Enhancement - SPR Upgrade 2024-Q3 release cycle for hana platform_edition
* Updated default values in defaults/main.yml to point to SAP HANA Platform Edition 2.0 SP07 Rev.79 Tar images

## Version 2.16-000340 (2024-08-15) (i744710)
### Enhancement - SPR Upgrades po
* Updated default values in defaults/main.yml to point to new po tar images

## Version 2.16-000339 (2023-11-30) (I743652)
### Enhancement - add access control s4hana to all hostfiles
* Add access_control_s4hana to hostfile templates

## Version 2.16-000338 (2024-08-08) (i743147)
### Enhancement - SPR Upgrades Bwnetweaver
* Updated default values in defaults/main.yml to point to new bwnetweaver tar images

# Version 2.16-000337 (2024-08-05) (i802616)
### Enhancement - SPR Upgrade 2024-Q3 release cycle
* Updated default values in defaults/main.yml for webdispatcher 7.93 PL100

## Version 2.16-000336 (2024-07-29) (i802616)
### Enhancement - SPR Upgrade PO
* Update default values in defaults/main.yml to point to updated po

## Version 2.16-000335 (2024-12-07) (i744710)
### New Products - SAP GTS
* Updated default values in defaults/main.yml to point to new gts

## Version 2.16-000334 (2024-07-18) (i743147)
### Enhancement - SPR Upgrade DATA_SERVICES_AGENT
* Updated default values in defaults/main.yml to point to new DATA SERVICES AGENT Vesrion.

## Version 2.16-000333 (2024-12-07) (i743147)
### New Products - SAP BOBJ BIP and SAP Lumira
* Updated default values in defaults/main.yml to point to new bip and lumira

## Version 2.16-000332 (2024-07-11) (i744710)
### Enhancement - SPR Upgrades SAC AGENT to new version: 409
* Updated default values in defaults/main.yml to point to upgraded version:
    * SAP_ANALYTICS_CLOUD_AGENT_1.0/SAP_ANALYTICS_CLOUD_AGENT_1.0_PL409

# Version 2.16-000331 (2024-07-12) (i743147)
### Enhancement - SPR Upgrade 2024-02 release cycle for hana platform_edition
* Updated default values in defaults/main.yml to point to SAP HANA Platform Edition 2.0 SP07 Rev.78 Tar images

## Version 2.16-000330 (2024-06-06) (i743147)
### Enhancement - SPR Upgrade BW4HANA 2024Q2 release cycle
* Updated default values in defaults/main.yml to point to new bw4hana_addons tar images

## Version 2.16-000329 (2024-05-23) (i743147)
### Enhancement - SPR Upgrades SAP LAMA 3.0 ENT SP31
* Updated default values in defaults/main.yml to point to upgraded version:
    * SAP_LANDSCAPE_MGT_ENT_JAVA_SP31

## Version 2.16-000328 (2024-06-25) (i743147)
### Enhancement - Refresh SWPM to point to new  versions
* spr_products.swpm2_0 - SWPM20SP18
* spr_products.swpm1_0 - SWPM10SP41

## Version 2.16-000327 (2024-06-17) (i743147)
### Enhancement - SAP_ERP_EPH8 - 2024Q2 release cycle
* Updated default values in defaults/main.yml for SAP ERP_EHP8

# Version 2.16-000326 (2024-04-25)  (i000173)
### Enhancement - SPR Upgrade SCM Optimizer
* Updated default values in defaults/main.yml to point to Optimizer path
* Changed the approach for Optimizer from Rename to new install method
* Updated the optimizer-install provisioning playbook for above approach
* Path for product updated for SPR product artifacts

## Version 2.16-000325 (2024-01-04) (I000173)
### Enhancement - S4HANA Addon Upgrade - 2024Q2 release cycle
* Updated default values in defaults/main.yml to point to new S4HANA-Addon tar images

## Version 2.16-000324 (2024-05-17) (i743147)
### Enhancement - SPR 2024Q2 Upgrade content server
* Updated spr/defaults/main.yml pointing to latest version

## Version 2.16-000323 (2024-05-15) (I802616)
### Enhancement - SPR 2024-Q2 Upgrade CloudConnector
* Updated default values in defaults/main.yml for CloudConnector

## Version 2.16-000322 (2024-05-17) (i743652)
### Enhancement - SPR Upgrade 2024Q2 Single Sign-On
* Update default values in defaults/main.yml to point to the newest sso tars

## Version 2.16-000321 (2024-01-04) (C5356919)
### Enhancement - Updated below for fixing AAS install for Java Products
* Updated spr-roles/spr/tasks/provisioning/aas-install.yml to create links for C++ Library and Update Parameter for profile directory
* Updated spr-roles/spr/tasks/provisioning/app-java-install.yml to replace spr_product with spr_app_install_product
* Updated default values in defaults/main.yml for product 'portal'

## Version 2.16-000320 (2024-05-08) (c5353501)
### Enhancement - SPR Upgrade 202402 SAP Host Agent
* Upgrade host agent default minimum version folders

## Version 2.16-000319 (2023-12-01) (c5353501)
### Enhancement - SPR Upgrades FRUN 2024-02 release cycle
* Updated default values in defaults/main.yml to point to new Frun tar images

## Version 2.16-000318 (2024-04-29) (i743147)
### Enhancement - SPR Upgrade SLT 2024-Q2
* Update default values in defaults/main.yml to point to the newest SLT tars

## Version 2.16-000317 (2024-04-22) (c5353501)
### Enhancement - SPR Upgrade 2024-Q2 bw4hana_bpc
* Updated default values in defaults/main.yml to point to new BW4HANA BPC Tars

## Version 2.16-000316 (2024-04-17) (c5353501)
### Enhancement - SPR 2024Q2 Upgrade bw4hana
* Update default values in defaults/main.yml to point to new tars in BW4HANA_ADDONS Tars

## Version 2.9-000315 (2024-03-14) (c5353501)
### Enhancement - SPR Upgrade 2024-Q1 release cycle for s4hana
* Updated default values in defaults/main.yml to point to new S/4HANA 2023 Tars images

# Version 2.9-000314 (2024-04-04) (c5353501)
### Enhancement - SPR 202310 Upgrade SAP Webdispatcher
* Updated main.yml - upgraded version path for product webdispatcher:
    "SAP_WEB_DISPATCHER_7.93_PL81"

## Version 2.9.000313 (2024-03-11) (c5353501)
### Enhancement - SPR Upgrade 2024-02 Corporate Serialization
* Updated default values in defaults/main.yml to point to new cors Tars

## Version 2.9-000312 (2024-04-08) (i743694)
### Enhancement - added task to sac-agent-install-yml
* used ansible-built-in module to assign execute permission to .exe in SAPCAR folder within staging directory

## Version 2.9-000311 (2024-03-27) (C5353501)
### Enhancement - SPR Upgrade s4hana_addons for 2024-Q1 release cycle
* Updated default values in defaults/main.yml to point to new S4HANA Addons tar images

## Version 2.9-000310 (2024-02-07) (i000173)
### Enhancement - SPR 202402 Upgrade
* Updated main.yml - upgraded version path for product car:
    version: SAP_CARAB_5.0_SPS05_JAN2024

## Version 2.9-000309 (2023-12-20) (c5356919)
### Enhancement - SPR Update BOBJ_BIP for 2024-02 release cycle
* update default values in defaults/main.yml for BOBJ_BIP and LUMIRA
* update spr/defaults/spr_defaults.yml for productname case conversion to lower
* update temporary product license keys for data_services and information_stewards

## Version 2.9-000308 (2024-02-27) (c5353501)
### Enhancement - Refresh SWPM to point to new  versions
* spr_products.swpm2_0 - SWPM20SP17
* spr_products.swpm1_0 - SWPM10SP40

## Version 2.9-000307 (2024-02-26) (c5353501)
### Enhancement - SPR Upgrade 202402 SAP Host Agent
* Upgrade host agent default minimum version folders

## Version 2.9-000306 (2024-02-07) (c5353501)
### Enhancement - SPR 202310 Upgrade SAP Webdispatcher
* Updated main.yml - upgraded version path for product webdispatcher:
    "SAP_WEB_DISPATCHER_7.93_PL71"

## Version 2.9-000305 (2024-01-23) (C5353501)
### Enhancement - SPR Upgrade S4HANA livecache 2023 FPS00 2024-02 release cycle
* Updated default values in defaults/main.yml to point to new s4hana livecache Tar images from 2022 FPS02 -> 2023 FPS00

## Version 2.9-000304 (2024-02-05) (c5353501)
### Enhancement - SPR 202402 Upgrade bw4hana_addon
* Update default values in defaults/main.yml to point to new tars in BW4HANA_ADDONS Tars

## Version 2.9-000303 (2024-02-05) (c5356919)
### Enhancement - SPR Upgrades -  HANACOCKPIT 2024-02  release cycle
* Updated default values in defaults/main.yml to point to new HANACOCKPIT software
* Update hanacockpit-install.yml with fixes from hana-install.yml

## Version 2.9.000302 (2024-02-06) (c5256103)
### Enhancement - SPR Upgrade 2024-02 ads
* Updated default values in defaults/main.yml to point to new BW4HANA BPC Tars

## Version 2.9-000301 (2024-01-10) (c5353501)
### Enhancement - SPR Upgrade SLT 2024-02
* Update default values in defaults/main.yml to point to the newest SLT tars

## Version 2.9-000300 (2024-02-02) (C5256103)
### Enhancement - SPR Upgrades -  Renew DS and IS product keys
* Renew data_services and information_stewards product license keys and updated defaults/main.yml

## Version 2.9-000299 (2024-01-16) (c5356919)
### Enhancement - SPR Upgrades -  FIORI CARAB 2024-02  release cycle
* Updated default values in defaults/main.yml to point to new FIORI CARAB software

## Version 2.9-000298 (2024-01-7) (c5353501)
### Enhancement - SPR Upgrades SAP LAMA 3.0 ENT SP29
* Updated default values in defaults/main.yml to point to upgraded version

# Version 2.9-000297 (2024-1-02) (c5356919)
### Enhancement - SPR Upgrade 2024-02 release cycle for hana platform_edition
* Updated default values in defaults/main.yml to point to SAP HANA Platform Edition 2.0 SP07 Rev.73 Tar images

## Version 2.9-000296 (2024-01-03) (I868402)
### Bugfix - unsafe conditional
* Fix conditional that breaks in version(ansible-core 2.16.2 / jinja 3.1.2 python 3.12.1)
* Bug in assert statement in tasks/general/mount-check

## Version 2.9-000295 (2023-12-05) (c5353501)
### Enhancement - SPR Upgrades -  Portal 2024-02  release cycle
* Updated default values in defaults/main.yml to point to new Portal software

## Version 2.9-000294 (2023-12-26) (c5353501)
### Enhancement - SPR Upgrades Bwnetweaver Upgrades 2024-02
* Updated default values in defaults/main.yml to point to new bwnetweaver tar images

## Version 2.9-000293 (2023-12-19) (C5356919)
### Enhancement - Updated below for fixing backup_catalogpath parameter  and landscapeVariables.properties during HANA provisioning
* Updated spr-roles/spr/tasks/provisioning/hana-install.yml to remove the basepath_catalogbackup from HANA TENANT DB parameters
* Updated spr-roles/spr/tasks/provisioning/solman-install.yml to remove the basepath_catalogbackup from HANA TENANT DB parameters
* Updated spr-roles/spr/tasks/provisioning/solman-install.yml to update landscapeVariables.properties for bug in hdb-rename per SAP Note 3190917
* Updated spr-roles/spr/tasks/provisioning/hana-install.yml to change the hana_ee not to use XSA rename process to align with the product direction change.

# Version 2.9-000292 (2023-12-07) (c5256103)
### Enhancement - SPR Upgrade 2024-02 release cycle for hana_ee
* Updated default values in defaults/main.yml to point to SAP HANA Enterprise Edition 2.0 SP07 Rev.73 Tar images

## Version 2.9.000291 (2023-12-18) (c5353501)
### Enhancement - SPR Upgrade 2024-02 bw4hana_bpc
* Updated default values in defaults/main.yml to point to new BW4HANA BPC Tars

## Version 2.9-000290 (2023-12-05) (c5299015)
### Enhancement - SPR Update SAP CRM 7.0 EHP4 release cycle
* update default values in defaults/main.yml for product 'crm'
  `crm:
    version: EHP4_FOR_SAP_CRM_7.0_SPS21`

## Version 2.9-000289 (2023-12-12) (c5353501)
### Enhancement - SPR Upgrade gts
* Update default values in defaults/main.yml to point to new tars in GTS Tars

## Version 2.9-000288 (2023-12-14) (c5356919)
### Fix Automation for HCP Provisioning due to DNS issues
* Updated spr/tasks/provisioning/hanacockpit-install.yml to avoid DNS issues while provisioning

## Version 2.9-000287 (2023-12-08) (c5353501)
### Enhancement - SPR Upgrade BW4HANA for 2024-02 release cycle
* Updated default values in defaults/main.yml pointing to new bw4hana Tars

# Version 2.9-000286 (2023-12-05) (C5256103)
### Enhancement - SPR Upgrade AP_GTS_ED_FOR_SAP_HANA_2023_SPS01 for 2024-02 release cycle
* Updated default values in defaults/main.yml to point to new SAP_GTS_ED_FOR_SAP_HANA_2023_SPS0 tar images

## Version 2.9-000285 (2023-11-26) (C5353501)
### Enhancement - SPR 202402 Upgrade SAP ATTP SPS03 Upgrades
* Updated default values in defaults/main.yml for SAP ATTP

## Version 2.9-000284 (2023-11-03) (c5299015)
### Enhancement - SPR Update ERP6-EHP8 to EHP8-SP21 2023-10 release cycle
* update default values in defaults/main.yml

## Version 2.9-000283 (2023-11-07) (c5356919)
### Introduce full automation for Content Server provisioning/upgrade
* Updated spr/tasks/provisioning/content-server-install.yml to enhance provisioning automation
* Updated spr/defaults/spr_defaults.yml to add ports info
* Updated spr/defaults/main.yml to add related variables
* Updated spr/tasks/prerequisites/maxdb-check.yml to add pre-checks for maxdb

## Version 2.9-000282 (2023-11-30) (i535751)
### Enhancement - DR Hostsfile role update
* Updated default behavior to apply host file changes to databaes as well as applications

## Version 2.9-000281 (2023-11-20) (c5353501)
### Enhancement - SPR Upgrades Fiori Front-End Server 2024-02 release cycle
* Updated default values in defaults/main.yml to point to new fiori_fes tar images

## Version 2.9-000280 (2023-11-15) (c5353501)
### Enhancement - SPR Upgrade 2024-02 release cycle for s4hana_foundation
* Updated default values in defaults/main.yml to point to new S/4HANA Foundation 2023 Tars images

## Version 2.9-000279 (2023-11-03) (c5299015)
### Enhancement - SPR Update DS, IS, IPS 2023-10 release cycle
* update default values in defaults/main.yml for DS, IS and IPS

## Version 2.9-000278 (2023-10-23) (c5299015)
### Enhancement - SPR Upgrade Process Orchastration (PO/PI) NW75_SPS28
* Use most recent default Tars paths in defaults/main.yml for PO/PI

## Version 2.9-000277 (2023-10-27) (C5356919)
### Enhancement - SPR Upgrade s4hana_addons for 2023-10A release cycle
* Updated default values in defaults/main.yml to point to new S4HANA Addons tar images

# Version 2.9-000276 (2023-10-26) (C5256103)
### Enhancement - SPR Upgrade S/4HANA 2023 FPS00 for 2024-02 release cycle
* Updated default values in defaults/main.yml to point to new SAP S/4HANA 2023 tar images

## Version 2.9-000275 (2023-09-28) (C5299015)
### Enhancement - SPR Upgrade FRUN 202310
* Update default values in defaults/main.yml to point to the newest FRUN tars

## Version 2.9-000274 (2023-11-02) (c5355631)
### Enhancement - SPR Upgrade IQ
* Adds a provisioning task to update hostfile for disaster recovery scenario
* Adds jinja templates for hostfiles for `prd` & `dr`

## Version 2.9-000273 (2023-09-23) (i548219)
### Enhancement - STOI-62 Add exclude host from /etc/hosts for 99.9/HA
* Adds an option to set "spr_dns: false" in the inventory file
* spr_dns == false excludes host
* required for 99.9/HA and to exclude hosts

## Version 2.9-000272 (2023-10-16) (c5353543)
### Enhancement - SPR Update dpagent for 2023-10 release cycle
* update default values in defaults/main.yml for dpagent

## Version 2.9-000271 (2023-10-03) (C5353543)
### Enhancement - SPR Upgrade Access Control for 2023-10 release cycle
* Updated default values in defaults/main.yml to point to new Access Control tar images

## Version 2.9-000270 (2023-10-17) (c5256103)
### Products Update - SAP Access Control for S/4HANA
* Updated spr-hostfile.j2 to add new product "access_control_s4hana"
* Updated spr_defaults to add new product : "access_control_s4hana"
* Updated main.yml to add upgraded archive location for product access_control_s4hana:

## Version 2.9-000269 (2023-10-20) (C5356919)
### update the hana-install.yml for fixing the bug during HANA hdbrename process
* Bug Fix during hdbrename process
* Allow lower case use of spr_sid for provisioning HANA DB for bug fix

## Version 2.9-000268 (2023-10-01) (c5350301)
### Enhancement - SPR Upgrade IQ
* Update default values in defaults/main.yml to point to new tars in IQ Tars
* Update automation to Reduce num of values to change in defaults/main for IQ

## Version 2.9-000267 (2023-10-10) (c5299015)
### Enhancement - SPR Upgrade SAP Analytics Cloud 1.0.385
* Updated default values in defaults/main.yml with following
  *   sac_agent:
    version: SAP_ANALYTICS_CLOUD_AGENT_1.0/SAP_ANALYTICS_CLOUD_AGENT_1.0_PL385
    path: /staging/product-line/SAP_Analytics_Cloud

## Version 2.9-000266 (2023-10-16) (c5299015)
### Enhancement - SPR Upgrades 202310: DATA_SERVICES_AGENT Version 2309_1.0.11.5716
* Updated default values in defaults/main.yml - Updated value
  * version: DATA_SERVICES_AGENT_2309_1.0.11.5716
    path: /staging/product-line/SAP_Cloud_Platform/SAP_CLOUD_PLAT_INT_DATA_SERV_LINUX

## Version 2.9-000265 (2023-10-16) (C5356919)
### Enhancement - SPR Upgrade SAP PLC 4.5 202310 and Fix HANA rename bug
* Update default values in defaults/main.yml to point to the newest plc tars
* HANA rename bugfix to update hostname parameter in landscapeVariable.properties file

## Version 2.9-000265 (2023-10-18) (c5299015)
### Enhancement - SPR Upgrades SAP LAMA 3.0 ENT SP28
* Updated default values in defaults/main.yml to point to upgraded version
    * lama_ent_java:
      version: SAP_LANDSCAPE_MGT_ENT_JAVA_SP28

## Version 2.9-000264 (2023-10-12) (c5356919)
### Add Products - SAP FIORI for ILM and BOBJ
* Updated spr-hostfile.j2 to add back ilm, bobj
* Updated spr_defaults.yml to add back ilm, bobj
* Updated vault_paths.j2 to add back bobj

## Version 2.9-000263 (2023-09-20) (c5353543)
### Enhancement - SPR Upgrade gts
* Update default values in defaults/main.yml to point to new tars in GTS Tars

## Version 2.9-000262 (2023-10-04) (c5353501)
### Enhancement - SPR Upgrades Supply Chain Management Upgrade 202310
* Updated default values in defaults/main.yml to point to new SCM media

## Version 2.9.000261 (2023-10-06) (c5353501)
### Enhancement - SPR Upgrade 202302 bw4hana_bpc
* Updated default values in defaults/main.yml to point to new BW4HANA BPC Tars

## Version 2.9-000260 (2023-09-29) (c5256103)
### Enhancement - SPR Upgrade SAP GBTR 3.0 202310
* Update default values in defaults/main.yml to point to the newest gbtr tars

## Version 2.9-000259 (2023-09-28) (c5353501)
### Enhancement - SPR Upgrade SSO 202310
* Update default values in defaults/main.yml to point to the newest sso tars

## Version 2.9-000258 (2023-09-29) (c5256103)
### Enhancement - SPR 202310 Upgrade SAP_ERP_EPH8 NW SPS28 Updates
* Updated default values in defaults/main.yml for SAP_ERP_EPH8 NW SPS28

## Version 2.9-000257 (2023-09-28) (c5356919)
### Decommission Products - SAP FIORI for ILM
* Updated spr-hostfile.j2 to remove ilm
* Updated spr_defaults to remove ilm
* Updated main.yml to remove ilm related entries

## Version 2.9-000256 (2023-09-11) (c5299015)
### Enhancement - SPR Upgrades SAP Cloud Connection
* Updated default values in defaults/main.yml to point to upgraded CC 2.16.0
  * cloudconnector:
    version: SAP_CLOUD_CONNECTOR_2.0_2.16.0

## Version 2.9-000255 (2023-09-25) (c5299015)
### Enhancement - SPR Upgrades SAP S4HANA_FOUNDATION
* Updated default values in defaults/main.yml to point to upgraded SAP S4HANA_FOUNDATION 2022 SPS02
  * version: SAP_S4HANA_FOUNDATION_2022_SPS02
* Fresh install was done to address the additional addons to be removed from the prior image

## Version 2.9-000254 (2023-09-27) (c5299015)
### Enhancement - SPR 202310 Upgrade SAP CARAB to SPS05
* Updated main.yml - updgraded version path for product 'car'
    version: SAP_CARAB_5.0_SPS05

## Version 2.9-000253 (2023-09-26) (c5356919)
### New Products - SAP BOBJ BIP and SAP Lumira
* Updated spr-hostfile.j2 to add new products bobj_bip and lumira:
* Updated spr_defaults to add new products bip and lumira:  "bobj_bip:lumira"
* Updated main.yml to add new products bip and lumira:  "bobj_bip:lumira"
* Rename bobj to bobj_bip in vault-paths.j2

## Version 2.9-000252 (2022-14-09) (c5353501)
### Enhancement - SPR 202310 Upgrade bw4hana_addon
* Update default values in defaults/main.yml to point to new tars in BW4HANA_ADDONS Tars

## Version 2.9-000251 (2023-09-19) (c5353501)
### Enhancement - SPR Upgrade SLT 202310
* Update default values in defaults/main.yml to point to the newest SLT tars

## Version 2.9-000250 (2023-09-13) (i535751)
### Enhancement - Watchman Exclusion Addition
* Updated default values in defaults/main.yml to include "interfaces/* in the watchman exclusion_list

## Version 2.9-000249 (2023-09-05) (i868402)
### Enhancement - Add Support for Syncthing Playbook Distribution
* Added to SPR Role Defaults.
  * spr_syncthing_prefix
  * spr_versions_to_keep
  * spr_cleanup_older
  * spr_products.swpm2_0
  * spr_products.swpm1_0
* Modified SPR Role Defaults
  * spr_swpm_sapinst_abap
  * spr_swpm_sapinst_java
* New Tasks: general/syncthing-distro.yml

## Version 2.9-000248 (2023-09-11) (c5299015)
### Enhancement - SPR Upgrades SAP TM 202310
* Updated default values in defaults/main.yml to point to upgraded SAP TM 9.6 SPS09 SEP11

## Version 2.9-000247 (2023-08-30) (c5299015)
### Enhancement - SPR 202310 Upgrade SAP HANA Cockpit
* Updated main.yml - updgraded version path for product hanacockpit
    "version: SAP_HANA_COCKPIT_2.0_SPS_16_PATCH_06"

## Version 2.9-000246 (2023-08-30) (C5353501)
### Enhancement - SPR 202310 Upgrade S4HANA livecache
* Updated default values in defaults/main.yml for SAP s4hana livecache

## Version 2.9-000245 (2023-09-01) (c5353543)
### Enhancement - SPR Upgrades ADS 202307
* Updated default values in defaults/main.yml to point to new ADS tar

## Version 2.9-000244 (2023-08-31) (c5299015)
### Enhancement - SPR 202310 Upgrade SAP Webdispatcher
* Updated main.yml - upgraded version path for product webdispatcher:
    "SAP_WEB_DISPATCHER_7.89_PL210"

## Version 2.9-000243 (2023-08-30) (c5299015)
### Enhancement - SPR 202310 Upgrade SAP HANA Enterprise Edition
* Updated main.yml - upgraded version path for product hana_ee:
    "version: SAP_HANA_ENTERPRISE_EDITION_2.0_SPS07_REV72"

## Version 2.9-000242 (2023-08-25) (c5353501)
### Enhancement - SPR 202310 Upgrade SAP Digital Marketing Manufacturing (MII)
* Updated default values in defaults/main.yml for SAP Digital Marketing Manufacturing (MII)

## Version 2.9-000241 (2023-08-07) (i868402)
### Enhancement - Validation Check for spr_defaults
* Adds an optional task that validates that the first inventory file passed by the CLI is the spr_defaults file.

## Version 2.9-000240 (2023-08-21) (c5353501)
### Enhancement - SPR Upgrade FIORI-CARAB for 2023-10 release cycle
* Updated default values in defaults/main.yml pointing to new fiori-carab Tars

## Version 2.9-000239 (2023-08-22) (c5299015)
### New Product - SPR AS JAVA
* Updated spr-hostfile.j2 to add new product ASJAVA:  "union(groups.nwjava)"
* Updated spr_defaults to add new product ASJAVA:  "nwjava:"
* Updated main.yml to add new product ASJAVA:  "nwjava:

## Version 2.9-000238 (2023-08-15) (c5353543)
### Enhancement - SPR Upgrade CRM
* Updated default values in defaults/main.yml to point to new CRM Tars from EHP4 SPS20 -> EHP4 SPS20_2023_AUG

## Version 2.9-000237 (2023-08-13) (C5353501)
### Enhancement - SPR Upgrades S4HANA Addons 202310
* Updated default values in defaults/main.yml to point to new s4hana_addons tar

## Version 2.9-000236 (2023-08-04) (c5353501)
### Enhancement - SPR Upgrade BW4HANA for 2023-10 release cycle
* Updated default values in defaults/main.yml pointing to new bw4hana Tars

## Version 2.9-000235 (2022-08-03) (C5353501)
### Enhancement - SPR Upgrades S4HANA 202310
* Updated default values to point to the newly upgraded S4HANA Tar Images

## Version 2.9-000234 (2023-08-04) (c5356919)
### Enhancement - SPR Upgrades -   Portal
* Updated default values in defaults/main.yml to point to new Portal software

## Version 2.9-000233 (2023-08-09) (c5353543/c5350301)
### Enhancement - SPR 202306 Upgrade SCM Optimizer (optimizer)
* Updated default values in defaults/main.yml for SAP optimizer

## Version 2.9-000232 (2023-06-06) (i577821)
### Enhancement - Updated vault-paths.j2 template
* Updated vault-paths.j2 replacing fiori with fiori_carab and fiori_fes

## Version 2.9-000231 (2023-07-31) (c5350301)
### Enhancement - SPR 202306 Upgrades SWPM and HANA Platform_Edition
* Updated default values in defaults/main.yml to point to new SWPM 1.0 and 2.0
* Updated default values in defaults/main.yml to point to new HANA Client
* Updated default values in defaults/main.yml to point to new HANA Platform_Edition Tars

## Version 2.9-000230 (2023-07-28) (c5356919)
### Enhancement - SPR Upgrades -   Data Services Automation
* Updated default values in defaults/main.yml to point to new Data Services variables and paths

## Version 2.9-000229 (2023-07-19) (c5353543)
### Enhancement - SPR Upgrades -   SSO
* Updated default values in defaults/main.yml to point to new SSO and TM media

## Version 2.9-000228 (2023-07-24) (c5353543/c5350301)
### Enhancement - SPR Upgrades HANA Enterprise Edition
* Updated default values in defaults/main.yml to point to new HANA EE Tars

# Version 2.9-000227 (2023-07-18) (c5353501)
### Enhancement -  SPR Update -  Solman
* Updated default values in defaults/main.yml to point to new tars in Solman Tars
* Fix bug on  db-connection-check.yml
* Updated spr-solman-deploy.yml with C++-11 modules

## Version 2.9-000226 (2023-07-11) (c5353501)
### Enhancement -  SPR Update -  sac_agent
* Updated default values in defaults/main.yml for SAP sac_agent.

## Version 2.9-000225 (2023-05-16) (C5299015)
### Enhancement - SPR 202303 Upgrade SAP ATTP SPS02 MAY 2023 Upgrades
* Updated default values in defaults/main.yml for SAP ATTP

## Version 2.9-000224 (2023-06-30) (c5356919)
### Enhancement - SPR New Build for SAP Landscape Management Enterprise
* Update default values in defaults/main.yml to point to new tars for LaMa Enterprise Java

## Version 2.9-000223 (2023-06-29) (C5256103)
### Enhancement - SPR Upgrade SAP Web Dispatcher for 2023-06 release
* Update default values in defaults/main.yml to point to new tars for SAP WebDispatcher

## Version 2.9-000222 (2023-07-11) (c5353501)
### Enhancement -  SPR Update -  sac_agent
* Updated default values in defaults/main.yml for SAP sac_agent.

## Version 2.9-000221 (2023-07-06) (c529015)
### New Product - SPR Focused Run 4.01
* Update defualt values in defaults/main.yml to add new product tars in FRUN Tars

## Version 2.9-000220 (2023-06-25) (c5353501)
### Enhancement - SPR Upgrade gts
* Update default values in defaults/main.yml to point to new tars in GTS Tars

## Version 2.9-000219 (2023-06-22) (C5353501)
### Enhancement - SPR Upgrade Access Control for 2023-06 release cycle
* Updated default values in defaults/main.yml to point to new Access Control tar images

## Version 2.9-000218 (2023-06-20) (c5356919)
### Enhancement - SPR Upgrades Portal for 2023-06 release cycle
* Updated default values in defaults/main.yml to point to new Portal tar images

## Version 2.9-000217 (2023-06-16) (c5299015)
### Enhancement - SPR Upgrade 202306 release cycle for s4hana_foundation
* Updated default values in defaults/main.yml to point to new S4HANA Foundation Tars

## Version 2.9-000216 (2023-06-08) (c5356919)
### Enhancement - SPR Upgrades CPIDS-Agent for 2023-06 release cycle
* Updated default values in defaults/main.yml to point to new cpids agent tar images

## Version 2.9-000215 (2023-06-02) (c5353501)
### Enhancement - SPR Upgrades Fiori Front-End Server 2023-06 release cycle
* Updated default values in defaults/main.yml to point to new fiori_fes tar images

## Version 2.9-000214 (2023-05-16) (C5299015)
### Enhancement - SPR 202303 Upgrade SAP_ERP_EPH8 MAR 2023 Updates
* Updated default values in defaults/main.yml for SAP ERP_EHP8 MAR 2023

## Version 2.9-000213 (2023-06-01) (c5353501)
### Enhancement - SPR Upgrade CRM 202306
* Updated default values in defaults/main.yml to point to new CRM Tars from EHP4 SPS19 -> EHP4 SPS20

## Version 2.9-000212 (2023-05-31) (c5356919)
### Enhancement - SPR Upgrade 202306 SAP FIORI CARAB
* Updated default values in defaults/main.yml to point to new SAP FIORI CARAB folders

## Version 2.9-000211 (2023-05-25) (c5353543)
### Enhancement - SPR Upgrade Process Orchastration (PO/PI) NW75_SPS26 202306
* Use most recent default Tars paths in defaults/main.yml for PO/PI

## Version 2.9-000210 (2023-5-26) (c5353501)
### Enhancement - SPR Upgrade CARAB 5.0 SPS04_01 202306
* Use most recent default Tars paths in defaults/main.yml for CARAB 5.0 SPS04_01

## Version 2.9-000209 (2023-05-30) (C5256103)
### Enhancement - SPR Upgrades Global Batch Traceability Upgrade 202306
* Add default values in defaults/main.yml to point to new GBTR media

## Version 2.9-000208 (2023-05-25) (c5353501)
### Enhancement - SPR Upgrades Supply Chain Management Upgrade 202306
* Updated default values in defaults/main.yml to point to new SCM media

## Version 2.9-000207 (2023-05-22) (c5350301)
### Enhancement - SPR Upgrade 202306 SAP Host Agent
* Upgrade host agent default minimum version folders

## Version 2.9-000206 (2023-05-18) (c5353501)
### Enhancement - SPR Upgrades Bwnetweaver Upgrades 202306
* Updated default values in defaults/main.yml to point to new bwnetweaver tar images
* removed redundant folder name in the path of default group variables

## Version 2.9-000205 (2023-05-15) (c5353501)
### Enhancement - SPR Upgrades Transportation Management Upgrade 202306
* Updated default values in defaults/main.yml to point to new TM media

## Version 2.9-000204 (2023-05-12) (C5256103)
### Enhancement - SPR Upgrades S4HANA Addons 202306
* Updated default values in defaults/main.yml to point to new s4hana_addons tar

## Version 2.9-000203 (2023-05-12) (c5353543)
### Enhancement - SPR 202306 Upgrade SAP Digital Marketing Manufacturing (MII)
* Updated default values in defaults/main.yml for SAP Digital Marketing Manufacturing (MII)

## Version 2.9-000202 (2023-04-11) (c5353543)
### Enhancement - SPR Upgrades ADS 202306
* Updated default values in defaults/main.yml to point to new ADS tar

## Version 2.9-000201 (2023-05-10) (C5256103)
### Enhancement - SPR 202302 Upgrade S4HANA livecache and Access Control
* Updated default values in defaults/main.yml for SAP s4hana livecache
* Create values for new product access_control_s4hana and update existing access_control

## Version 2.9-000200 (2023-04-128) (c5356919)
### Enhancement - SPR 202306 Upgrade SAP S4HANA, HANACOCKPIT, DPAGENT
* Updated default values in defaults/main.yml for SAP S4HANA 2022 FPS01, hanacockpit and dpagent

## Version 2.9-000199 (2023-04-28) (c5350301)
### Enhancement - Match GTS folder name case with S3
* Match GTS folder name case with S3

## Version 2.9-000198 (2023-04-12) (c5350301)
### Enhancement - SPR 202302 Upgrade SCM Optimizer (optimizer)
* Updated default values in defaults/main.yml for SAP optimizer
* Due to sapinst execution bug, running startsap separately

## Version 2.9-000197 (2023-04-12) (c5356919)
### Enhancement - SPR 202306 Upgrade SAP Landscape Transformation (SLT)
* Updated default values in defaults/main.yml for SAP Landscape Transformation (SLT) SPS09

## Version 2.9-000196 (2023-04-12) (c5356919)
### Enhancement - SPR 202306 Upgrade CloudConnector and New Build CORP Serialization
* Updated default values in defaults/main.yml for CloudConnector and New Build CORP Serialization 1.0 FPS02

## Version 2.9.000195 (2023-04-12) (c5353501)
### Enhancement - SPR Upgrade 202306 BW4HANA_BPC
* Updated default values in defaults/main.yml to point to new bw4hana-bpc Tars from bw4hana 2021 SPS04 BPC SPS04 to bw4hana 2021 SPS05 SAP BPC SPS05
* Fix GTS folder structure and add support for GTS Edition for S4HANA

## Version 2.9-000194 (2023-04-07) (c5353501)
### Enhancement - SPR Upgrade BW4HANA 202306
* Updated default values in defaults/main.yml to point to new bw4hana Tars

## Version 2.9-000193 (2023-04-06) (c5350301)
### Enhancement - SPR 202306 Upgrade Platform Edition use SPS07
* Updated default values in defaults/main.yml for HANA Platform Edition SPS07 and HDB Client 2.16

## Version 2.9-000192 (2023-03-31) (c5350301)
### Enhancement - SPR 202306 Upgrades SWPM and HANA Platform_Edition
* Updated default values in defaults/main.yml to point to new SWPM 1.0 and 2.0
* Updated default values in defaults/main.yml to point to new HANA Client
* Updated default values in defaults/main.yml to point to new HANA Platform_Edition Tars

## Version 2.9-000191 (2023-03-16) (c5356919)
### Enhancement - SPR Upgrades for SAC Agent
* Updated default values in defaults/main.yml to point to new SAC Agent Media
* Updated the sac-agent-install.yml to include fix bugs and add tomcat service feature

## Version 2.9-000190 (2023-03-20) (c5350301)
### Enhancement - SPR Upgrades HANA Enterprise Edition
* Updated default values in defaults/main.yml to point to new HANA EE Tars

## Version 2.9-000189 (2023-03-13) (c5353543)
### Enhancement - SPR Upgrades Solution Manager
* Updated default values in defaults/main.yml to point to new SOLMAN TARs

## Version 2.9-000188 (2023-03-08) (c5356919)
### Enhancement - SPR  Initial Install of Product Lifecycle Costing 4.0 SP4 HF6
* Added SPR New Product - PLC 4.0 SP4 HF6

## Version 2.9-000187 (2023-03-08) (i555365)
### Enhancement - SPR Correct path for Access Control - CM-19076
* Correct Access Control path in spr - CM-19076

## Version 2.9-000186 (2023-03-07) (c5256103)
### Enhancement - SPR  Initial Install Supplier Relationship Management 7.0 EHP4 SPS19 202302
* Added SPR New Product - SRM 7.0 EHP4 SPS19
* Updated default values to reflect SPR SAP Data Services 4.3 SP01 Upgrade

## Version 2.9-000185 (2022-03-07) (c5353543/c5350301)
### Enhancement - SPR Upgrade bw4hana_addon and gts
* Update default values in defaults/main.yml to point to new tars in BW4HANA_ADDONS Tars
* Update default values in defaults/main.yml to point to new tars in GTS Tars

## Version 2.9-000184 (2022-02-28) (c5353501)
### Enhancement - SPR Upgrade DATA_SERVICES_AGENT (CPI-DS)
* Update `cpids-agent-install.yml` to include ksh installation
* Updated default values in defaults/main.yml to point to new Tar DATA SERVICES AGENT 2211 HOTFIX 1

## Version 2.9-000183 (2023-02-24) (c5353501)
### Enhancement - SPR Upgrade SAP HANA Cockpit 2.0 SPS 15 PATCH 05 202302
* Updated default values in defaults/main.yml to point to new hanacockpit Tars

## Version 2.9.000182 (2023-02-27) (c5353501)
### Enhancement - SPR Upgrade Access Control 202302
* Updated default values in defaults/main.yml to point to new SPS19 from SPS17 Tars

## Version 2.9.000181 (2023-02-16) (c5355631)
### Enhancement - SPR Upgrade EHP8_ERP 202302
* Updated default values in defaults/main.yml to point to new EHP8 for ERP Tars

## Version 2.9.000180 (2023-02-14) (c5356919)
### Enhancement - SPR Upgrade 202302 bw4hana_bpc / S4HANA_Livecache
* Updated default values in defaults/main.yml to point to new BW4HANA BPC Tars
* Updated default values in defaults/main.yml to point to new S4HANA_Livecache Tars

## Version 2.9-000179 (2022-02-13) (c5353501)
### Enhancement - SPR Upgrade SLT 202302
* Update default values in defaults/main.yml to point to the newest SLT tars

## Version 2.9-000178 (2022-02-13) (c5350301)
### Enhancement - Cloud Connector Automation
* Update cloudconnector install task to dynamically use files in Media folder, not hardcoded values

## Version 2.9-000177 (2023-01-20) (c5356919)
### Enhancement - SPR Upgrade Transport Management 202302
* Use most recent default Tars paths in defaults/main.yml

## Version 2.9.000176 (2023-02-06) (c5356919)
### Enhancement - SPR Upgrade 202302 s4hana_foundation
* Updated default values in defaults/main.yml to point to new S4HANA Foundation Tars
* S4HANA_FOUNDATION 2022 INITIAL FEB2023 version

## Version 2.9-000175 (2022-01-31) (i535751)
### Enhancement - SPR Upgrade BW4HANA_BPC 202211
* Update default values in defaults/main.yml to point to the new bw4hana-with-addons Tars from bw4hana 2.0 SPS09 to bw4hana 2021 SPS03
* Update default values in defaults/main.yml to point to the new bw4hana-bpc Tars from bw4hana 2.0 SPS09 to bw4hana 2021 SAP BPC 11.1 SP11
* Update default values in defaults/main.yml to point to the new bw4hana Tars from bw4hana 2.0 to bw4hana 2021
* Update default values in defaults/main.yml to point to the new S/4 Foundation Tars from S/4 foundation 2021 to S/4 founation 2022
* Update default values in defaults/main.yml to point to the new Portal Tars
* Update default values in defaults/main.yml to point to the new Fiori FES Tars from Fiori FES 6.0 SP06 to iori FES 6.0 SP07
* Update default values in defaults/main.yml to point to the new ATTP Tars
* Update default values in defaults/main.yml to point to the new Bwnetweaver Tars

## Version 2.9.000174 (2023-01-26) (c5350301)
### Enhancement - SPR Upgrade 202302 common tool
* Upgrade common tools default minimum version folders
* Sapinst
* Host Agent
* HANA Client

## Version 2.9-000173 (2023-01-18) (i535751)
### Enhancement - SPR Upgrades 202302
* Upgrading the following products
* CRM
* Fiori_CARAB
* MII
* Platform_Edition
* S4HANA
* S4HANA_Addons
* S4HANA_Livecache
* SSO

## Version 2.9-000172 (2023-1-27) (c5356919)
### Enhancement - SPR Upgrade CARAB 5.0 SPS04 202302
* Use most recent default Tars paths in defaults/main.yml for CARAB 5.0 SPS04

## Version 2.9-000171 (2023-1-20) (c5356919)
### Enhancement - SPR Upgrade Process Orchastration (PO/PI) NW75_SPS25 202302
* Use most recent default Tars paths in defaults/main.yml for PO/PI

## Version 2.9-000169 (2022-12-07) (c5335697)
### Enhancement - watchman/rsync logging
* Add log file for rsync
* Rotate both watchman/rsync log files

## Version 2.9-000168 (2022-12-12) (c5350301)
### Enhancement - SPR Upgrade Webdispatcher 202302
* Use most recent default Tars paths in defaults/main.yml
* Fix - add required librarby to webdispatcher provisioning
* Group webdispatcher as PAS in spr-provisioning

## Version 2.9-000167 (2022-12-13) (i535751)
### Enhancement - SPR Various Upgrades
* Attp upgrade, ADS upgrade, Fiori_carab upgrade
* Renamed fiori to fiori_carab, a more descriptive name

## Version 2.9-000166 (2022-11-09) (c5350301)
### Enhancement - SPR Upgrade CRM 202210
* Updated default values in defaults/main.yml to point to new CRM Tars from EHP4 SPS17 -> EHP4 SPS19

## Version 2.9-000165 (2022-11-10) (c5353501)
### Enhancement - SPR Upgrade BW4HANA 202210
* Updated default values in defaults/main.yml to point to new bw4hana Tars
* updated bw4hana-addons path on default/main.yml to fix configuration content

## Version 2.9-000164 (2022-11-08) (c5353501)
### Enhancement - SPR Upgrade Car 202210
* Updated default values in defaults/main.yml to point to new Car Tars

## Version 2.9-000163 (2022-11-04) (i535751)
### Enhancement - SPR Upgrade EHP8 202210
* Updated default values in defaults/main.yml to point to new Payroll Tars from EHP8 SPS17 -> EHP8 SPS19

## Version 2.9-000162 (2022-11-02) (i535751)
### Enhancement - SPR Upgrade Payroll 202210
* Updated default values in defaults/main.yml to point to new Payroll Tars from EHP8 SPS17 -> EHP8 SPS18

## Version 2.9-000161 (2022-10-19) (i535751)
### Enhancement - SPR Upgrades Data Services, Portal 202210
* Updated default values in defaults/main.yml to point to new Portal Tars from NW 22 -> NW 25
* Updated default values in defaults/main.yml to point to new Data Services media from DS 4.2 -> 4.3
* Updated default values in defaults/main.yml to point to new SLT Tars from SLT 3.0 SPS06 -> SLT 3.0 SPS08

## Version 2.9-000160 (2022-10-19) (i868402)
### Enhancement - New variable map for spr_products
* Create a new map tracking spr_products and paths.  Should make this more scalable and easier to read.
* Remap old variables to ensure no change in logic occurs.
* Future improvements can reference and migrate to the new map directly

## Version 2.9-000159 (2022-10-20) (c5353501)
### Enhancement - SPR Upgrades Transportation Management Upgrade 202210
* Updated default values in defaults/main.yml to point to new TM media

## Version 2.9-000158 (2022-09-23) (c5350301)
### Enhancement - SPR Upgrades MII Upgrades 202210
* Updated default values in defaults/main.yml to point to new MII media

## Version 2.9-000157 (2022-10-12) (i535751)
### Enhancement -  SPR Upgrades Cloud Connector Upgrades 202210-2
* Updated Cloud Connector deployment media

## Version 2.9-000156 (2022-10-11) (i511522)
### Enhancement - Add s4pce/fed/fed-managment vars file
* Added vars file for S4PCE-FedCiv management

### Enhancement - S4PCE-FedCiv additional instances and updates
* Added additional instances for S4PCE-FedCiv Support0001 and Support0002
* Updated deployed databases requiring manual install to use `platform_edition` productname

## Version 2.9-000155 (2022-10-11) (i535751)
### Enhancement - SPR Upgrades GTS Upgrades 202210
* Updated default values in defaults/main.yml to point to new GTS tar images

## Version 2.9-000155 (2022-09-29) (c5350301)
### Enhancement - SPR Upgrades Fiori Front-End Server 202210
* Updated default values in defaults/main.yml to point to new fiori_fes tar images

## Version 2.9-000154 (2022-09-27) (i535751)
### Enhancement - SPR Upgrades Bwnetweaver Upgrades 202210
* Updated default values in defaults/main.yml to point to new bwnetweaver tar images

## Version 2.9-000153 (2022-09-23) (c5350301)
### Enhancement - SPR Upgrades SSO Upgrades 202210
* Updated default values in defaults/main.yml to point to new SSO and TM media
* Updated default values in defaults/main.yml to point to new SSO and TM tar images

## Version 2.9-000152 (2022-09-14) (c5335697)
### Enhancement - Updates for addtional VM to replicate NFS mounts
* Updates for addtional VM to replicate NFS mounts

## Version 2.9-000151 (2022-09-13) (i535751)
### Enhancement - Update ILM values
* Updated ILM 1.0 SP02 tar version

## Version 2.9-000150 (2022-09-12) (i535751)
### Enhancement - Update HCP values
* Updated hana cockpit tar versions

## Version 2.9-000149 (2022-09-12) (i868402)
### Enhancement - Migrate Customer Inventories
* Migration to environments repo
* Migrated Customer0006
* Migrated Customer0007
* Migrated Customer0017
* Migrated Customer0020
* Migrated Customer0026
* Migrated Customer0027

## Version 2.9-000148 (2022-09-07) (i868402)
### Enhancement - Update Defaults values
* Move version defaults out of inventory to defaults file

## Version 2.9-000147 (2022-09-22) (i555365)
### Enhancement - Customer0026 add sftp endpoints for dev/prd
* For ss4/qs4/ds4 add sftp - interface-dev - CM-16430
* For psf add sftp - interface-prd - CM-16430

## Version 2.9-000146 (2022-09-07) (i868402)
### Enhancement - Migrate Customer Inventories
* Migration to environments repo
* Migrated Customer0008
* Migrated Customer0012
* Migrated Customer0018

## Version 2.9-000145 (2022-09-01) (c5309377)
### Enhancement - Update monitoring/logging variables for customers in northamerica-northeast1
* Updates the monitoring/logging variables for customers in northamerica-northeast1

## Version 2.9-000144 (2022-08-31) (c5336940)
### Enhancement - Update customer0026/customer0012 inventory file
* Removed deprecated attribues spr_db_abap_tenant_sid and spr_db_java_tenant_sid
* Ensured correct usage of spr_db_first_tenant_sid and spr_db_second_tenant_sid

# Version 2.9-000143 (2022-09-02) (i535751)
### Enhancement - SPR Upgrades Access Control Upgrades 202210
* Updated default values in defaults/main.yml to point to new Access Control tar images

## Version 2.9-000142 (2022-08-31) (i555365)
### Enhancement - Update SDC/SPC - add endpoints for sac_agent
* Update SDC/SPC - add endpoints for sac_agent - CM-16765

## Version 2.9-000141 (2022-08-30) (i555365)
### Enhancement - Update GCP customer0012 host file
* Add entry to host file for s-04602-c5a.cpggpc.ca - CM-16729

## Version 2.9-000140 (2022-08-26) (c5309377)
### Enhancement - Update GCP customer variables for monitoring
* Updates customer variable files to add monitoring for telegraf/vector

## Version 2.9-000139 (2022-08-22) (i511522)
### Enhancement - Update GCP customer inventories for disk snapshots
* Added `gcp_disk_snapshot_policy` variable to customer008, customer0012, and customer0018

## Version 2.9-000138 (2022-08-16) (c5309377)
### Enhancement - Update var files for customer0006
* Updated variables files for customer0006 to send logs to updated vector

# Version 2.9-000137 (2022-08-22) (c5350301)
### Enhancement - SPR Upgrades PO Upgrades 202210
* Updated default values in defaults/main.yml to point to new PO media
* Updated default values in defaults/main.yml to point to new PO tar images

## Version 2.9-000136 (2022-08-18) (i535751)
### Enhancement - SPR SAC Agent Upgrade
* Updated default values in defaults/main.yml to point to new sac agent media
* Updated sac sac-agent-install to use variables for Apache tomcat version, SAPJVM SAR, C4AGENT ZIP, Java Connector TGZ

## Version 2.9-000135 (2022-08-17) (c5335697)
### Enhancement - handle case sensitivity
* handle case sensitivity

## Version 2.9-000134 (2022-08-17) (i868402)
### Enhancement - Migrate Customer Inventories
* Migration to environments repo
* Migrated Customer0015
* Migrated Customer0019
* Migrated Customer0022
* Migrated Customer0025
* Migrated Customer0028
* Migrated Support0001

## Version 2.9-000133 (2022-08-18) (i868402)
### Enhancement - Update Main Defaults
* Update location for SSO

## Version 2.9-000132 (2022-08-17) (i868402)
### Enhancement - Migrate Customer Inventories
* Migration to environments repo
* Migrated Customer0003
* Migrated Customer0004
* Migrated Customer0005
* Migrated Customer0009
* Migrated Customer0010
* Migrated Customer0013
* Migrated Customer0014
* Migrated SPR Defaults

# Version 2.9-000131 (2022-08-15) (i555365)
### Enhancement - Customer0006 add host file entry for reverse private link
* add host file entry for phappsdc.us.parker.corp - CM-16524
* add host file entry for phtransfer.parker.com - CM-16593

## Version 2.9-000130 (2022-08-10) (i511522)
### Enhancement - S4PCE FedCiv Support0001 + Support0002 inventory files
* Added S4PCE FedCiv Support0001 + Support0002 inventory files

# Version 2.9-000129 (2022-08-05) (i555365)
### Enhancement - Add additional port for convergent charging - 8443
* Updated ports for convergent charging - CM-16453

# Version 2.9-000128 (2022-08-05) (i535751)
### Enhancement - SPR Upgrades Solution Manager
* Updated default values in defaults/main.yml to point to new SOLMAN TARs

## Version 2.9-000127 (2022-08-03) (i514383/c5309377)
### Enhancement - Update Default Ports List
* Add `convergent_charging` default ports.

# Version 2.9-000126 (2022-08-04) (i535751)
### Enhancement - SPR Upgrades BW4HANA, Fix BWNETWEAVER, S4HANA
* Updated default values in defaults/main.yml to point to new data BW4HANA TARs
* Updated default values in defaults/main.yml to point to correct S4HANA TARs
* Updated default values in defaults/main.yml to point to correct BWNETWEAVER paths

# Version 2.9-000125 (2022-08-02) (i535751)
### Enhancement - SPR Upgrades DP Agent, Platform Edition 202210
* Updated default values in defaults/main.yml to point to new data provisioning agent media
* Updated default values in defaults/main.yml to point to new data platform edition TARs
* Updated default values in defaults/main.yml to point to new hana enterprise edition TARs

## Version 2.9-000124 (2022-08-02) (i535751)
### Enhancement - HDB Start
* Added "Wait for processes to start" task

## Version 2.9-000123 (2022-07-27) (i555365)
### Enhancement - SPR custom host file entries for customer0008
* Correct fqdn entry for custom host file entries

## Version 2.9-000122 (2022-07-28) (c5256103)
### Enhancement - Update S/4HANA ADDONS
* updated default tar image location for S/4 w.ADDONS in defaults/main.yml to refer to newly updated tars

## Version 2.9-000121 (2022-07-27) (i511522)
### Bugfix - CRE-S4PCE Customer0018 dr hostnames fix
* Fix DR hostnames

## Version 2.9-000120 (2022-07-26) (c5350301)
### Enhancement - SPR Upgrades ADS 202210
* Updated default values in defaults/main.yml to point to new ADS tar images

## Version 2.9-000119 (2022-06-29) (i868402)
### Enhancement - Customer0029 inventory
* Created new inventory for Customer0029

## Version 2.9-000118 (2022-07-25) (i555365)
### Enhancement - SPR custom host file entries for customer0008
* Add custom host file entries for outbound integrations for customer0008 - CM-16264

## Version 2.9-000117 (2022-07-18) (i535751)
### Enhancement - SPR Upgrades Cloud Connector 202210
* Updated default values in cloud-connector-install.yml to point to new JVM and Cloud Connector versions

## Version 2.9-000116 (2022-07-21) (c5309377)
### Bugfix - Remove duplicated YAML key
* Remove duplicated YAML key in Molecule tests
* Remove duplicated YAML key from defaults

## Version 2.9-000115 (2022-07-15) (i555365)
### Enhancement - customer0006 inventory
* Update inventory to correct endpoint ports for DSA | PSA | CM-16247
* Changed endpoint ports for ns2psaapp|ns2dsaapp from abap to sac agent
* update defaults.yml to include ports for sac agent

## Version 2.9-000114 (2022-07-15) (i511522)
### Bugfix - Customer0017 inventory bugfix
* Added sapcar install path
* Fixed vault secret path
* `c017app01p72` hostname corrected
* `c017app02x80` hostname corrected

## Version 2.9-000113 (2022-07-26) (i870146)
### Enhancement - Added inventory file for FUSE environment
* Added fuse-customer0016 inventory for hs-pce
* Added `aws_efs_ip_address` variable to fuse-customer0016 inventory to use ip-address instead of efs id
* Added enable_now entry in `variables-create.yml` and updated default ports for enable_now

## Version 2.9-000112 (2022-07-15) (i535751)
### Enhancement - SPR Upgrades Webdispatcher S4HANA 202210
* Updated default values to point to the newly upgraded S4HANA and Webdispatcher Tar Images

## Version 2.9-000111 (2022-07-12) (c5336940)
### Bugfix - SAC agent install
* Added JRE_HOME and JAVA_HOME environment variables for the apache start task

## Version 2.9-000110 (2022-07-08) (c5336940)
### Enhancement - Customer0008 - Additional Inventory - Rise
* Added new inventory file for additional infrastructure for customer0008 Rise

## Version 2.9-000109 (2022-07-01) (i868402)
### Enhancement - Non SPR support
* Adjust automation to ignore non_spr products

## Version 2.9-000108 (2022-07-06) (i868402)
### Enhancement - Customer0017 phase1 hosts
* Added Phase 1 hosts as authorized through CM-123456

## Version 2.9-000107 (2022-06-17) (i535751)
### Enhancement - Dataservices Enhancement
* Added packages to the prerequisites
* added a '/' to the install directory for IPS,DS,IS

## Version 2.9-000106 (2022-07-07) (c5336940)
### Enhancement - Customer0012 - FQDN Migration Inventory
* Add inventory file for FQDN migration hosts

## Version 2.9-000105 (2022-07-06) (c5335697)
### Enhancement - Customer0006 - create new inventory file for SFTP
* create new inventory file for Customer0006 SFTP

## Version 2.9-000104 (2022-07-06) (i868402)
### Enhancement - Customer0027 - sbx landscape
* Add 2 SBX hosts

## Version 2.9-000103 (2022-07-01) (i555365)
### Enhancement - Customer0006 - update host file entries for outbound integrations
* Updated host file entries for outbound integrations | CM-16037

## Version 2.9-000102 (2022-06-17) (i535751)
### Enhancement - Customer0018-new inventory
* Created new inventory for C18 migration

## Version 2.9-000101 (2022-06-20) (I555365)
### Enhancement - customer0025 inventory
* Update inventory to include endpoints for cloud connector - CM-15969
* Add endpoints for ns2pclapp, ns2pc2app and ns2dclapp
* update defaults.yml to include ports for convergent charging

## Version 2.9-000100 (2022-05-27) (I555365)
### Enhancement - customer0010 inventory
* Update inventory to include endpoints for cloud connector - CM-15895

## Version 2.9-000099 (2022-05-27) (C5335697)
### Enhancement - customer0020 inventory
* New customer0020 inventory

## Version 2.9-000098 (2022-06-13) (C5335697)
###  Enhancement - Customer0027 inventory
* New Customer0027 inventory

## Version 2.9-000097 (2022-06-13) (c5336940)
### Enchancement - new customer0008 infrastructure EWM
* Added inventory file cre-customer0008-ewm.yml

## Version 2.9-000096 (2022-06-07) (i868402)
### Enhancement - new product sftp_interface
* Update variables for sftp_interface

## Version 2.9-000095 (2022-05-25) (I535751)
### Enhancement - Customer0007 inventory
* New Customer0007 inventory
### Enhancement - Update source defaults
* Update spr_db_source_list

## Version 2.9-000094 (2022-05-12) (C5335697)
### Enhancement - Update customer0022 inventory
* update default ports for sac agent, update inventory file for customer0022 sac agent instances

## Version 2.9-000093 (2022-05-12) (i535751/c5256103)
### Bugfix - data provisioning agent install
* Update dp_agent provisioning to set correct permissions on install directory

## Version 2.9-000092 (2022-05-12) (i868402)
### Enhancement - Update Customer0026 inventory
* Update Customer0026 inventory for canada central partition
### Enhancement - Update Customer0008 inventory
* Update Customer0008 inventory for missing VMs

## Version 2.9-000091 (2022-05-10) (c5336940)
### Enhancement - Update Customer0015 inventory
* Replace previous customer domain name with newly requested customer domain name.

## Version 2.9-000090 (2022-05-05) (i555365)
### Enhancement - Update Customer0025
* Update convergent charging database names after SID change
* Update convergent charging instance shapes
* Add new customer0025 inventory file.

## Version 2.9-000089 (2022-05-05) (i535751)
### Enhancement - Update Customer0026
* Added new customer0026 inventory file

## Version 2.9-000088 (2022-05-02) (i514383)
### Enhancement - Update Customer006, Customer008 inventories
* Add DR opentext server entry to customer006 inventory `spr_custom_hostfile_entries` section
* Add `spr_gcs_bucket` variable to customer008 inventory

## Version 2.9-000087 (2022-05-03) (i514383)
### Bugfix - HANA Cockpit Deployment
* Add tasks to `hanacockpit-install.yml` to create `/hana/backups` directory

## Version 2.9-000086 (2022-04-28) (c5336940)
### Enhancement - Update Customer0008
* New hostfile entries for customer0008

## Version 2.9-000085 (2022-04-28) (c5336940)
### Enhancement - Update Customer0018
* Add new customer0018 inventory file.

## Version 2.9-000084 (2022-04-27) (i514383)
### Enhancment - Customer0022 Inventory
* Added PCE CRE Customer0022 Inventory

## Version 2.9-000083 (2022-04-28) (i514383)
### Bugfix - Resolve Tenant Database Rename Issue
* Update `solman-install.yml` and `hana-install.yml` to start the database before renaming the tenant

## Version 2.9-000082 (2022-04-28) (i514383)
### Enhancement - Update PCE CRE Customer0019 Inventory
* Update `spr_db_sid` values in PCE CRE customer0019 inventory file
* Update cloud connector deployment to support latest version

## Version 2.9-000081 (2022-04-26) (i535751)
### Enhancement - Update CRE-Customer0006
* Added custom host entries for 2 OpenText servers

## Version 2.9-000080 (2022-04-26) (i535751)
### Enhancement - Update app-abap-start.yml + app-java-start.yml
* Updated both abap + java start to use set their environment variable "LD_LIBRARY_PATH": "/usr/sap/{{ spr_app_start_sid|upper }}/SYS/exe/uc/linuxx86_64" and starting services 00 and 01 before attempting to start APPS

## Version 2.9-000079 (2022-04-26) (i511522)
### Enhancment - Payroll Customer0009 inventory
* Added payroll customer0009 inventory file

##  Version 2.9-000078 (2022-04-26) (c5339660)
### Enhancement - Update customers
* Decomission Customer0001

## Version 2.9-000077 (2022-04-19) (c5335697)
### Enhancement - customer0022 Inventory Update
* Update inventory file for customer0022

## Version 2.9-000076 (2022-04-26) (i555365)
### Enhancement - update inventory vars
* Add inventory for Customer0019

## Version 2.9-000075 (2022-04-26) (c5335697)
### Enhancement - Update CRE-Customer0006
* add extra hostname entry

## Version 2.9-000074 (2022-04-25) (i514383)
### Enhancement - Update CRE-Support0001
* Align formatting with other customers in PCE
* Update GTS product version

## Version 2.9-000073 (2022-04-22) (i868402)
### Enhancement - Update Hostfiles
* Update CRE-S4PCE Customer0008 Host files

## Version 2.9-000072 (2022-04-22) (i514383)
### Enhancement - SAP IQ Automation
* Creat SAP IQ installation automation

## Version 2.9-000071 (2022-04-20) (i535751)
### Enhancement - Support0002 Inventory Update
* In the group RISE with SAP S/4HANA Cloud, private edition cloud connector s002app01pcl has been removed and is not needed for S02

## Version 2.9-000070 (2022-04-20) (i868402)
### Bugfix - Watchman Template bug
* Fixed incorrect variable name in watchman-config.j2 template

## Version 2.9-000069 (2022-04-18) (i514383)
### Enhancement - Add CPI-DS Server for Customer0013
* Add CPI-DS agent servers to customer0013 inventory requested in CM-15363
* Update `cpids-agent-install.yml` to leverage the ansible `yum` module

## Version 2.9-000068 (2022-04-18) (i535751)
### Enhancement - Support0002 Inventory Update
* In the group RISE with SAP S/4HANA Cloud, private edition cloud connector s002app01pcl was replaced with -> cloud connector s002app02pcl

## Version 2.9-000067 (2022-04-14) (c5335697)
### Enhancement - customer0013 Inventory Update
* Update inventory file for customer0013

## Version 2.9-000066 (2022-04-07) (i868402)
### Enhancement - Watchman improvements
* Moved Watchman related files to SPR Role
* Added predefined target sets
* Now matches on hostname instead of sids
* Add Dynamic exclusion lists

## Version 2.9-000065 (2022-04-11) (c5336940)
### Enhancement - Customer0015 Inventory Update
* Added the correct value for efs_usr_sap_trans_fsid in inventory file.

## Version 2.9-000064 (2022-04-05) (i514383)
### Enhancement - Support0001 Phase 3 Products
* Add Phase 3 products to support0001

## Version 2.9-000063 (2022-04-05) (c5335697)
### Enhancement -  Add/update inventory S02
* new instances in S02

## Version 2.9-000062 (2022-04-01) (i535751)
### Enhancement -  Add/update inventory C06
* Additional GTS instances in C06

## Version 2.9-000061 (2022-03-29) (i514383)
### Enhancement - Phase 3 Products
* Update the SPR ansible role to include Phase 3 products

## Version 2.9-000060 (2022-03-30) (i514383)
### Enhancement -  Create inventory for Azure Government management resources
* Create inventory file for Azure Government HANA Cockpit and Solution Manager
* Rename AWS GovCloud management inventory file for consistency

## Version 2.9-000059 (2022-03-24) (c5335698)
### Enhancement -  Add inventory file for gcp cre management stack
* GCP S4PCE Solman Inventory
* GCP S4PCE Hanacockpit Inventory

## Version 2.9-000058 (2022-03-30) (c5336940)
### Enhancement - update inventory vars
* Add inventory for Customer0015

## Version 2.9-000057 (2022-03-24) (i535751)
### Enhancement -  Add/update inventory C014
* Fixed issues in C014 inventory
* Removed ports from DR instances
* Fixed a DR hostname which incorrectly had DB post fix instead of DR

## Version 2.9-000056 (2022-03-22) (i868402)
### Enhancement -  update inventory vars
* Update CRE-S4PCE Customer0002 For XSA ports

## Version 2.9-000055 (2022-03-22) (i535751)
### Enhancement -  Add/update inventory vars C02
* Add SLT instances to customer0002 inventory
### Enhancement - update SLT tar default
* Update SLT default TAR version from FPS05 to FPS06

## Version 2.9-000054 (2022-03-18) (i868402)
### Enhancement -  update inventory vars
* Update Support0002 for audit

## Version 2.9-000053 (2022-03-14) (c5335697)
### Enhancement -  Add/update inventory vars
* Add inventory for Customer0017
### Enhancement - update install versions
* Update install binary versions

## Version 2.9-000052 (2022-03-08)  (i868402)
### Enhancement - customer0002 endpoint update
*  Update s4pce cre-customer0002

## Version 2.9-000051 (2022-03-04)  (i868402)
### Bugfix - incorrect syntax
* Incorrect ansible syntax for customer0009
### Enhancement - additional endpoints
* CM-14916
* Adds endpoints for cloudconnector
* adds endpoints for sac_agent
* Remove endpoitns from dr group
### Enhancement - hostfiles
* Makes code easier to read with some jinja templating
* Adds support for custom Hostfile entries
### Enhancement - Custom Hostfile entries
* Customer0013 custom entries
* CM-14905

## Version 2.9-000050 (2022-03-02)  (c5335697)
### Enhancement - customer0013 inventory
*  Update cre-customer0013 for new deployment

## Version 2.9-000049 (20222-02-25) (i511522)
### Enhancement - HCM-CRE Payroll Support0003 and Support0004 inventories
* Added support0003 and support0004 inventory files for HCM-CRE Payroll

## Version 2.9-000048 (2022-02-23) (i868402)
### Enhancement -  Add/update inventory vars
* Add inventory for Support0002
* Add inventory for Support0004

## Version 2.9-000047 (2022-02-22) (i868402)
### Enhancement - Add support for azure dynamic subnets
* Supports Azure automation refactor for dynamic subnets
* Uncomments opentext servers, as terraform automation can now parse them.

## Version 2.9-000046 (2022-02-21) (i514383)
### Bugfix - Update CRE-S4PCE Customer0010 cloudconnector SID
* Changed c010app01pcl SID in customer inventory from SS1 to PCL

## Version 2.9-000045 (2022-02-17) (i535751)
### Enhancement - Add/update inventory vars
* CM-14686 Adds inventory for Customer0012

## Version 2.9-000044 (2022-02-17) (i511522)
### Bugfix - CRE-S4PCE Customer0003 hostnames and spr_efs_mount
* Changed c003app01qew spr_efs_mount to trans-dew

## Version 2.9-000043 (2022-02-14) (i868402)
### Enhancement - Add/update inventory vars
* CM-14779 Adds SAP Router for Support0001

## Version 2.9-000042 (2022-02-08) (i868402)
### Enhancement - Add/update inventory vars
* CM-14529 Adds inventory for customer0009

## Version 2.9-000041 (2022-02-07) (i868402)
### Bugfix - Wrong Customer0003 Hostname
* Update incorrect host keys

## Version 2.9-000040 (2022-02-03) (i868402)
### Enhancement - Update Port List
* Adding 8101 to default ports java

## Version 2.9-000039 (2022-02-03) (c5335697)
### Enhancement - CRE-S4PCE Customer0010
* add inventory file for CRE-S4PCE Customer0010
* Updates defaults with latest source binaries

## Version 2.9-000038 (2022-02-01) (i535751)
### Enhancement - CM-14439 Add SAC Agents
* Added 3 SAC agents for customer0002

## Version 2.9-000037 (2022-02-02) (c5309377)
### Enhancement - Added some more variables
* Customer 0006 how has a couple more variables, for telegraf and vector!

## Version 2.9-000036 (2022-02-01) (i514383)
### Enhancement - Add QA landscape for customer0003
* Adds additional QA instances for customer0003

## Version 2.9-000035 (2022-02-01) (i514383)
### Bugfix - Add DR as a Landscape Option
* Add `dr` as an option to the list of default landscape variables

## Version 2.9-000034 (2022-01-31) (i868402)
### Enhancement - CM-14594 AMI Restore
* Restore c002app01pox from Jan 22 backup
### Bugfix - Missing values
* duplicate info in meta
* missing spr_hostname values
* missing dr landscape in defaults

## Version 2.9-000033 (2022-01-27) (i537609)
### Bugfix - Removed GCP CLI installation tasks from `incron-setup-gcp` provisioning task
* Removed all tasks related to installing the GCP CLI

## Version 2.9-000032 (2022-01-26) (i868402)
### Enhancement - Reorganize Variables
* Reorganize varible folder structure to facilitate multiple ansible inventory runs

## Version 2.9-000031 (2022-01-31) (i514383)
### Bugfix - Make Files Executable for SAC Agent Install
* Bugfix for SAC agent installation task

## Version 2.9-000030 (2022-01-18) (i868402)
### Enhancement - Update Default Ports
* Update Ports for PI/PO

## Version 2.9-000029 (2022-01-04) (c5335489)
### Enhancement - GCP DB Backup Tasks
* Added incron-setup-gcp.yml for incron on GCP
* Added incron-gcp.j2 for GCP

## Version 2.9-000028 (2021-01-07) (i868402)
### Enhancement - Add/update inventory vars
* Added inventory for CRE S4PCE Customer0003 Migration

## Version 2.9-000027 (2021-01-06) (c5335697)
### Enhancement - CRE-S4PCE Customer0002 Training
* Adds new training environment according to CM-14131 to CRE-S4PCE Customer0002

## Version 2.9-000026 (2021-12-29) (i514383)
### Enhancement - Cleanup s4pce incron setup playbook for Azure
* Added missing molecule test
* Cleaned up comment headers and typos in playbook name
* Ensures az cli and az copy is installed
* added additional required variables to customer06 inventory

## Version 2.9-000025 (2021-12-28) (i516349)
### Bugfix - Changelog inaccuracy fixes
* Fixed changelog values from 2.0 to 2.9

## Version 2.9-000024 (2021-12-28) (i516349)
### Enhancement - Add/update support for azure
* Added az_uploader for azure identity management
* Added incron-azure.j2 for incron on azure
* Added incron-setup-azure.yml for incron on azure

## Version 2.9-000023 (2021-12-20) (i868402)
### Enhancement - Removed extra value
* Removed extra hostname from customer06

## Version 2.9-000022 (2021-12-15) (i868402)
### Enhancement - Update defaults ports
* Adds port 30033 to hana_ee for XSA wdisp host based routing

## Version 2.9-000021 (2021-12-13) (i868402)
### Enhancement - Add/update inventory vars
* Added inventory for CRE S4PCE Customer0006

## Version 2.9-000020 (2021-12-08) (i868402)
### Enhancement - Add/update inventory vars
* Added SCM Optimizer to Parker-H

## Version 2.9-000019 (2021-11-18) (i868402)
### Enhancement - Add/update inventory vars
* Added inventory for USC Support0002
* Added inventory for USC Support0001 Edge
* Added inventory for Parker-H

## Version 2.9-000018 (2021-10-19) (i511522)
### Enhancement - Payroll Customer0008 additional nginx servers
* Added two more (Dev & QAS) nginx servers to payroll customer0008

## Version 2.9-000017 (2021-10-12) (i511522)
### Enhancement - Payroll Customer0008 inventory
* Added the inventory file for payroll customer0008 /var/business/hcm/payroll/cre-customer-0008.yml

## Version 2.9-000016 (2021-10-08) (i514383)
### Enhancement - Role Update
* Refreshed role after the latest upgrade cycle.

## Version 2.9-000015 (2021-09-23) (i535751)
### Enhancement - Customer0005 inventory
* Added the inventory file for customer0005 /vars/business/s4pce/cre-customer0005.yml

## Version 2.9-000014 (2021-09-23) (i535751)
### Enhancement - Customer0004 inventory
* Added the inventory file for customer0004 /vars/business/s4pce/cre-customer0004.yml

## Version 2.9-000013 (2021-09-10) (i868402)
### Enhancement - Move inventory files
* Move all "SPR" tenant inventory files under the current roles

## Version 2.9-000012 (2021-07-27) (i868402)
### Enhancement - Normalizing more product names
* renamed content_server to contentserver
* sync up the different inventories (from s4)

## Version 2.9-000011 (2021-07-26) (i868402)
### Enhancement - Update Name dpagent
* update dp_agent to dpagent

## Version 2.9-000010 (2021-07-20) (i514383)
### Enhancement - General role refresh
* Cleans up spr-provisioning.yml playbook
* Adds capability to deploy attp and mii

## Version 2.9-000009 (2021-07-14) (i514383)
### Enhancement - Add capability to deploy payroll; add molecule test for hostname verification
* Adds payroll-specific productname variables
* Updates the hostfile template
* Adds support for ansible molecule testing

## Version 2.9-000008 (2021-06-02) (i868402)
### Enhancement - Expand role to include silent deployment for additional application servers and phase 2 products
* Adds tasks to deploy sac agent, data services, scm, and additional application servers.
* Cleans up hostfile template and comment headers in taskfiles.

## Version 2.9-000008 (2021-06-02) (i868402)
### Enhancement - Support ansible execution with hostnames/cnames
* Updates the hostfile template to explicitly use the ipaddress value.

## Version 2.9-000007 (2021-05-11) (i514383)
### Enhancement - Refresh SPR Role
* Adds tasks to deploy spr phase 2 products
* General cleanup

## Version 2.9-000006 (2021-05-05) (c5323009)
### Bugfix - Updated ns2-scp-dev.sapns2.us domain to gitlab.core.sapns2.us
* Updated issue_tracker_url variable using old gitlab domain to new core services domain

## Version 2.9-000005 (2021-03-17) (i514383)
### Bugfix - chown scriptserver.ini file, update hana install ports
* Adds task to update the ownership of the scriptserver.ini file to address known issue
* Updates port numbers for scenario where primary tenant is not installed on the default port
* Updates filepath in hana-install.yml

## Version 2.9-000004 (2021-01-22) (i868402)
### Enhancement - Move the s4pce inventory
* Moved s4pce inventory to s4pce role

## Version 2.9-000003 (2020-12-29) (i514383)
### Enhancement - Update inventory
* Expands existing framework to include provisioning automation for the additional applications:
  * SAP Cloud Connector
  * SAP S/4HANA
  * Adobe Document Services

## Version 2.9-000002 (2020-12-22) (i868402)
### Enhancement - Update inventory
* Update inventory

## Version 2.9-000001 (2020-11-25) (i868402)
### Initial version established with the following features
* Establishes framework and Webdispatcher provisioning
* Sets up Role framework
* Provisions webdispatcher
