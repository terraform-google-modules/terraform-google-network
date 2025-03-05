# sftp

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
| <a name="module_layer_context"></a> [layer\_context](#module\_layer\_context) | ../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_lb"></a> [lb](#module\_lb) | ../EXAMPLE_SOURCE/terraform/s4pce/modules/azure-endpoint-services-multiport | n/a |
| <a name="module_sftp_pool"></a> [sftp\_pool](#module\_sftp\_pool) | ../EXAMPLE_SOURCE/terraform/shared/modules/terraform-azure-vm-scale-sets | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_share.sftp_nfs](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/storage_share) | resource |
| [local_file.inventory_file](https://registry.terraform.io/providers/hashicorp/local/2.5.2/docs/resources/file) | resource |
| [local_file.sftp_mapping](https://registry.terraform.io/providers/hashicorp/local/2.5.2/docs/resources/file) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/data-sources/subscription) | data source |
| [terraform_remote_state.layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.layer_02](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.layer_edge_net](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | VM admin username | `string` | `"cloud-user"` | no |
| <a name="input_adv_lb_no_zone"></a> [adv\_lb\_no\_zone](#input\_adv\_lb\_no\_zone) | Optional. Do not assign a zone to the loadbalancer | `bool` | `false` | no |
| <a name="input_adv_use_v1_naming"></a> [adv\_use\_v1\_naming](#input\_adv\_use\_v1\_naming) | V1 naming excludes DR and does not allow for multiple hosts with the same SID in different landscapes | `bool` | `false` | no |
| <a name="input_azure_environment"></a> [azure\_environment](#input\_azure\_environment) | Azure Cloud Environment (e.g. usgovernment, public) | `string` | n/a | yes |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | Azure Subscription ID | `string` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `string` | n/a | yes |
| <a name="input_nonstandard_sftp_list"></a> [nonstandard\_sftp\_list](#input\_nonstandard\_sftp\_list) | Custom app to override default app01 in sftp | `list(string)` | <pre>[<br/>  ""<br/>]</pre> | no |
| <a name="input_search_image_name"></a> [search\_image\_name](#input\_search\_image\_name) | search\_image\_name | `string` | n/a | yes |
| <a name="input_virtual_machine_size"></a> [virtual\_machine\_size](#input\_virtual\_machine\_size) | virtual machine size | `string` | `"Standard_D2ds_v4"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint_services"></a> [endpoint\_services](#output\_endpoint\_services) | n/a |
| <a name="output_endpoints"></a> [endpoints](#output\_endpoints) | n/a |
| <a name="output_vmss_private_ips"></a> [vmss\_private\_ips](#output\_vmss\_private\_ips) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
