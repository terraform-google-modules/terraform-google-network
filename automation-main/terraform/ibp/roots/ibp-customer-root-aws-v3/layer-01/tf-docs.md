# layer-01

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.7 |
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
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_iam_role_customer_database"></a> [iam\_role\_customer\_database](#module\_iam\_role\_customer\_database) | EXAMPLE_SOURCE/terraform/shared/modules/aws-iam-role | n/a |
| <a name="module_iam_role_customer_default"></a> [iam\_role\_customer\_default](#module\_iam\_role\_customer\_default) | EXAMPLE_SOURCE/terraform/shared/modules/aws-iam-role | n/a |
| <a name="module_iam_role_customer_ibpapp"></a> [iam\_role\_customer\_ibpapp](#module\_iam\_role\_customer\_ibpapp) | EXAMPLE_SOURCE/terraform/shared/modules/aws-iam-role | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_efs_file_system.customer_usr_sap_trans](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.customer_usr_sap_trans](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/efs_mount_target) | resource |
| [aws_iam_policy.ibp_s3_backups_readlist_policy](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ibp_s3_backups_write_policy](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ibp_s3_binaries_readlist_policy](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [terraform_remote_state.layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.management_layer_01](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_efs_subnets"></a> [efs\_subnets](#input\_efs\_subnets) | Subnet (key) where to create EFS mount targets. Key matches subnet created in layer-00. Restrict one mount target per zone. | `list(string)` | <pre>[<br/>  "dataservices_1",<br/>  "dataservices_2"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_efs_customer_usr_sap_trans"></a> [efs\_customer\_usr\_sap\_trans](#output\_efs\_customer\_usr\_sap\_trans) | n/a |
| <a name="output_efs_customer_usr_sap_trans_id"></a> [efs\_customer\_usr\_sap\_trans\_id](#output\_efs\_customer\_usr\_sap\_trans\_id) | EFS |
| <a name="output_efs_customer_usr_sap_trans_ip_1a"></a> [efs\_customer\_usr\_sap\_trans\_ip\_1a](#output\_efs\_customer\_usr\_sap\_trans\_ip\_1a) | n/a |
| <a name="output_iam_role_customer_database_id"></a> [iam\_role\_customer\_database\_id](#output\_iam\_role\_customer\_database\_id) | n/a |
| <a name="output_iam_role_customer_default_id"></a> [iam\_role\_customer\_default\_id](#output\_iam\_role\_customer\_default\_id) | IAM |
| <a name="output_iam_role_customer_ibpapp_id"></a> [iam\_role\_customer\_ibpapp\_id](#output\_iam\_role\_customer\_ibpapp\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
