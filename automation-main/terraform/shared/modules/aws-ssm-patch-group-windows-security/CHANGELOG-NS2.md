# Latest Version
0.13-000008

# Version History
## Version 0.13-00008 (2022-05-19) (i868402)
### Bugfix - Fixed Default version selection
* Versions are limited to 20 items.
* Changed default to "All" which is actually represented as "*"

## Version 0.13-000007 (2021-06-10) (i511522)
### Enhancement - Add regex to module output
* Added regex to module output to prevent later version of AWS provider from changing output string
  * AWS provider version 3.44.0 adds the patch baseline ID in the resource output separated by a comma

## Version 0.13-000006 (2021-05-10) (c5309377)
### Bugfix - Update required_providers for terraform
* update versions.tf to the format required by Terraform 0.13 (and later)

## Version 0.12-000005 (2020-12-04) (i513825)
### Bugfix - OS coverage fix
* AWS SSM endpoint does not currently support `All` as an option despite what documentation and AWS support suggests
* Populating with up-to-date list of all currently supported OS versions that will have to be kept up-to-date to ensure patch coverage until AWS gets around to supporting the `All` option on their endpoint

## Version 0.12-000004 (2020-12-02) (i513825)
### Enhancement - add patch coverage for Windows
* Added `All` Windows versions to default covered versions

## Version 0.12-000003 (2020-08-19) (i868402)
### Documentation - Version and Validation
* Validated and added minimum versions
* Documented options for example root

### Bugfix - example root
* added missing description value to example root

## Version 0.12-000002 (2020-05-06) (i513825)
### Enhancement - Rename to `aws-ssm-patch-group-rhel-all`
* Added clarifying `-security` suffix to designate that this patch group by default enables `security` patches only

## Version 0.12-000001 (2020-03-01) (i513825)
### Initial version created with the following features
* Creates SSM patching baseline for Windows Systems
* Outputs ID to created Patch Group for the baseline to tag instances with
