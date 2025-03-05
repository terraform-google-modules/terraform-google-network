# s4pce-customer-infrastructure-azure

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.53.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.3.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.5.2 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.2.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >= 2.53.1 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 4.3.0 |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_context_application_sg_customer_egress_all"></a> [context\_application\_sg\_customer\_egress\_all](#module\_context\_application\_sg\_customer\_egress\_all) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_application_sg_customer_vnet_all"></a> [context\_application\_sg\_customer\_vnet\_all](#module\_context\_application\_sg\_customer\_vnet\_all) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_create_virtual_network_gateway"></a> [context\_create\_virtual\_network\_gateway](#module\_context\_create\_virtual\_network\_gateway) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_nat_customer"></a> [context\_nat\_customer](#module\_context\_nat\_customer) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_network_sg_customer_global"></a> [context\_network\_sg\_customer\_global](#module\_context\_network\_sg\_customer\_global) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_public_ip_customer_nat"></a> [context\_public\_ip\_customer\_nat](#module\_context\_public\_ip\_customer\_nat) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_rtb_customer"></a> [context\_rtb\_customer](#module\_context\_rtb\_customer) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_rtb_customer_edge"></a> [context\_rtb\_customer\_edge](#module\_context\_rtb\_customer\_edge) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_sg_rule_deafult_deny_all"></a> [context\_sg\_rule\_deafult\_deny\_all](#module\_context\_sg\_rule\_deafult\_deny\_all) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_sg_rule_default_load_balancer_allow"></a> [context\_sg\_rule\_default\_load\_balancer\_allow](#module\_context\_sg\_rule\_default\_load\_balancer\_allow) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_storage_container_customer_backups"></a> [context\_storage\_container\_customer\_backups](#module\_context\_storage\_container\_customer\_backups) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_storage_customer_backups"></a> [context\_storage\_customer\_backups](#module\_context\_storage\_customer\_backups) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_storage_customer_nfs"></a> [context\_storage\_customer\_nfs](#module\_context\_storage\_customer\_nfs) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_storage_customer_nfs_usr_sap_trans"></a> [context\_storage\_customer\_nfs\_usr\_sap\_trans](#module\_context\_storage\_customer\_nfs\_usr\_sap\_trans) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_module_context"></a> [module\_context](#module\_module\_context) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_storage_permissions"></a> [storage\_permissions](#module\_storage\_permissions) | ../../../shared/modules/terraform-external-run-command | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_application_security_group.customer_egress_all](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_security_group) | resource |
| [azurerm_application_security_group.customer_vnet_all](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_security_group) | resource |
| [azurerm_nat_gateway.customer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |
| [azurerm_nat_gateway_public_ip_association.customer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association) | resource |
| [azurerm_network_security_group.customer_global](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.customer_default_deny_all](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.customer_default_load_balancer_allow](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.customer_egress_all](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.customer_vnet_all_ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_private_dns_zone_virtual_network_link.customer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_public_ip.customer_nat](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.customer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.create_virtual_network_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_route_table.customer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_route_table.customer_edge](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_storage_account.customer_backups](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account.customer_nfs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account_network_rules.customer_nfs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_network_rules) | resource |
| [azurerm_storage_container.customer_backups](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_management_policy.azure_storage_account_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |
| [azurerm_storage_share.customer_nfs_usr_sap_trans](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |
| [azurerm_subnet.customer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_nat_gateway_association.customer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet_network_security_group_association.customer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.customer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_subnet_route_table_association.customer_edge](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_virtual_network.customer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azuread_group.sg_operations](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_role_definition.custom_create_virtual_network_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_subscription.subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [http_http.my_ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adv_allow_nested_items_to_be_public"></a> [adv\_allow\_nested\_items\_to\_be\_public](#input\_adv\_allow\_nested\_items\_to\_be\_public) | (Optional) Allow nested items to be public | `bool` | `false` | no |
| <a name="input_adv_min_tls_version"></a> [adv\_min\_tls\_version](#input\_adv\_min\_tls\_version) | (Optional) The minimum TLS version required for the Storage Account | `string` | `"TLS1_2"` | no |
| <a name="input_adv_storage_account_https_only_customer_backups"></a> [adv\_storage\_account\_https\_only\_customer\_backups](#input\_adv\_storage\_account\_https\_only\_customer\_backups) | (Optional) Enable HTTPS only for the Backups Storage Account | `bool` | `true` | no |
| <a name="input_adv_storage_account_https_only_customer_nfs"></a> [adv\_storage\_account\_https\_only\_customer\_nfs](#input\_adv\_storage\_account\_https\_only\_customer\_nfs) | (Optional) Enable HTTPS only for the NFS Storage Account | `bool` | `false` | no |
| <a name="input_adv_subnet_endpoint_network_policies"></a> [adv\_subnet\_endpoint\_network\_policies](#input\_adv\_subnet\_endpoint\_network\_policies) | (Optional) Enable/Disable network policies for private endpoints | `string` | `"Disabled"` | no |
| <a name="input_adv_subnet_service_network_policies"></a> [adv\_subnet\_service\_network\_policies](#input\_adv\_subnet\_service\_network\_policies) | (Optional) Enable/Disable network policies for service endpoints | `bool` | `false` | no |
| <a name="input_context"></a> [context](#input\_context) | n/a | <pre>object({<br/>    account_id             = string<br/>    additional_tags        = map(string)<br/>    build_user             = string<br/>    business               = string<br/>    customer               = string<br/>    delimiter              = string<br/>    environment            = string<br/>    environment_salt       = string<br/>    generated_by           = string<br/>    include_customer_label = bool<br/>    label_order            = list(string)<br/>    managed_by             = string<br/>    module                 = string<br/>    module_version         = string<br/>    name_prefix            = string<br/>    organization           = string<br/>    owner                  = string<br/>    partition              = string<br/>    parent_module          = string<br/>    parent_module_version  = string<br/>    regex_replace_chars    = string<br/>    region                 = string<br/>    root_module            = string<br/>    security_boundary      = string<br/><br/>    custom_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    environment_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    module_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    resource_tags = list(<br/>      object({<br/>        name         = string<br/>        value        = string<br/>        required     = bool<br/>        pass_context = bool<br/>      })<br/>    )<br/><br/>  })</pre> | `null` | no |
| <a name="input_create_nat_gateway"></a> [create\_nat\_gateway](#input\_create\_nat\_gateway) | whether to create nat gateways or not | `bool` | `true` | no |
| <a name="input_delete_after_days"></a> [delete\_after\_days](#input\_delete\_after\_days) | Delete after days since modification greater than | `number` | `180` | no |
| <a name="input_dns_zone"></a> [dns\_zone](#input\_dns\_zone) | (Optional) FQDN of the private hosted zone for the DNS Domain | `string` | `null` | no |
| <a name="input_lifecyeclepolicy"></a> [lifecyeclepolicy](#input\_lifecyeclepolicy) | (Optional) Whether or not lifecyle policy is enabled for main storage bucket | `bool` | `true` | no |
| <a name="input_nfs_storage_quota"></a> [nfs\_storage\_quota](#input\_nfs\_storage\_quota) | (Optional) The storage capacity quota (in gigabytes) for the NFS Azure file share used by the transport directory (/usr/sap/trans) and SFTP | `number` | `100` | no |
| <a name="input_tier_to_archive_days"></a> [tier\_to\_archive\_days](#input\_tier\_to\_archive\_days) | Tier to archive after days since modification greater than | `number` | `60` | no |
| <a name="input_tier_to_cool_days"></a> [tier\_to\_cool\_days](#input\_tier\_to\_cool\_days) | Tier to cool after days since modification greater than | `number` | `30` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | (Optional) Whether or not versioning is enabled for Storage Account | `bool` | `false` | no |
| <a name="input_vnet_cidr_block"></a> [vnet\_cidr\_block](#input\_vnet\_cidr\_block) | CIDR block for the customer VNet | `any` | n/a | yes |
| <a name="input_vnet_gateway_permissions_enable"></a> [vnet\_gateway\_permissions\_enable](#input\_vnet\_gateway\_permissions\_enable) | (Optional) This seems to be a region specific customization. Need to move it to Layer-Options | `bool` | `false` | no |
| <a name="input_vnet_subnets"></a> [vnet\_subnets](#input\_vnet\_subnets) | Configuration block for provisioning the customer subnets, subnet 'edge' is required | `map(object({ cidr = string, zone = string }))` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backups_container"></a> [backups\_container](#output\_backups\_container) | n/a |
| <a name="output_backups_storage_account"></a> [backups\_storage\_account](#output\_backups\_storage\_account) | ## Backups |
| <a name="output_context"></a> [context](#output\_context) | #### Pass Inputs to Dependent Terraform Layers |
| <a name="output_nat_gateways"></a> [nat\_gateways](#output\_nat\_gateways) | #### NAT Gateways |
| <a name="output_network_security_group_customer_global"></a> [network\_security\_group\_customer\_global](#output\_network\_security\_group\_customer\_global) | ##### Security Groups ## Network |
| <a name="output_nfs_storage_account"></a> [nfs\_storage\_account](#output\_nfs\_storage\_account) | ## NFS |
| <a name="output_nfs_usr_sap_trans"></a> [nfs\_usr\_sap\_trans](#output\_nfs\_usr\_sap\_trans) | n/a |
| <a name="output_private_dns_enabled"></a> [private\_dns\_enabled](#output\_private\_dns\_enabled) | #### Private DNS |
| <a name="output_private_dns_zone"></a> [private\_dns\_zone](#output\_private\_dns\_zone) | n/a |
| <a name="output_resource_group_customer"></a> [resource\_group\_customer](#output\_resource\_group\_customer) | #### Resource Groups |
| <a name="output_route_table_edge"></a> [route\_table\_edge](#output\_route\_table\_edge) | n/a |
| <a name="output_route_tables"></a> [route\_tables](#output\_route\_tables) | #### Route Tables |
| <a name="output_security_group_customer_egress_all"></a> [security\_group\_customer\_egress\_all](#output\_security\_group\_customer\_egress\_all) | n/a |
| <a name="output_security_group_customer_vnet_all"></a> [security\_group\_customer\_vnet\_all](#output\_security\_group\_customer\_vnet\_all) | n/a |
| <a name="output_storage_prefix"></a> [storage\_prefix](#output\_storage\_prefix) | #### Storage |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | #### Subnets |
| <a name="output_vm_base_security_groups"></a> [vm\_base\_security\_groups](#output\_vm\_base\_security\_groups) | ## Application |
| <a name="output_vnet_customer"></a> [vnet\_customer](#output\_vnet\_customer) | #### VNets |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
