> :warning: **NOTICE:** This module has been moved to https://gitlab.core.sapns2.us/scs/shared/terraform/terraform-external-run-command

# Latest Version
1.0.1 (0.13-000002)

# Version History
## Version 1.0.1 (2021-09-10) (i513825)
### Bugfix - Removed dependency checks as conditional logic incompatible with module dependency logic
* Logic to toggle helpful dependency checks breaks module when resource dependencies in use
* These module dependencies are listed in the README documentation
* Benefit of automatic detection of script dependencies does not outweigh need to be able to enforce resource dependency logic

## Version 1.0.0 (2021-06-29) (i513825)
### Initial version established with the following features
* Queries all IAM roles actively being used by an EC2 instance visible to the active AWS provider
