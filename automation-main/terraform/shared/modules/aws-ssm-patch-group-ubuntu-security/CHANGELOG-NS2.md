# Latest Version
0.13-000005

# Version History
## Version 0.13-00005 (2022-05-19) (i868402)
### Bugfix - Fixed Default version selection
* Versions are limited to 20 items.
* Changed default to "All" which is actually represented as "*"

## Version 0.13-000004 (2021-06-10) (i511522)
### Enhancement - Add regex to module output
* Added regex to module output to prevent later version of AWS provider from changing output string
  * AWS provider version 3.44.0 adds the patch baseline ID in the resource output separated by a comma

## Version 0.13-000003 (2021-05-10) (c5309377)
### Bugfix - Update required_providers for terraform
* update versions.tf to the format required by Terraform 0.13 (and later)

## Version 0.12-000002 (2020-12-14) (i513825)
### Bugfix - module example-root kernel patch filtering
* In module `example-root`, fix prefixing for filtering out kernel patches on Ubuntu systems
    * `kernel-` (RedHat patch prefix) -> `linux-` (Ubuntu patch prefix)

## Version 0.12-000001 (2020-12-03) (i513825)
### Initial version created with the following features
* Copies `aws-ssm-patch-group-rhel-security` module and applies identical patches targetd for Ubuntu systems
