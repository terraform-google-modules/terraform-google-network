# layer-03

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
| <a name="module_layer_context"></a> [layer\_context](#module\_layer\_context) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_backup_protected_vm.instance_list](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/backup_protected_vm) | resource |
| [azurerm_backup_protected_vm.saprouter_instance](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/backup_protected_vm) | resource |
| [azurerm_backup_protected_vm.windows_instance](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/backup_protected_vm) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/data-sources/subscription) | data source |
| [terraform_remote_state.layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.layer_01](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.layer_02](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_environment"></a> [azure\_environment](#input\_azure\_environment) | Azure Cloud Environment (e.g. usgovernment, public) | `string` | n/a | yes |
| <a name="input_azure_region"></a> [azure\_region](#input\_azure\_region) | Azure Region | `string` | n/a | yes |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | Azure Subscription ID | `string` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `string` | n/a | yes |
| <a name="input_deployment_layer"></a> [deployment\_layer](#input\_deployment\_layer) | (Optional) Layer of Terraform module deployment | `string` | `null` | no |
| <a name="input_root_module"></a> [root\_module](#input\_root\_module) | Name of Terraform root module responsible for provisioning resources | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
