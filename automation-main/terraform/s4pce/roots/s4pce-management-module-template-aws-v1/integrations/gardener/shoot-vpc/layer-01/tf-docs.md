# layer-01

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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.49.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route.shoot_to_management](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/partition) | data source |
| [aws_route_table.gardener_managed_route_tables](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/route_table) | data source |
| [aws_subnets.gardener_managed_subnets](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/subnets) | data source |
| [terraform_remote_state.layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gardener_project_name"></a> [gardener\_project\_name](#input\_gardener\_project\_name) | Name of the Gardener project in which the shoot cluster is managed | `string` | n/a | yes |
| <a name="input_gardener_shoot_cluster_name"></a> [gardener\_shoot\_cluster\_name](#input\_gardener\_shoot\_cluster\_name) | Name of the Gardener shoot cluster that is deployed to the VPC created in layer-00 of this integration | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gardener_managed_route_tables"></a> [gardener\_managed\_route\_tables](#output\_gardener\_managed\_route\_tables) | n/a |
| <a name="output_gardener_managed_subnets"></a> [gardener\_managed\_subnets](#output\_gardener\_managed\_subnets) | #### Outputs |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
