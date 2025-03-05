# Latest Version
2.0.0 (1.57-000001)

# Version History
## Version 2.0.0 (2024-09-20) (i868402)
### Enhancement - Update AzureRM Provider Update
* main.tf
  * ln 7 : Update path to logging file
* network-interface.tf
  * ln 15 : attribute availability_zone changed to zones []
  * ln 15 : If var.zone passed as `null` then use `var.adv_public_ip_zones` to set the zone(s).
* variables.tf
  * ln 88 : Default value for `zone` is now `null`
  * ln 229 : Variable adv_public_ip_zones added
    * This is an advanced variable. If `zone` is passed as `null`, then this variable will be used to set the zone(s) for the public IP.
    * Normal behavior is to use the zone passed in `zone` variable.
* virtual-machine.tf
* Provider Minimum Version updated
  * terraform: 1.5.7
  * azurerm: 4.3.0

## Version 1.0.13 (2024-09-33) (i548219)
### Enhancement - Allow linux vm public key modification -PRODENGINEERING-508
* Allow changing the customer ssh_customer_public_key in layer-00/terraform.tfvars without rebuilding instance
* Add admin_ssh_key to the azure instance lifecycle policy

## Version 1.0.12 (2024-06-03) (i744629)
### Enhancement - availability set
* for azure region without zone support, availability set can be used to support high availability (near range DR)

## Version 1.0.11 (2023-06-14) (c5309336)
### Enhancement - Null Context Update
* Updated `terraform-null-context` to use `terraform-null-context/modules/legacy`

## Version 1.0.10 (2022-12-08) (c5335697)
## Bug fixing
* updated proivder from 'azurerm' to 'aws'

## Version 1.0.9 (0.14-000010) (2022-11-17) (i511522)
### Enhancement - Add subnet id output
* Added VM subnet ID to outputs

## Version 1.0.8 (0.14-000009) (2022-08-24) (i561481)
### Enhancement - Add principal id output
* Added VM principal ID to outputs

## Version 1.0.7 (0.14-000008) (2022-04-26) (c5335697)
### Enhancement - Ignore image tags
* fixed data type for variable custom_bootstrap, it should be string instead of bool

## Version 1.0.6 (0.14-000007) (2022-04-27) (c5335697)
### Enhancement - Azure region not supporting availability zone
* Fix code for Azure region not supporting availability zone

## Version 1.0.5 (0.14-000006) (2022-02-22) (i868402)
### Enhancement - Ignore image tags
* Ignore image tags

## Version 1.0.4 (0.14-000005) (2021-12-07) (i513825)
### Enhancement - System-Managed Identity Permissions
* Implement ability to pass custom scoped permissions to assign to the VM's System-Managed Identity

## Version 1.0.3 (0.14-000004) (2021-12-02) (i513825)
### Enhancement - Tags Output
* Output VM tags

## Version 1.0.2 (0.14-000003) (2021-11-19) (i868402)
### Enhancement - Managed Identity
* Add System Managed Identities.

## Version 1.0.1 (0.14-000002) (2021-10-27) (i513825)
### Enhancement - Documentation Updates
* Ensure variable list is properly documentated in README

### Enhancement - Default admin user
* Set default admin_username for Azure virtual machines to `cloud-user`

### Bugfix - Azure Image Search
* Implement logic to support for both regex search as well as searching for Azure images with an explicit name

## Version 1.0.0 (0.14-000001) (2021-10-26) (i513825)
### Initial version established with the following features
* Creates Azure Linux Virtual Machine
* Creates and attaches network interface
* Managed private DNS records
