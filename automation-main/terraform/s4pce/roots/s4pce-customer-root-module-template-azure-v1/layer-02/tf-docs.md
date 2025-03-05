# layer-02

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.7 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.53.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 4.3.0 |
| <a name="requirement_external"></a> [external](#requirement\_external) | 2.3.4 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.5.2 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.3 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.3.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_context_application_sg_saprouter"></a> [context\_application\_sg\_saprouter](#module\_context\_application\_sg\_saprouter) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_instance_list"></a> [context\_instance\_list](#module\_context\_instance\_list) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_vm"></a> [context\_vm](#module\_context\_vm) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_instance_list"></a> [instance\_list](#module\_instance\_list) | EXAMPLE_SOURCE/terraform/shared/modules/azure-linux-virtual-machine | n/a |
| <a name="module_instance_saprouter"></a> [instance\_saprouter](#module\_instance\_saprouter) | EXAMPLE_SOURCE/terraform/shared/modules/azure-linux-virtual-machine | n/a |
| <a name="module_layer_context"></a> [layer\_context](#module\_layer\_context) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_application_security_group.support_saprouter](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/application_security_group) | resource |
| [azurerm_network_interface.windows_instance](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/network_interface) | resource |
| [azurerm_network_interface_application_security_group_association.windows_instance](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/network_interface_application_security_group_association) | resource |
| [azurerm_network_security_rule.support_saprouter_ingress](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/network_security_rule) | resource |
| [azurerm_windows_virtual_machine.windows_instance](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/windows_virtual_machine) | resource |
| [random_id.windows_instance](https://registry.terraform.io/providers/hashicorp/random/3.6.3/docs/resources/id) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/data-sources/subscription) | data source |
| [terraform_remote_state.layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.layer_01](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_environment"></a> [azure\_environment](#input\_azure\_environment) | Azure Cloud Environment (e.g. usgovernment, public) | `string` | n/a | yes |
| <a name="input_azure_region"></a> [azure\_region](#input\_azure\_region) | Azure Region | `string` | n/a | yes |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | Azure Subscription ID | `string` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `string` | n/a | yes |
| <a name="input_default_subnet"></a> [default\_subnet](#input\_default\_subnet) | The default subnet to place quality\_assurance and development into if not explicit | `string` | `"nonproduction"` | no |
| <a name="input_deployment_layer"></a> [deployment\_layer](#input\_deployment\_layer) | (Optional) Layer of Terraform module deployment | `string` | `null` | no |
| <a name="input_git_name"></a> [git\_name](#input\_git\_name) | (Optional) When bootstrap `true` selected for instance module(s), git username to download repositories with | `string` | `""` | no |
| <a name="input_git_token"></a> [git\_token](#input\_git\_token) | (Optional) When bootstrap `true` selected for instance module(s), git token to download repositories | `string` | `""` | no |
| <a name="input_image_application_name"></a> [image\_application\_name](#input\_image\_application\_name) | Search string for SAP Application image | `string` | n/a | yes |
| <a name="input_image_database_name"></a> [image\_database\_name](#input\_image\_database\_name) | Search string for Database image | `string` | n/a | yes |
| <a name="input_instance_list"></a> [instance\_list](#input\_instance\_list) | A map of instances to create | `any` | `null` | no |
| <a name="input_root_module"></a> [root\_module](#input\_root\_module) | Name of Terraform root module responsible for provisioning resources | `string` | n/a | yes |
| <a name="input_saprouter_ingress_cidr"></a> [saprouter\_ingress\_cidr](#input\_saprouter\_ingress\_cidr) | Allowed Ingress for SAP Router | `list(string)` | <pre>[<br/>  "194.39.131.34/32"<br/>]</pre> | no |
| <a name="input_windows_admin_password"></a> [windows\_admin\_password](#input\_windows\_admin\_password) | Temporary password to deploy new windows VMs | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_list"></a> [instance\_list](#output\_instance\_list) | ##### Virtual Machines |
| <a name="output_instance_list_saprouter"></a> [instance\_list\_saprouter](#output\_instance\_list\_saprouter) | n/a |
| <a name="output_raw_instance_list"></a> [raw\_instance\_list](#output\_raw\_instance\_list) | n/a |
| <a name="output_windows_instance_list"></a> [windows\_instance\_list](#output\_windows\_instance\_list) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
