# example-root

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.5.7 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_context"></a> [base\_context](#module\_base\_context) | ../../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_lb"></a> [lb](#module\_lb) | ../ | n/a |
| <a name="module_network"></a> [network](#module\_network) | .//preliminary-modules/azure-network | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | (Required) UserId to create the stack. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint_services"></a> [endpoint\_services](#output\_endpoint\_services) | n/a |
| <a name="output_endpoints"></a> [endpoints](#output\_endpoints) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
