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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_cloudwatch_health_dashboard_event_rule"></a> [context\_cloudwatch\_health\_dashboard\_event\_rule](#module\_context\_cloudwatch\_health\_dashboard\_event\_rule) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_iam_role_bastion"></a> [context\_iam\_role\_bastion](#module\_context\_iam\_role\_bastion) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_iam_role_default"></a> [context\_iam\_role\_default](#module\_context\_iam\_role\_default) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_s3_base"></a> [context\_s3\_base](#module\_context\_s3\_base) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_s3_management_backups"></a> [context\_s3\_management\_backups](#module\_context\_s3\_management\_backups) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_s3_revocation"></a> [context\_s3\_revocation](#module\_context\_s3\_revocation) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_s3_ssm_patching"></a> [context\_s3\_ssm\_patching](#module\_context\_s3\_ssm\_patching) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_ssm_customer_patching"></a> [context\_ssm\_customer\_patching](#module\_context\_ssm\_customer\_patching) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_ssm_management_patching"></a> [context\_ssm\_management\_patching](#module\_context\_ssm\_management\_patching) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_ssm_window_account_scan"></a> [context\_ssm\_window\_account\_scan](#module\_context\_ssm\_window\_account\_scan) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_ssm_window_customer_patch_install"></a> [context\_ssm\_window\_customer\_patch\_install](#module\_context\_ssm\_window\_customer\_patch\_install) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_ssm_window_management_patch_install"></a> [context\_ssm\_window\_management\_patch\_install](#module\_context\_ssm\_window\_management\_patch\_install) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_iam_role_awsbackup"></a> [iam\_role\_awsbackup](#module\_iam\_role\_awsbackup) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-context-aws-iam-role | n/a |
| <a name="module_iam_role_bastion"></a> [iam\_role\_bastion](#module\_iam\_role\_bastion) | EXAMPLE_SOURCE/terraform/shared/modules/aws-iam-role | n/a |
| <a name="module_iam_role_default"></a> [iam\_role\_default](#module\_iam\_role\_default) | EXAMPLE_SOURCE/terraform/shared/modules/aws-iam-role | n/a |
| <a name="module_iam_role_ssm_service_ami_creation"></a> [iam\_role\_ssm\_service\_ami\_creation](#module\_iam\_role\_ssm\_service\_ami\_creation) | EXAMPLE_SOURCE/terraform/shared/modules/aws-iam-role | n/a |
| <a name="module_s3_management_backups"></a> [s3\_management\_backups](#module\_s3\_management\_backups) | EXAMPLE_SOURCE/terraform/shared/modules/aws-s3bucket | n/a |
| <a name="module_s3_revocation"></a> [s3\_revocation](#module\_s3\_revocation) | EXAMPLE_SOURCE/terraform/shared/modules/aws-s3bucket | n/a |
| <a name="module_s3_ssm_patching"></a> [s3\_ssm\_patching](#module\_s3\_ssm\_patching) | EXAMPLE_SOURCE/terraform/shared/modules/aws-s3bucket | n/a |
| <a name="module_ssm_customer_rhel_general"></a> [ssm\_customer\_rhel\_general](#module\_ssm\_customer\_rhel\_general) | EXAMPLE_SOURCE/terraform/shared/modules/aws-ssm-patch-group-rhel-security | n/a |
| <a name="module_ssm_customer_ubuntu_general"></a> [ssm\_customer\_ubuntu\_general](#module\_ssm\_customer\_ubuntu\_general) | EXAMPLE_SOURCE/terraform/shared/modules/aws-ssm-patch-group-ubuntu-security | n/a |
| <a name="module_ssm_customer_windows_general"></a> [ssm\_customer\_windows\_general](#module\_ssm\_customer\_windows\_general) | EXAMPLE_SOURCE/terraform/shared/modules/aws-ssm-patch-group-windows-security | n/a |
| <a name="module_ssm_management_rhel_general"></a> [ssm\_management\_rhel\_general](#module\_ssm\_management\_rhel\_general) | EXAMPLE_SOURCE/terraform/shared/modules/aws-ssm-patch-group-rhel-security | n/a |
| <a name="module_ssm_management_ubuntu_general"></a> [ssm\_management\_ubuntu\_general](#module\_ssm\_management\_ubuntu\_general) | EXAMPLE_SOURCE/terraform/shared/modules/aws-ssm-patch-group-ubuntu-security | n/a |
| <a name="module_ssm_management_windows_general"></a> [ssm\_management\_windows\_general](#module\_ssm\_management\_windows\_general) | EXAMPLE_SOURCE/terraform/shared/modules/aws-ssm-patch-group-windows-security | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.health_dashboard](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.health_dashboard](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/cloudwatch_event_target) | resource |
| [aws_ebs_default_kms_key.account](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/ebs_default_kms_key) | resource |
| [aws_ebs_encryption_by_default.account](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/ebs_encryption_by_default) | resource |
| [aws_efs_file_system.common_staging](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.common_staging_1a](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/efs_mount_target) | resource |
| [aws_efs_mount_target.common_staging_1b](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/efs_mount_target) | resource |
| [aws_efs_mount_target.common_staging_1c](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/efs_mount_target) | resource |
| [aws_iam_policy.acm_pca_policy](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.bastion_policy](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ec2_ebs_policy](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.iam_passrole_policy](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.log_collection_aws_policy](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.s3_management_backup_readlist_policy](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.s3_management_backup_write_policy](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.sns_topic_policy](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ssm_ami_creation_policy](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ssm_s3_patching_policy](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_policy) | resource |
| [aws_sns_topic.ami_restore](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/sns_topic) | resource |
| [aws_sns_topic.sns_topic](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.ami_restore](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.main_distribution_list](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/sns_topic_subscription) | resource |
| [aws_ssm_maintenance_window.account_scan](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/ssm_maintenance_window) | resource |
| [aws_ssm_maintenance_window.customer_patch_install](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/ssm_maintenance_window) | resource |
| [aws_ssm_maintenance_window.management_patch_install](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/ssm_maintenance_window) | resource |
| [aws_ssm_maintenance_window_target.account_scan_customer](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/ssm_maintenance_window_target) | resource |
| [aws_ssm_maintenance_window_target.account_scan_management](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/ssm_maintenance_window_target) | resource |
| [aws_ssm_maintenance_window_target.customer_patch_install](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/ssm_maintenance_window_target) | resource |
| [aws_ssm_maintenance_window_target.management_patch_install](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/ssm_maintenance_window_target) | resource |
| [aws_ssm_maintenance_window_task.account_scan](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/ssm_maintenance_window_task) | resource |
| [aws_ssm_maintenance_window_task.customer_patch_install](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/ssm_maintenance_window_task) | resource |
| [aws_ssm_maintenance_window_task.management_patch_install](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/ssm_maintenance_window_task) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [aws_kms_key.account_default_ebs](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/kms_key) | data source |
| [terraform_remote_state.layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_pca_arn"></a> [acm\_pca\_arn](#input\_acm\_pca\_arn) | SMS intermediate Certificate Authority | `any` | n/a | yes |
| <a name="input_adv_efs_staging_provisioned_throughput_in_mibps"></a> [adv\_efs\_staging\_provisioned\_throughput\_in\_mibps](#input\_adv\_efs\_staging\_provisioned\_throughput\_in\_mibps) | EFS provisioned throughput in MiB/s for staging EF when set to provisioned. | `number` | `30` | no |
| <a name="input_adv_efs_staging_throughput_mode"></a> [adv\_efs\_staging\_throughput\_mode](#input\_adv\_efs\_staging\_throughput\_mode) | EFS throughput mode for staging EFS | `string` | `"bursting"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `any` | n/a | yes |
| <a name="input_aws_sns_ami_restore_email_list"></a> [aws\_sns\_ami\_restore\_email\_list](#input\_aws\_sns\_ami\_restore\_email\_list) | AWS SNS topic email distribution list for ami restores | `any` | n/a | yes |
| <a name="input_aws_sns_email_distribution_list"></a> [aws\_sns\_email\_distribution\_list](#input\_aws\_sns\_email\_distribution\_list) | Distribution list email address for SNS notifications | `any` | n/a | yes |
| <a name="input_aws_sns_topic"></a> [aws\_sns\_topic](#input\_aws\_sns\_topic) | SNS topic display name | `any` | n/a | yes |
| <a name="input_aws_topic_name"></a> [aws\_topic\_name](#input\_aws\_topic\_name) | AWS SNS topic name | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_efs_common_staging"></a> [efs\_common\_staging](#output\_efs\_common\_staging) | #### EFS |
| <a name="output_iam_policy_acm_pca"></a> [iam\_policy\_acm\_pca](#output\_iam\_policy\_acm\_pca) | n/a |
| <a name="output_iam_policy_bastion"></a> [iam\_policy\_bastion](#output\_iam\_policy\_bastion) | ## IAM Policies |
| <a name="output_iam_policy_ec2_ebs"></a> [iam\_policy\_ec2\_ebs](#output\_iam\_policy\_ec2\_ebs) | n/a |
| <a name="output_iam_policy_log_collection_aws"></a> [iam\_policy\_log\_collection\_aws](#output\_iam\_policy\_log\_collection\_aws) | n/a |
| <a name="output_iam_policy_s3_management_backup_read"></a> [iam\_policy\_s3\_management\_backup\_read](#output\_iam\_policy\_s3\_management\_backup\_read) | n/a |
| <a name="output_iam_policy_s3_management_backup_write"></a> [iam\_policy\_s3\_management\_backup\_write](#output\_iam\_policy\_s3\_management\_backup\_write) | n/a |
| <a name="output_iam_policy_ssm_ami_creation"></a> [iam\_policy\_ssm\_ami\_creation](#output\_iam\_policy\_ssm\_ami\_creation) | n/a |
| <a name="output_iam_policy_ssm_s3_patching"></a> [iam\_policy\_ssm\_s3\_patching](#output\_iam\_policy\_ssm\_s3\_patching) | n/a |
| <a name="output_iam_role_awsbackup"></a> [iam\_role\_awsbackup](#output\_iam\_role\_awsbackup) | n/a |
| <a name="output_iam_role_bastion"></a> [iam\_role\_bastion](#output\_iam\_role\_bastion) | n/a |
| <a name="output_iam_role_default"></a> [iam\_role\_default](#output\_iam\_role\_default) | ## IAM Roles |
| <a name="output_iam_role_ssm_service_ami_creation"></a> [iam\_role\_ssm\_service\_ami\_creation](#output\_iam\_role\_ssm\_service\_ami\_creation) | n/a |
| <a name="output_s3_management_backups"></a> [s3\_management\_backups](#output\_s3\_management\_backups) | n/a |
| <a name="output_s3_revocation"></a> [s3\_revocation](#output\_s3\_revocation) | ## S3 Buckets |
| <a name="output_s3_ssm_patching"></a> [s3\_ssm\_patching](#output\_s3\_ssm\_patching) | n/a |
| <a name="output_sns_topic"></a> [sns\_topic](#output\_sns\_topic) | ## SNS |
| <a name="output_ssm_customer_rhel_general"></a> [ssm\_customer\_rhel\_general](#output\_ssm\_customer\_rhel\_general) | n/a |
| <a name="output_ssm_customer_ubuntu_general"></a> [ssm\_customer\_ubuntu\_general](#output\_ssm\_customer\_ubuntu\_general) | n/a |
| <a name="output_ssm_customer_windows_general"></a> [ssm\_customer\_windows\_general](#output\_ssm\_customer\_windows\_general) | n/a |
| <a name="output_ssm_management_rhel_general"></a> [ssm\_management\_rhel\_general](#output\_ssm\_management\_rhel\_general) | ## SSM |
| <a name="output_ssm_management_ubuntu_general"></a> [ssm\_management\_ubuntu\_general](#output\_ssm\_management\_ubuntu\_general) | n/a |
| <a name="output_ssm_management_windows_general"></a> [ssm\_management\_windows\_general](#output\_ssm\_management\_windows\_general) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
