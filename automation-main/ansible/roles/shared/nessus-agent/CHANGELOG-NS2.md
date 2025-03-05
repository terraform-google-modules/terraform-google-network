# Latest Version
2.9-000009

# Version History
## Version 2.9-000009 (2023-04-16) (i548447)
### Enahancement - Removing country specific validations as these will need to be moved into correct country boundary playbooks/roles.

## Version 2.9-000008 (2022-09-09) (c5283389)
### Bugfix - local binary check delegated to localhost
* check for local binary to copy from should only be done on the localhost
### Enhancement - add slash to local binary paths
* slash added to paths for local binary to avoid errors if user forgets to add a trailing slash when defining the local binary path and updated related examples

## Version 2.9-000007 (2022-09-06) (c5283389)
### Enhancement - Add ability to copy binary from local and updated the nessus agent group regex check
* Add ability to copy binary from local Ansible controller if pulling from AWS S3 is not an option as in the case of GCP server instances.
* Updated the regex for the nessus agent group dependency check to include new environments

## Version 2.9-000006 (2022-05-25) (c5309377)
### Bugfix - Update dependency check regex
* Once again allows non-PCE as valid `nessus_agent_group`'s

## Version 2.9-000005 (2022-01-27) (i514383)
### Bugfix - Updated dependency check
* Updated regex dependency check to include CRE-S4-PCE as a valid input

## Version 2.9-000004 (2022-01-18) (c5323009)
### Bugfix - Updated galaxy_info variables missing breaking molecule test runner
* Added role_name and namespace variables if missing broke molecule test runner

## Version 2.9-000003 (2021-05-05) (c5323009)
### Bugfix - Updated ns2-scp-dev.sapns2.us domain to gitlab.core.sapns2.us
* Updated issue_tracker_url variable using old gitlab domain to new core services domain

## Version 2.9-000002 (2021-03-31) (i513825)
### Bugfix - disable gpg checking
* Disabled gpg checking on nessus agent rpm/deb installation

## Version 2.9-000001 (2021-03-03) (i513825)
### Initial version established with the following features
* Ports existing `nessus-configure-agent.yml` standalone playbook into Role.
