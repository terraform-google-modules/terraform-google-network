# example-root

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

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_context"></a> [base\_context](#module\_base\_context) | ../../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_ibp_customer_infrastructure"></a> [ibp\_customer\_infrastructure](#module\_ibp\_customer\_infrastructure) | ../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_default_route_table.test](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/default_route_table) | resource |
| [aws_iam_role.test](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.test](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_route_table.test](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route_table) | resource |
| [aws_vpc.test](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_customer_output"></a> [customer\_output](#output\_customer\_output) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
