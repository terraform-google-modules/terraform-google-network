# Latest Version
0.13-000007

# Version History
## Version 0.13-000007 (2021-09-03) (c5329049)
### Enhancement - Update required_providers for terraform
* assigned default value to module_dependency variable

## Version 0.13-000006 (2021-05-10) (c5309377)
### Bugfix - Update required_providers for terraform
* update versions.tf to the format required by Terraform 0.13 (and later)

## Version 0.12-000005 (2020-08-14) (i513825)
### Documentation - Version and Validation
* Validated and added minimum versions

## Version 0.12-000004 (i513825)
### Bugfix - remove providers from terraform modules
* Terraform will fail when when missing code for resources with provider declarations

## Version 0.12-000003 (i868402)
### Enhancement - Output
* Added Role Name to output
* Added Instance Profile Name to Output

## Version 0.12-000002 (i868402)
### Enhancement - Added support for terraform v0.12.11+
* Compatability fixes for terraform v0.12.11+
* Terraform now throws an error when referencing an element in an empty list instead of returning a null as before.
* Changed output of module to handle new terraform behavior.
* Changed syntax to match the new preferred syntax so it stops throwing warnings.

## Version 0.12-000001 (i868402)
### Initial version established with the following features
* Creates AWS IAM Role
* Associates with IAM Profile
* Attaches Policies to IAM Role
