# Latest Version
2.9-000002

# Version History
## Version 2.9-000002 (2022-06-24) (c5332214)
### Enhancement - Removed fips-check and work around
* Removed checks and work arounds for fips-enabled RHEL 8 instances
* Workaround no longer needed for `azure-cli` installation with updated repository package from the vendor

## Version 2.9-000001 (2022-01-21) (i537609)
### Initial version of role created based off of tasks in the Base role
* Installs the Azure CLI on Redhat 7, 8, or Ubuntu 18.04 systems
* Molecule tests for fips enabled and disabled systems
