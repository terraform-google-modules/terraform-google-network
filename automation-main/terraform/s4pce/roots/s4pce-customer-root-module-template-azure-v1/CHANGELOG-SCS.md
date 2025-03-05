## 2025-03-03 | i868402
### ['enhancement', 's4pce', 'terraform'] | [MR 146](https://gitlab.core.sapns2.us/scs/ste/automation/-/merge_requests/146)
* [Jira Link]()  No Jira Link <!-- ACTION: Add Jira link-->
* Replace local-exec curl with data.http module, removes requirements on curl packages.
* Update Provider requirements
* Default US Region specific customization to false. Marked for relocation later.
* Added hidden advanced switch to turn off customer gateway deployment. This a production thing and just adds time to our test deployments. There's nothing we can use those for.

# 2025-02-07 i868402
* Adds handling for legacy naming in the integrations/sftp module.

# 2025-01-16 i568675
* Add handling for migrating from legacy code bases to the edge-network integration
  * This should prevent resources needing to be recreated during migrations
* Move "legacy_endpoint" list from locals to a dedicated terraform variable for the edge-network integration

# 2024-11-13 i868402
* New Changelog format
* Update and Tested Root Templates with Recommended Versions

## Version 2.0.1 2024-10-2 (i868402)
### Enhancement - Update Envoy Values
* The old repo/values for Envoy Proxy have been removed and replaced with the new values.

## Version 2.0.0 2024-09-26 (i868402)
### Enhancement - Update Azure Provider Versions
All Azure provider versions have been updated to the latest versions.
* Layer-00
  * Pass through Advanced Variables created.
* Layer-01
  * splkoncall-logic-app.tf
    * File and Variables moved to _opt-splunk/splkoncall-logic-app.tf
  * backups.tf
    * resource azurerm_recovery_services_vault
      * ln 19 : Add adv_soft_delete. Default `true`, this behaves like a "recycle bin" for deleted backups.
* layer-02
  * instances.tf
    * module "instance_list"
      * ln 79 : source changed to use the fork azure-linux-virtual-machine
  * saprouter.tf
    * module "instance_saprouter"
      * ln 54 : source changed to use the fork azure-linux-virtual-machine
* integrations/edge-network/layer-00
  * customer-connectivity.tf
    * resource azurerm_public_ip
      * ln 26 : attribute availability_zone changed to zones
      * ln 26 : Changed from "Zone-Redundant" to all Zones found in layer-00
  * endpoints.tf
    * module endpoint_list
      * ln 29 : front_end_ip_zones behvior changed
        * If was set to "Zone-Redundant" then use "local.layer_00.unique_zones"
        * Otherwise use the value that was passed from "layer_00.lb_front_end_ip_zones"
        * NOTE!! Unable to test all scenarios.  Data Format likely needs to be changed for non redundant zones.
  * subnets.tf
    * resource azurerm_subnet
      * ln 14 : attribute enforce_private_link_endpoint_network_policies changed to private_endpoint_network_policies
      * ln 15 : attribute enforce_private_link_service_network_policies changed to private_link_service_network_policies_enabled
  * variables.tf
    * ln 54 : adv_subnet_endpoint_network_policies created
      * Allows Different settings for Endpoint Network Policies. Not available in all regions. At minimum must be "Disabled" to support Private Links.
    * ln 63 : adv_subnet_service_network_policies created
      * Allows Different settings for Endpoint Service Network Policies. Not available in all regions. At minimum must be "false" to support Private Links.
* integrations/reverse-private-link
  * endpoints.tf
    * module endpoint_list
      * ln 19 : front_end_ip_zones behvior changed
        * If was set to "Zone-Redundant" then use "local.layer_00.unique_zones"
        * Otherwise use the value that was passed from "layer-00.lb_front_end_ip_zones"
        * NOTE!! Unable to test all scenarios.  Data Format likely needs to be changed for non redundant zones.
  * vm.tf
    * module proxy_vm
      * ln 9: source changed to use the fork [azure-linux-virtual-machine](#azure-linux-virtual-machine)
      * ln 21 : zone changed from null to local.layer_00.unique_zones[0]
* integrations/sftp
  * main.tf
    * module "lb"
      * ln 43 : front_end_ip_zones behvior changed
        * If was set to "Zone-Redundant" then use "local.layer_00.unique_zones"
        * Otherwise use the value that was passed from "layer-00.lb_front_end_ip_zones"
        * NOTE!! Unable to test all scenarios.  Data Format likely needs to be changed for non redundant zones.

## Version 1.0.5 2024-09-05 (i868402)
### Enhancement - Relative Paths
* Updated relative paths to support new Repo structure

## Version 1.0.4 2024-06-11 (i868402)
### Bugfix - Typos
* Fixed some typos in templated values

## Version 1.0.3 2024-05-31 (i868402, i743694, i571239)
### Enhancment - Envoy Proxy
* Replace HAProxy with Envoy Proxy
* Boostrap Deployment of Envoy with configuration
* L7 TCP Proxy with DNS Resolution of Upstream Target

## Version 1.0.2 2024-04-29 (i868402)
### Enhancment - Management Key
* Add EXAMPLE_MANAGEMENT_KEY to support alternate management deployments

## Version 1.0.1 2024-04-23 (i868402)
### Enhancment - Image
* Update Image Value
### Update - Regex
* Update Regex Value for DynamoDB

## Version 1.0.0 2024-04-09 (i868402)
### Initial version established with the following features
* S4PCE Customer Root Module Template
