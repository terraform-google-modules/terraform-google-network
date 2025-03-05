# Latest Version
2.0.0 (1.5.7-000001)

# Version History
## Version 2.0.0 (2024-09-26) (i868402)
### AzureRM Provider Update
* main.tf
  * resource azurerm_linux_virtual_machine_scale_set
    * ln 23 : "scale_in_policy" attribute replaced with "scale_in" block.
    * ln 24 : "rule" attribute for "scale_in" block. Matches previous settings.
    * ln 25 : "force_deletion_enabled" attribute for "scale_in" block. Matches previous settings.
* Provider Minimum Version updated
  * terraform: 1.5.7
  * azurerm: 4.3.0
  * external: 2.3.4


## Version 1.0.1 (2022-07-06) (c5335697)
### Initial version established with the following features
* Associate application security groups with VMSS for access (infra module uses asg for access control)

## Version 1.0.0 (2022-06-30) (c5335697)
### Initial version established with the following features
* create VM scaleset with manual scaling for SFTP
