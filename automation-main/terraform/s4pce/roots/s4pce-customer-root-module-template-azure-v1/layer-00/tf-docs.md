# layer-00

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.7 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.53.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 4.3.0 |
| <a name="requirement_external"></a> [external](#requirement\_external) | 2.3.4 |
| <a name="requirement_http"></a> [http](#requirement\_http) | 3.4.5 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.5.2 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.3 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.3.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_context"></a> [base\_context](#module\_base\_context) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_layer_context"></a> [layer\_context](#module\_layer\_context) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_s4pce_customer_infrastructure"></a> [s4pce\_customer\_infrastructure](#module\_s4pce\_customer\_infrastructure) | EXAMPLE_SOURCE/terraform/s4pce/modules/s4pce-customer-infrastructure-azure | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/data-sources/subscription) | data source |
| [terraform_remote_state.management_layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_identifier"></a> [account\_identifier](#input\_account\_identifier) | (Optional) The specific account that resources are being deployed for for when a single line of business has components separated into separate designated accounts | `object({ name = string, formatted = string, friendly = string })` | <pre>{<br/>  "formatted": null,<br/>  "friendly": null,<br/>  "name": null<br/>}</pre> | no |
| <a name="input_adv_allow_nested_items_to_be_public"></a> [adv\_allow\_nested\_items\_to\_be\_public](#input\_adv\_allow\_nested\_items\_to\_be\_public) | (Optional) Allow nested items to be public | `bool` | `false` | no |
| <a name="input_adv_min_tls_version"></a> [adv\_min\_tls\_version](#input\_adv\_min\_tls\_version) | (Optional) The minimum TLS version required for the Storage Account | `string` | `"TLS1_2"` | no |
| <a name="input_adv_storage_account_https_only_customer_backups"></a> [adv\_storage\_account\_https\_only\_customer\_backups](#input\_adv\_storage\_account\_https\_only\_customer\_backups) | (Optional) Enable HTTPS only for the Backups Storage Account | `bool` | `true` | no |
| <a name="input_adv_storage_account_https_only_customer_nfs"></a> [adv\_storage\_account\_https\_only\_customer\_nfs](#input\_adv\_storage\_account\_https\_only\_customer\_nfs) | (Optional) Enable HTTPS only for the NFS Storage Account | `bool` | `false` | no |
| <a name="input_adv_subnet_endpoint_network_policies"></a> [adv\_subnet\_endpoint\_network\_policies](#input\_adv\_subnet\_endpoint\_network\_policies) | (Optional) Enable/Disable network policies for private endpoints | `string` | `"Disabled"` | no |
| <a name="input_adv_subnet_service_network_policies"></a> [adv\_subnet\_service\_network\_policies](#input\_adv\_subnet\_service\_network\_policies) | (Optional) Enable/Disable network policies for service endpoints | `bool` | `false` | no |
| <a name="input_azure_environment"></a> [azure\_environment](#input\_azure\_environment) | Azure Cloud Environment (e.g. usgovernment, public) | `string` | n/a | yes |
| <a name="input_azure_region"></a> [azure\_region](#input\_azure\_region) | Azure Region | `string` | n/a | yes |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | Azure Subscription ID | `string` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `string` | n/a | yes |
| <a name="input_business"></a> [business](#input\_business) | The line of business resources are being deployed for | `object({ name = string, formatted = string, friendly = string })` | <pre>{<br/>  "formatted": null,<br/>  "friendly": null,<br/>  "name": null<br/>}</pre> | no |
| <a name="input_business_subsection"></a> [business\_subsection](#input\_business\_subsection) | (Optional) The sub-security boundary being deployed into for when a single line of business is broken up into multiple logical components | `object({ name = string, formatted = string, friendly = string })` | <pre>{<br/>  "formatted": null,<br/>  "friendly": null,<br/>  "name": null<br/>}</pre> | no |
| <a name="input_cloud_partition"></a> [cloud\_partition](#input\_cloud\_partition) | (Optional) The specific cloud provider partition | `object({ name = string, formatted = string, friendly = string })` | <pre>{<br/>  "formatted": null,<br/>  "friendly": null,<br/>  "name": null<br/>}</pre> | no |
| <a name="input_cloud_provider"></a> [cloud\_provider](#input\_cloud\_provider) | (Optional) The cloud provider being deployed into | `object({ name = string, formatted = string, friendly = string })` | <pre>{<br/>  "formatted": null,<br/>  "friendly": null,<br/>  "name": null<br/>}</pre> | no |
| <a name="input_customer"></a> [customer](#input\_customer) | (Default within context: scs) Customer that uses the deployed system; e.g. `scs`, `management`, `customer####` | `object({ name = string, single_tenant = bool, formatted = string, friendly = string })` | <pre>{<br/>  "formatted": null,<br/>  "friendly": null,<br/>  "name": null,<br/>  "single_tenant": null<br/>}</pre> | no |
| <a name="input_delete_after_days"></a> [delete\_after\_days](#input\_delete\_after\_days) | Delete after days since modification greater than | `number` | `180` | no |
| <a name="input_deployment_layer"></a> [deployment\_layer](#input\_deployment\_layer) | (Optional) Layer of Terraform module deployment | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment classification being deployed into; e.g. `development`, `production` | `string` | n/a | yes |
| <a name="input_golden_image_resource_group"></a> [golden\_image\_resource\_group](#input\_golden\_image\_resource\_group) | The resource group of the shared Golden Images for this subscription | `string` | n/a | yes |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | (Default set within context) Ordering of the labels to be picked up by the environment's base\_context; used for resource name prefixing | `list(string)` | `null` | no |
| <a name="input_lb_front_end_ip_zones"></a> [lb\_front\_end\_ip\_zones](#input\_lb\_front\_end\_ip\_zones) | (Optional) zones/types for frontend IP. Could be a single zone, zone-redundant or no-zone | `string` | `"Zone-Redundant"` | no |
| <a name="input_minor_security_boundary"></a> [minor\_security\_boundary](#input\_minor\_security\_boundary) | (Optional) The minor security boundary being deployed into for when a single line of business or business subsection is instantiated more than once within the same security boundary for the purposes of having a staging stack tightly coupled to the production stack | `object({ name = string, formatted = string, friendly = string })` | <pre>{<br/>  "formatted": null,<br/>  "friendly": null,<br/>  "name": null<br/>}</pre> | no |
| <a name="input_nfs_storage_quota"></a> [nfs\_storage\_quota](#input\_nfs\_storage\_quota) | (Optional) The storage capacity quota (in gigabytes) for the NFS Azure file share used by the transport directory (/usr/sap/trans) and SFTP | `number` | `200` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | The organization this work belongs to | `object({ name = string, formatted = string, friendly = string })` | <pre>{<br/>  "formatted": null,<br/>  "friendly": null,<br/>  "name": null<br/>}</pre> | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Email address directing communication to the party responsible for the system; e.g., `isso@sapscs.com`, `isse@sapsscs.com`, `dhibpops@sapscs.com` | `string` | n/a | yes |
| <a name="input_root_module"></a> [root\_module](#input\_root\_module) | Name of Terraform root module responsible for provisioning resources | `string` | n/a | yes |
| <a name="input_security_boundary"></a> [security\_boundary](#input\_security\_boundary) | The information security boundary being deployed into | `object({ name = string, formatted = string, friendly = string })` | <pre>{<br/>  "formatted": null,<br/>  "friendly": null,<br/>  "name": null<br/>}</pre> | no |
| <a name="input_ssh_customer_public_key"></a> [ssh\_customer\_public\_key](#input\_ssh\_customer\_public\_key) | SSH public key for customer instances | `any` | n/a | yes |
| <a name="input_tier_to_archive_days"></a> [tier\_to\_archive\_days](#input\_tier\_to\_archive\_days) | Tier to archive after days since modification greater than | `number` | `60` | no |
| <a name="input_tier_to_cool_days"></a> [tier\_to\_cool\_days](#input\_tier\_to\_cool\_days) | Tier to cool after days since modification greater than | `number` | `30` | no |
| <a name="input_vnet_cidr_block"></a> [vnet\_cidr\_block](#input\_vnet\_cidr\_block) | CIDR block for the customer VNet | `string` | n/a | yes |
| <a name="input_vnet_gateway_permissions_enable"></a> [vnet\_gateway\_permissions\_enable](#input\_vnet\_gateway\_permissions\_enable) | This appears to be a region specific setting.  We should move this to layer-options. | `bool` | `true` | no |
| <a name="input_vnet_subnets"></a> [vnet\_subnets](#input\_vnet\_subnets) | Customer VNet Subnets, their CIDR blocks, and respective deployment zones. Subnet 'edge' is required. | `map(object({ cidr = string, zone = string }))` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_az_letter_mapping"></a> [az\_letter\_mapping](#output\_az\_letter\_mapping) | n/a |
| <a name="output_base_context"></a> [base\_context](#output\_base\_context) | #### Pass Inputs to Dependent Terraform Layers |
| <a name="output_golden_image_resource_group"></a> [golden\_image\_resource\_group](#output\_golden\_image\_resource\_group) | #### Golden AMIs |
| <a name="output_infrastructure"></a> [infrastructure](#output\_infrastructure) | ##### Infrastructure |
| <a name="output_lb_front_end_ip_zones"></a> [lb\_front\_end\_ip\_zones](#output\_lb\_front\_end\_ip\_zones) | n/a |
| <a name="output_ssh_customer_public_key"></a> [ssh\_customer\_public\_key](#output\_ssh\_customer\_public\_key) | #### SSH Keypairs |
| <a name="output_unique_zones"></a> [unique\_zones](#output\_unique\_zones) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
