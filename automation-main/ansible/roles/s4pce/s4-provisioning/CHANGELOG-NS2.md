# Latest Version
2.9-000005

# Version History

## Version 2.9-000005 (2024-01-15) (i535751)
### Bugfix - Revert terraform_inventory.j2 to force size casing standards
* Upgdate the s4pce/templates/terraform_inventory.j2 to remove case complicance for instance types

## Version 2.9-000004 (2023-11-07) (c5356919)
### Bugfix - Update terraform_inventory.j2 to address upper case inventory files
* Upgdate the s4pce/templates/terraform_inventory.j2 to address case sensetive issues in input inventory files

## Version 2.9-000003 (2022-01-18) (c5323009)
### Bugfix - Updated galaxy_info variables missing breaking molecule test runner
* Added role_name and namespace variables if missing broke molecule test runner

## Version 2.9-000002 (2021-05-05) (c5323009)
### Bugfix - Updated ns2-scp-dev.sapns2.us domain to gitlab.core.sapns2.us
* Updated issue_tracker_url variable using old gitlab domain to new core services domain

## Version 2.9-000001 (2020-03-03) (i868402)
### Initial version established with the following features
* Provisions S4 HANA DB
* Provisions S4 SAPAPP
