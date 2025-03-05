# Latest Version
0.13-000009

# Version History
## Version 0.13-00009 (2022-05-19) (i868402)
### Bugfix - Fixed Default version selection
* Versions are limited to 20 items.
* Changed default to "All" which is actually represented as "*"

## Version 0.13-00008 (2022-05-13) (i555365)
### Enhancement - Expand OS coverage to include rhel 8.4 and 8.5
* Add rhel 8.4 and 8.5 to supported list of rhel OS versions that AWS SSM supports for patching - CM-15610

## Version 0.13-000007 (2021-06-10) (i511522)
### Enhancement - Add regex to module output
* Added regex to module output to prevent later version of AWS provider from changing output string
  * AWS provider version 3.44.0 adds the patch baseline ID in the resource output separated by a comma

## Version 0.13-000006 (2021-05-10) (c5309377)
### Bugfix - Update required_providers for terraform
* update versions.tf to the format required by Terraform 0.13 (and later)

## Version 0.12-000005 (2021-01-21) (i513825)
### Enhancement - Expand OS coverage to rhel 7.9 and 8.3
* Add rhel 7.9 and 8.3 to supported list of rhel OS versions now that AWS SSM has released support for patching them

## Version 0.12-000004 (2020-12-04) (i513825)
### Bugfix - OS coverage fix
* AWS SSM endpoint does not currently support `All` as an option despite what documentation and AWS support suggests
* Populating with up-to-date list of all currently supported OS versions that will have to be kept up-to-date to ensure patch coverage until AWS gets around to supporting the `All` option on their endpoint

## Version 0.12-000003 (2020-12-02) (i513825)
### Enhancement - add patch coverage for RHEL 8
* Added `All` RHEL versions to default covered versions

## Version 0.12-000002 (2020-08-19) (i868402)
### Documentation - Version and Validation
* Validated and added minimum versions
* Documented options for example root

### Bugfix - example root
* added missing description value to example root

## Version 0.12-000001 (2020-05-11) (i513825)
### Initial version created with the following features
* Copies `aws-ssm-patch-group-rhel-all` and isolates application of only `security` patches
