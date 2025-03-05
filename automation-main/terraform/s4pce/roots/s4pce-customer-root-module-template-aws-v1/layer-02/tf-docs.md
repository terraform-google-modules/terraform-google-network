# layer-02

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
| <a name="module_context_aws_security_group_saprouter"></a> [context\_aws\_security\_group\_saprouter](#module\_context\_aws\_security\_group\_saprouter) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_instance_list"></a> [context\_instance\_list](#module\_context\_instance\_list) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_instance_rhel"></a> [context\_instance\_rhel](#module\_context\_instance\_rhel) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_instance_ubuntu"></a> [context\_instance\_ubuntu](#module\_context\_instance\_ubuntu) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_instance_windows"></a> [context\_instance\_windows](#module\_context\_instance\_windows) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_s3_additional_backup"></a> [context\_s3\_additional\_backup](#module\_context\_s3\_additional\_backup) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_s3_base"></a> [context\_s3\_base](#module\_context\_s3\_base) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_instance_list"></a> [instance\_list](#module\_instance\_list) | EXAMPLE_SOURCE/terraform/shared/modules/aws-instance | n/a |
| <a name="module_instance_saprouter"></a> [instance\_saprouter](#module\_instance\_saprouter) | EXAMPLE_SOURCE/terraform/shared/modules/aws-instance | n/a |
| <a name="module_s3_additional_backup"></a> [s3\_additional\_backup](#module\_s3\_additional\_backup) | EXAMPLE_SOURCE/terraform/shared/modules/aws-s3bucket | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_backup_plan.main01](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/backup_plan) | resource |
| [aws_backup_selection.main01](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/backup_selection) | resource |
| [aws_backup_vault.main01](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/backup_vault) | resource |
| [aws_key_pair.main01](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/key_pair) | resource |
| [aws_security_group.saprouter](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group) | resource |
| [aws_security_group_rule.saprouter_standard_ingress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [aws_kms_alias.ec2_backups](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/kms_alias) | data source |
| [terraform_remote_state.layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.layer_01](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.management_layer_01](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_owner_default"></a> [ami\_owner\_default](#input\_ami\_owner\_default) | Default AMI Owner to use | `string` | `"156506675147"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `any` | n/a | yes |
| <a name="input_bucket_retention_days"></a> [bucket\_retention\_days](#input\_bucket\_retention\_days) | Specifies how long objects should be retained before expiration or automatically deleted for the additional backup S3 bucket | `string` | `"180"` | no |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_create_bucket"></a> [create\_bucket](#input\_create\_bucket) | Controls the creation of the backup S3 Bucket | `bool` | `false` | no |
| <a name="input_enable_backup"></a> [enable\_backup](#input\_enable\_backup) | ### Disabling/Enabling Backup Plan Variable | `number` | `1` | no |
| <a name="input_git_name"></a> [git\_name](#input\_git\_name) | Git username to download repositories; define if performing bootstrap through userdata. | `any` | n/a | yes |
| <a name="input_git_token"></a> [git\_token](#input\_git\_token) | Git token to download repositories; define if performing bootstrap through userdata. | `any` | n/a | yes |
| <a name="input_ha_instances"></a> [ha\_instances](#input\_ha\_instances) | Used to disable source/destination checking on HA instances | `list(string)` | `[]` | no |
| <a name="input_image_application_name"></a> [image\_application\_name](#input\_image\_application\_name) | Search string for SAP Application image | `string` | n/a | yes |
| <a name="input_image_database_name"></a> [image\_database\_name](#input\_image\_database\_name) | Search string for Database image | `string` | n/a | yes |
| <a name="input_instance_list"></a> [instance\_list](#input\_instance\_list) | A map of instances to create | `any` | `null` | no |
| <a name="input_noncurrent_version_expiration"></a> [noncurrent\_version\_expiration](#input\_noncurrent\_version\_expiration) | Defines a period after which noncurrent versions of objects are automatically deleted for the additional backup S3 bucket | `string` | `"180"` | no |
| <a name="input_noncurrent_version_transition_days"></a> [noncurrent\_version\_transition\_days](#input\_noncurrent\_version\_transition\_days) | Specifies the number of days after which noncurrent versions of objects are transitioned to a different storage class for the additional backup S3 bucket | `string` | `"30"` | no |
| <a name="input_saprouter_ingress_cidr"></a> [saprouter\_ingress\_cidr](#input\_saprouter\_ingress\_cidr) | Allowed Ingress for SAP Router | `list(string)` | <pre>[<br/>  "194.39.131.34/32"<br/>]</pre> | no |
| <a name="input_ssh_main01_public_key"></a> [ssh\_main01\_public\_key](#input\_ssh\_main01\_public\_key) | SSH public key to create an AWS EC2 Key from and associate with management instances | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_list"></a> [instance\_list](#output\_instance\_list) | ##### Instances |
| <a name="output_key_pair_name"></a> [key\_pair\_name](#output\_key\_pair\_name) | n/a |
| <a name="output_raw_instance_list"></a> [raw\_instance\_list](#output\_raw\_instance\_list) | n/a |
| <a name="output_s3_additional_backup"></a> [s3\_additional\_backup](#output\_s3\_additional\_backup) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
