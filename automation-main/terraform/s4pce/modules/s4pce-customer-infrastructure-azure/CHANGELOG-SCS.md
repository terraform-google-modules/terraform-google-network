## 2025-03-03 | i868402
### ['enhancement', 's4pce', 'terraform'] | [MR 146](https://gitlab.core.sapns2.us/scs/ste/automation/-/merge_requests/146)
* [Jira Link]()  No Jira Link <!-- ACTION: Add Jira link-->
* Replace local-exec curl with data.http module, removes requirements on curl packages.
* Update Provider requirements
* Default US Region specific customization to false. Marked for relocation later.
* Added hidden advanced switch to turn off customer gateway deployment. This a production thing and just adds time to our test deployments. There's nothing we can use those for.

# Latest Version
2.0.0

# Version History
## Version 2.0.0 (2024-09-20) (i868402)
## Enhancement - Update for azuread and azurerm provider versions
* Remove terraform module version based on changelog.
  * gateways.tf
    * resource azurerm_public_ip
      * ln47 : string "availability_zone" changed to list(string) "zones"
  * main.tf
    * ln 5 : Removed metadata calculation dependency on Changelog.
    * ln 28 : Removed metadata calculation dependency on Changelog.
  * storage.tf
    * resource azurerm_storage_account
      * ln 47, 124 : attribute enable_https_traffic_only changed to https_traffic_only_enabled
      * ln 48, 125 : attribute min_tls_version added, defaults to `TLS1_2`
      * ln 49, 126 : attribute allow_nested_items_to_be_public defaults to false
  * subnets.tf
    * azurerm_subnet
      * ln20 : enforce_private_link_service_network_policies -> private_endpoint_network_policies, default to "Disabled"
      * ln21 : enforce_private_link_endpoint_network_policies -> private_link_service_network_policies_enabled, default to "false"
  * variables.tf
      * ln 85 : adv_storage_account_https_only_customer_backups created
        * Limits traffic to HTTPS only.  Matched previous default of true.
      * ln 90 : adv_storage_account_https_only_customer_nfs created
        * Limits traffic to HTTPS only.  Matched previous default of false.
      * ln 95 : adv_min_tls_version created
        * Sets minimum TLS Version. Default set to 1.2
      * ln 104 : adv_allow_nested_items_to_be_public created
        * Matches previous default of false. New Commercial Default is true.
      * ln 119 : adv_subnet_endpoint_network_policies created
        * Allows Different settings for Endpoint Network Policies. Not available in all regions. At minimum must be "Disabled" to support Private Links.
      * ln 119 : adv_subnet_service_network_policies created
        * * Allows Different settings for Endpoint Service Network Policies. Not available in all regions. At minimum must be "false" to support Private Links.
  * Provider Minimum Version updated
    * terraform: 1.5.7
    * azuread: 2.53.1
    * azurerm: 4.3.0
    * local: 2.5.2
    * null: 3.2.3

## Version 1.0.17 (0.14-000017) (2024-06-18) (i548219)
## Enhancement - Update lifecycle policy to apply only to backup blob container- PRODENGINEERING-457
* Update lifecycle policy to apply only to backup blob container- PRODENGINEERING-457

## Version 1.0.17 (0.14-000017) (2024-06-18) (i548219)
## Enhancement - Update lifecycle policy to retain storage networking ip rules - PRODENGINEERING-329
* Update lifecycle policy to keep all manually entered storage networking ip rules
* Required for operations to manage storage from bastions

## Version 1.0.16 (0.14-000016) (2024-05-19) (i744629)
## Enhancement - Make nat gateway creation optional
* The creation of NAT gateway should be optional when Azure Firewall is used

## Version 1.0.15 (0.14-000015) (2024-01-22) (i555365)
## Enhancement - Update lifecycle policy to apply specifically to backup blob - PE151
* Update lifecycle policy to apply specifically to backup blob - PE151
* Add variable to enable/disable main storage account lifecycle policy - PE151

## Version 1.0.14 (0.14-000014) (2023-11-06) (i555365)
## Enhancement - Add lifecycle rules to storage account - parameterize variables - PE122
* Add lifecycle rules to storage account - parameterize variables - PE122

## Version 1.0.13 (0.14-000013) (2023-09-29) (i568675)
### Enhancement - Add variable for specifying NFS Azure file share capacity quota
* Added `nfs_storage_quota` variable so that the storage capacity quota for the NFS Azure file share can be specified to be higher than the default (100 gigabytes) quota

## Version 1.0.12 (0.14-000012) (2023-06-29) (c5309336)
### Enhancement - Null Context Update
* Updated `terraform-null-context` to use `terraform-null-context/modules/legacy`

## Version 1.0.11 (2023-04-05) (c5355631)
## Enhancement - Add lifecycle rules to storage account
* Added lifecycle policies to move blobs to colder storage after 30 days and deleted after 180
* Versioned blobs are moved to colder storage after 30 days and deleted after 180

## Version 1.0.10 (0.14-000011)
### Bugfix - Storage account external command infinite loop on new customer build.
* The patch in version 1.0.9 only worked for existing customers.  It passed information that does not exist for new customers, causing an infinite loop.
* Modified the command to sleep instead of looping.

## Version 1.0.9 (0.14-000010) (2023-01-06) (i558332)
### Enhancement - Azure Storage Account Firewall Workaround
* enhanced existing workaround to loop until public ip exists in ACL before using Storage API

## Version 1.0.8 (0.14-000009) (2022-06-13) (i558332)
### Enhancement - Azure Storage Account Security Limitation Workaround
* Add external-run-command module to implement storage account security limitation workaround

## Version 1.0.7 (0.14-000008) (2022-05-27) (c5335697)
### Bugfix - Trailing zeros for NFS
* Trailing zeroes for usr/sap/trans NFS were incorrectly removed.

## Version 1.0.6 (0.14-000007) (2022-04-27) (c5335697)
### Enhancement - Azure region not supporting availability zone
* Fix code for Azure region not supporting availability zone

## Version 1.0.5 (0.14-000006) (2022-03-22) (i535751)
### Enhancement - Private link attributes for subnets set true
* Enabled private link attributes for subnets

## Version 1.0.4 (0.14-000005) (2022-02-22) (i868402)
### Enhancement - Support Dynamic Subnets
* Support dynamic subnets
* CM-14832

## Version 1.0.3 (0.14-000004) (2022-02-23) (i513825)
### Bugfix - Virtual Network Gateway IAM
* Ensure conditional logic wrapped around IAM role assignment for ops to manage virtual network gateways functions
* Terraform should not fail when feature is toggled `off` and pre-created `NS2-CreateVirtualNetworkGateway` Azure Role definition does not exist
* Leverage terraform `lookup()` function for pulling dictionary key/values that may or may not be present

## Version 1.0.2 (0.14-000003) (2022-01-14) (i558332)
### Enhancement - Virtual Network Gateway IAM
* Added IAM role assignment for ops to manage virtual network gateways

## Version 1.0.1 (0.14-000002) (2021-12-06) (i513825)
### Enhancement - Database Backups Storage Account
* Added additional storage account for database backups

### Bugfix - Add missing attribute for Edge Subnet
* Codified hand-jammed `enforce_private_link_endpoint_network_policies` attribute for edge subnet

### Bugfix - Storage Account naming
* Adjusted prefix schema for storage account creation to leverage abbreviated customer notation
* e.g. `customer0099` -> `c99`
* This drastically shortens storage account naming to accommodate Azure's 24 character maximum while leaving room for descriptive suffixes

## Version 1.0.0 (0.14-000001) (2021-11-10) (i513825)
### Initial version established with the following features
* VNet Creation
* Subnets Creation
*   Edge
*   Production
*   Quality Assurance
*   Development
* NAT Gateway Creation
*   Zone 1, 2, 3
* Route Table Creation
*   Route Tables Zones 1, 2, 3
*   Edge Subnet Route Table
* Network Security Group Creation
*   Global NSG for Customer VNet
* Applicatoin Security Group Creation
*   All-Egress
*   Inter-VNet for Customer
