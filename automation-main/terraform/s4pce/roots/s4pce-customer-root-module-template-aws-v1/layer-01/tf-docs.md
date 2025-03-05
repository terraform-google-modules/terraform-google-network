# layer-01

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.7 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | 2.4.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.49.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.5.2 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.3 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.49.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_iam_role_customer_default"></a> [iam\_role\_customer\_default](#module\_iam\_role\_customer\_default) | EXAMPLE_SOURCE/terraform/shared/modules/aws-iam-role | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_efs_file_system.ha_app](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.ha_app](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/efs_mount_target) | resource |
| [aws_iam_policy.s3_backups_readlist_policy](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.s3_backups_write_policy](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [terraform_remote_state.layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.management_layer_01](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_deploy_ha_efs"></a> [deploy\_ha\_efs](#input\_deploy\_ha\_efs) | Boolean Value. Default False. True to deploy HA-EFS | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_efs_common_stagings_1a_ip"></a> [efs\_common\_stagings\_1a\_ip](#output\_efs\_common\_stagings\_1a\_ip) | ##EFS related |
| <a name="output_efs_ha_app"></a> [efs\_ha\_app](#output\_efs\_ha\_app) | n/a |
| <a name="output_efs_usr_sap_trans_fs_id"></a> [efs\_usr\_sap\_trans\_fs\_id](#output\_efs\_usr\_sap\_trans\_fs\_id) | n/a |
| <a name="output_iam_role_customer_default"></a> [iam\_role\_customer\_default](#output\_iam\_role\_customer\_default) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
