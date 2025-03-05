s4-provisioning
================

This role will initialize provisioning of S4 instances after they have been created.  Where possible, the "tar installation" method will be used.

Requirements
------------

* Instances must have the correct EBS/EFS volumes sized and attached. See notes below
* Location of latest source locations.
* Local IP address for all instances to update the host file.
* Connectivity to the instances.  Typically VPN and private keys

Role Variables
--------------

General Variables:
* db_ipaddress: Private IP Address of the Hana server
* sapapp_ipaddress: Private IP Address of the Sapapp server
* sid: SAP Id (may be different for Hana and Sapapp)
* sidadm_uid: UID of the sid admin user. (may be different for Hana and Sapapp)
* extract_hana_tar_files: Which provisioning methodology to use.  Tar extraction or pre-exectracted.

Dependencies
------------
n/a

Notes
-----
* S4 Must be built in the correct order:  HANA DB, then SAPAPP
* Volume Sizing:

Minimum Defaults:

| ServerTYPE | RAM |
| ---------- | --- |
| HDB        | 256 |
| APP        | 32  |
| CPIDS      | 32  |
| WDISP      | 16  |

Sizing Chart:

| ServerTYPE | FileSystem     | Storage |
| ---------- | -------------- | ------- |
| HDB        | /hana/data     | 2 * RAM
||             /hana/log      | 0.5 * RAM
||             /hana/shared   | 1 * RAM (max 1TB)
||             /usr/sap       | 50GB
||             /hana/backups  | 2 * RAM
||             /hana/staging  | EFS
| App        | /usr/sap       | 50GB
||             /sapmnt        | 50 GB
||             /sap/staging   | EFS
||             /usr/sap/trans | EFS
||             SWAP           | See note below


SWAP Sizing:
* Physical Memory (RAM) Recommended Swap-Space
* \< 32 GByte 2 x RAM
* 32 - 63 GByte 64 GByte
* 64 - 127 GByte 96 GByte
* 128 - 255 GByte 128 GByte
* 256 - 511 GByte 160 GByte
* 512 - 1023 GByte 192 GByte
* 1024 - 2047 GByte 224 GByte
* 2048 - 4095 GByte 256 GByte
* 4096 - 8191 GByte 288 GByte
* \> 8192 GByte 320 GByte


License
-------

BSD

Author Information
------------------

louis.lee@sapns2.com
