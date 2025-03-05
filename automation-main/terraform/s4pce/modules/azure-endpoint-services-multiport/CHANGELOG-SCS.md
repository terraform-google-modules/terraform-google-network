# 2025-02-07 i868402
* using new changelog format
* Adds advanced variable to null the loadbalancer zone in the front-end ip config

## Version 2.0.0 (2024-09-20) (i868402)
### Enhancement - Update AzureRM Provider Update
* loadbalancer.tf
  * resource azurerm_lb
    * ln40 : public_ip_address_id default set to `null` instead of ""
    * ln44 : availability_zone -> zones. This is a list(string) now. This is now a mandatory value.
  * resource azurerm_lb_probe
    * ln70 : remove attribute resource_group_name. No longer required.
  * resource azurerm_lb_rule
    * ln 72 : remove attribute resource_group_name. No longer required.
* variables.tf
  * ln 120 : front_end_ip_zones. Changed type to list(string). Default removed, making this a mandatory variable
* Provider Minimum Version updated
  * terraform: 1.5.7
  * azurerm: 4.3.0

## Version 1.0.4 (2023-06-14) (c5309336)
### Enhancement - Null Context Update
* Updated `terraform-null-context` to use `terraform-null-context/modules/legacy`

## Version 1.0.3 (0.14-000003) (2022-07-28) (c5335697)
### Enhancement  with the following features
* Add varialbe 'front_end_ip_zones' to handle no-zone in certain azure regions

## Version 1.0.2 (0.14-000003) (2022-01-14) (i868402)
### Enhancement - Variable for loadbalancer name
* Add input for variable name
* Update examples for module for new variable

## Version 1.0.1 (0.14-000002) (2021-11-23) (c5335697)
### Enhancement  with the following features
* Load balancer with multiple backend pools
* Load balancer with multiple frontend ips
* Support both dynamic and static frontend ips

## Version 1.0.0 (0.14-000001) (2021-11-23) (c5327313)
### Initial version established with the following features
* Azure Private Link Endpoint
