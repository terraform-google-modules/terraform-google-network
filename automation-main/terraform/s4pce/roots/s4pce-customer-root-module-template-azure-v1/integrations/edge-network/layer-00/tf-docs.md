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
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.2 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_context_application_sg_customer_egress_all"></a> [context\_application\_sg\_customer\_egress\_all](#module\_context\_application\_sg\_customer\_egress\_all) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_application_sg_customer_vnet_all"></a> [context\_application\_sg\_customer\_vnet\_all](#module\_context\_application\_sg\_customer\_vnet\_all) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_rtb_main01"></a> [context\_rtb\_main01](#module\_context\_rtb\_main01) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_vnet_main01"></a> [context\_vnet\_main01](#module\_context\_vnet\_main01) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_endpoint_list"></a> [endpoint\_list](#module\_endpoint\_list) | ../../EXAMPLE_SOURCE/terraform/s4pce/modules/azure-endpoint-services-multiport | n/a |
| <a name="module_layer_context"></a> [layer\_context](#module\_layer\_context) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_application_security_group.customer_egress_all](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/application_security_group) | resource |
| [azurerm_application_security_group.customer_vnet_all](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/application_security_group) | resource |
| [azurerm_network_interface_backend_address_pool_association.dr_endpoint_list](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/network_interface_backend_address_pool_association) | resource |
| [azurerm_network_interface_backend_address_pool_association.endpoint_list](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/network_interface_backend_address_pool_association) | resource |
| [azurerm_network_security_group.main01](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.customer_egress_all](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.customer_vnet_all_ingress](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/network_security_rule) | resource |
| [azurerm_public_ip.gateway01](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/public_ip) | resource |
| [azurerm_route_table.main01](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/route_table) | resource |
| [azurerm_subnet.gateway01](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/subnet) | resource |
| [azurerm_subnet.main01](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.main01](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.main01](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/subnet_route_table_association) | resource |
| [azurerm_virtual_network.main01](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_gateway.virtualnetworkgateway01](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/virtual_network_gateway) | resource |
| [local_file.file_content](https://registry.terraform.io/providers/hashicorp/local/2.5.2/docs/resources/file) | resource |
| [local_file.migration_list](https://registry.terraform.io/providers/hashicorp/local/2.5.2/docs/resources/file) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/data-sources/subscription) | data source |
| [terraform_remote_state.layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.layer_02](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adv_no_customer_gateway"></a> [adv\_no\_customer\_gateway](#input\_adv\_no\_customer\_gateway) | (Optional) Do not deploy virtual network gateway for customer | `bool` | `false` | no |
| <a name="input_adv_subnet_endpoint_network_policies"></a> [adv\_subnet\_endpoint\_network\_policies](#input\_adv\_subnet\_endpoint\_network\_policies) | (Optional) Enable/Disable network policies for private endpoints | `string` | `"Disabled"` | no |
| <a name="input_adv_subnet_service_network_policies"></a> [adv\_subnet\_service\_network\_policies](#input\_adv\_subnet\_service\_network\_policies) | (Optional) Enable/Disable network policies for service endpoints | `bool` | `false` | no |
| <a name="input_azure_environment"></a> [azure\_environment](#input\_azure\_environment) | Azure Cloud Environment (e.g. usgovernment, public) | `string` | n/a | yes |
| <a name="input_azure_region"></a> [azure\_region](#input\_azure\_region) | Azure Region | `string` | n/a | yes |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | Azure Subscription ID | `string` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `string` | n/a | yes |
| <a name="input_deployment_layer"></a> [deployment\_layer](#input\_deployment\_layer) | (Optional) Layer of Terraform module deployment | `string` | `null` | no |
| <a name="input_lb_pool_node_type"></a> [lb\_pool\_node\_type](#input\_lb\_pool\_node\_type) | Type of nodes to be added to LB backend pool. Valid values are 'primary','dr', 'both' | `string` | `"primary"` | no |
| <a name="input_legacy_endpoints"></a> [legacy\_endpoints](#input\_legacy\_endpoints) | List of legacy endpoints | `list(string)` | `[]` | no |
| <a name="input_legacy_migration"></a> [legacy\_migration](#input\_legacy\_migration) | Toggle for creation of resources to assist in migration from legacy code | `bool` | `false` | no |
| <a name="input_root_module"></a> [root\_module](#input\_root\_module) | Name of Terraform root module responsible for provisioning resources | `string` | n/a | yes |
| <a name="input_subnet_gateway_cidr_block"></a> [subnet\_gateway\_cidr\_block](#input\_subnet\_gateway\_cidr\_block) | CIDR block for the gateway subnet | `any` | n/a | yes |
| <a name="input_subnet_main01_cidr_block"></a> [subnet\_main01\_cidr\_block](#input\_subnet\_main01\_cidr\_block) | CIDR block for the main01 subnet | `any` | n/a | yes |
| <a name="input_vnet_cidr_block"></a> [vnet\_cidr\_block](#input\_vnet\_cidr\_block) | CIDR block for the customer VNet | `string` | n/a | yes |
| <a name="input_vnet_ingress_cidr_list"></a> [vnet\_ingress\_cidr\_list](#input\_vnet\_ingress\_cidr\_list) | CIDR block allowed to ingress to VPC Endpoints | `list(string)` | n/a | yes |
| <a name="input_vng_asn"></a> [vng\_asn](#input\_vng\_asn) | ASN number for the customer router BGP configuration | `number` | `65515` | no |
| <a name="input_vng_sku"></a> [vng\_sku](#input\_vng\_sku) | VNG SKU | `string` | `"VpnGw2AZ"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_security_group_customer_egress_all"></a> [application\_security\_group\_customer\_egress\_all](#output\_application\_security\_group\_customer\_egress\_all) | n/a |
| <a name="output_application_security_group_customer_vnet_all"></a> [application\_security\_group\_customer\_vnet\_all](#output\_application\_security\_group\_customer\_vnet\_all) | n/a |
| <a name="output_customer_connectivity"></a> [customer\_connectivity](#output\_customer\_connectivity) | #### Customer Connectivity |
| <a name="output_endpoint_list"></a> [endpoint\_list](#output\_endpoint\_list) | #### Endpoints |
| <a name="output_network_security_group_main01"></a> [network\_security\_group\_main01](#output\_network\_security\_group\_main01) | #### Security Group |
| <a name="output_subnet_main01"></a> [subnet\_main01](#output\_subnet\_main01) | #### Subnet |
| <a name="output_vnet_main01"></a> [vnet\_main01](#output\_vnet\_main01) | #### VNet |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
