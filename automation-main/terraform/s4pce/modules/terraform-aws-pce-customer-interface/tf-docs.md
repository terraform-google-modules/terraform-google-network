# terraform-aws-pce-customer-interface

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.4 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | >= 2.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.4.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.1.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.7.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | >= 2.2.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.4.0 |
| <a name="provider_local"></a> [local](#provider\_local) | >= 2.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_datasync"></a> [context\_datasync](#module\_context\_datasync) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_iam_interface_datasync_lambda"></a> [context\_iam\_interface\_datasync\_lambda](#module\_context\_iam\_interface\_datasync\_lambda) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_iam_interface_datasync_s3"></a> [context\_iam\_interface\_datasync\_s3](#module\_context\_iam\_interface\_datasync\_s3) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_iam_interface_s3_replication"></a> [context\_iam\_interface\_s3\_replication](#module\_context\_iam\_interface\_s3\_replication) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_iam_role_interface_s3_replication"></a> [context\_iam\_role\_interface\_s3\_replication](#module\_context\_iam\_role\_interface\_s3\_replication) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_s3_customer_interface"></a> [context\_s3\_customer\_interface](#module\_context\_s3\_customer\_interface) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_svc_account"></a> [context\_svc\_account](#module\_context\_svc\_account) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.customer_interface_to_efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_rule.customer_interface_to_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.customer_interface_to_efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_event_target.customer_interface_to_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_log_group.customer_interface_to_efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.customer_interface_to_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_datasync_location_efs.customer_interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/datasync_location_efs) | resource |
| [aws_datasync_location_s3.customer_interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/datasync_location_s3) | resource |
| [aws_datasync_task.customer_interface_to_efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/datasync_task) | resource |
| [aws_datasync_task.customer_interface_to_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/datasync_task) | resource |
| [aws_iam_policy.interface_datasync_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.interface_s3_datasync](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.interface_s3_replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.service_account_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.service_account_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.interface_s3_replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.interface_datasync_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.interface_datasync_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.interface_s3_replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_user.svc_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy_attachment.svc_account_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_iam_user_policy_attachment.svc_account_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_lambda_function.customer_interface_to_efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function.customer_interface_to_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.customer_interface_to_efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.customer_interface_to_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_s3_bucket.customer_interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.customer_interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_ownership_controls.customer_interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.customer_interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.customer_interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_replication_configuration.customer_interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_replication_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.customer_interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.customer_interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [archive_file.customer_interface_to_efs](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [archive_file.customer_interface_to_s3](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_efs_mount_target.customer_interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/efs_mount_target) | data source |
| [aws_security_group.customer_interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnet.customer_interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [local_file.changelog](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | `null` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Globally unique name of the bucket (Standard AWS Restrictions apply) | `string` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes | `string` | `null` | no |
| <a name="input_context"></a> [context](#input\_context) | n/a | <pre>object({<br/>    account_id             = string<br/>    additional_tags        = map(string)<br/>    build_user             = string<br/>    business               = string<br/>    customer               = string<br/>    delimiter              = string<br/>    environment            = string<br/>    environment_salt       = string<br/>    generated_by           = string<br/>    include_customer_label = bool<br/>    label_order            = list(string)<br/>    managed_by             = string<br/>    module                 = string<br/>    module_version         = string<br/>    name_prefix            = string<br/>    organization           = string<br/>    owner                  = string<br/>    partition              = string<br/>    parent_module          = string<br/>    parent_module_version  = string<br/>    regex_replace_chars    = string<br/>    region                 = string<br/>    root_module            = string<br/>    security_boundary      = string<br/><br/>    custom_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    environment_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    module_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    resource_tags = list(<br/>      object({<br/>        name         = string<br/>        value        = string<br/>        required     = bool<br/>        pass_context = bool<br/>      })<br/>    )<br/><br/>  })</pre> | `null` | no |
| <a name="input_customer_account_id"></a> [customer\_account\_id](#input\_customer\_account\_id) | The account ID of the customer's AWS account (Partion/Region must match) | `string` | `null` | no |
| <a name="input_customer_bucket_names"></a> [customer\_bucket\_names](#input\_customer\_bucket\_names) | The name of the customer bucket to replicate object to.  Pass empty list to disable | `list(string)` | `[]` | no |
| <a name="input_datasync_delete_efs_to_s3"></a> [datasync\_delete\_efs\_to\_s3](#input\_datasync\_delete\_efs\_to\_s3) | Delete files on S3 that don't exist on EFS | `bool` | `false` | no |
| <a name="input_datasync_delete_s3_to_efs"></a> [datasync\_delete\_s3\_to\_efs](#input\_datasync\_delete\_s3\_to\_efs) | Delete files on EFS that don't exist on S3 | `bool` | `false` | no |
| <a name="input_datasync_efs_destination_subdirectory"></a> [datasync\_efs\_destination\_subdirectory](#input\_datasync\_efs\_destination\_subdirectory) | Directory on the EFS for datasync to replicate to from S3 if not the same as datasync\_efs\_subdirectory | `string` | `null` | no |
| <a name="input_datasync_efs_subdirectory"></a> [datasync\_efs\_subdirectory](#input\_datasync\_efs\_subdirectory) | Subdirectory of the EFS to datasync. Does not create directory if missing. | `string` | `"/datasync"` | no |
| <a name="input_datasync_s3_destination_subdirectory"></a> [datasync\_s3\_destination\_subdirectory](#input\_datasync\_s3\_destination\_subdirectory) | Directory in S3 for datasync to replicate to from EFS if not the same as datasync\_s3\_subdirectory | `string` | `null` | no |
| <a name="input_datasync_s3_subdirectory"></a> [datasync\_s3\_subdirectory](#input\_datasync\_s3\_subdirectory) | Subdirectory of the S3 to datasync. Does not create directory if missing. | `string` | `"/datasync"` | no |
| <a name="input_datasync_schedule_efs_to_s3"></a> [datasync\_schedule\_efs\_to\_s3](#input\_datasync\_schedule\_efs\_to\_s3) | Schedule for EFS to S3 Sync (Eventbridge rule). Null for no schedule | `string` | `null` | no |
| <a name="input_datasync_schedule_s3_to_efs"></a> [datasync\_schedule\_s3\_to\_efs](#input\_datasync\_schedule\_s3\_to\_efs) | Schedule for S3 to EFS Sync (Eventbridge rule). Null for no schedule | `string` | `null` | no |
| <a name="input_delete_marker_replication"></a> [delete\_marker\_replication](#input\_delete\_marker\_replication) | Replicate Delete Markers | `string` | `"Enabled"` | no |
| <a name="input_destination_efs_mount_target_id"></a> [destination\_efs\_mount\_target\_id](#input\_destination\_efs\_mount\_target\_id) | Mount Target to create a datasync destination location to | `string` | n/a | yes |
| <a name="input_interface_bucket_write_arns"></a> [interface\_bucket\_write\_arns](#input\_interface\_bucket\_write\_arns) | A list of ARNs to be permitted write access to the interface S3 bucket | `list(string)` | `[]` | no |
| <a name="input_logging_regions"></a> [logging\_regions](#input\_logging\_regions) | List of regions to support logging in. If not set, only the region the module is deployed in will be configured. | `list(string)` | `null` | no |
| <a name="input_service_account_read_path"></a> [service\_account\_read\_path](#input\_service\_account\_read\_path) | Path he service account can read from | `string` | `null` | no |
| <a name="input_service_account_write_path"></a> [service\_account\_write\_path](#input\_service\_account\_write\_path) | Path the service account can write to | `string` | `null` | no |
| <a name="input_shared_kms_key"></a> [shared\_kms\_key](#input\_shared\_kms\_key) | ARN of the shared KMS key for encrypted replication | `string` | `null` | no |
| <a name="input_use_service_account"></a> [use\_service\_account](#input\_use\_service\_account) | Whether to resources that depend on service account access | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_customer_interface_bucket"></a> [customer\_interface\_bucket](#output\_customer\_interface\_bucket) | #### S3 |
| <a name="output_customer_interface_datasync"></a> [customer\_interface\_datasync](#output\_customer\_interface\_datasync) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
