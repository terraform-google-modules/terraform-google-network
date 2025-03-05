# layer-00

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.49.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.3 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_list_workspaces"></a> [aws\_list\_workspaces](#module\_aws\_list\_workspaces) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-aws-list-workspaces | n/a |

## Resources

| Name | Type |
|------|------|
| [terraform_remote_state.customer](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.init](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.management](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_list"></a> [customer\_list](#input\_customer\_list) | List of customers to add to the USC Network Integration | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_integration"></a> [dns\_integration](#output\_dns\_integration) | n/a |
| <a name="output_network_integration"></a> [network\_integration](#output\_network\_integration) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
