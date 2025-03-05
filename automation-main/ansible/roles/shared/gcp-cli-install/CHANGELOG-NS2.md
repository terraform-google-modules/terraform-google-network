# Latest Version
2.9-000003

# Version History
## Version 2.9-000003 (2025-02-04) (i746373)
### sles 15 and rhel 9 support
* add support for rhel 9 and sles 15

## Version 2.9-000002 (2022-01-27) (i537609)
### Bugfix - Corrected Ansible distribution for tasks/main.yml
* Adds ` | lower` to ansible distribution in tasks/main.yml so role can find the correct install task.

## Version 2.9-000001 (2022-01-18) (i537609)
### Initial version of role created based off of the gcp-image-export role
* Installs the Google Cloud SDK on instance for CLI tools.
