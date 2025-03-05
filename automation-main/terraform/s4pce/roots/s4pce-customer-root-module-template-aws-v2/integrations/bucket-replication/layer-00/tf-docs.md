# layer-00

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
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_access_point"></a> [context\_access\_point](#module\_context\_access\_point) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_kms_customer_interface"></a> [context\_kms\_customer\_interface](#module\_context\_kms\_customer\_interface) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_customer_interface"></a> [customer\_interface](#module\_customer\_interface) | ../../EXAMPLE_SOURCE/terraform/s4pce/modules/terraform-aws-pce-customer-interface | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_efs_access_point.customer_interface](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/efs_access_point) | resource |
| [aws_kms_key.customer_interface](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/kms_key) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/partition) | data source |
| [terraform_remote_state.layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_points"></a> [access\_points](#input\_access\_points) | Access Point Configuration | <pre>map(object({<br/>    posix_user = object({<br/>      uid = number<br/>      gid = number<br/>    })<br/>    root_directory = object({<br/>      path = string<br/>      creation_info = object({<br/>        owner_gid   = number<br/>        owner_uid   = number<br/>        permissions = number<br/>      })<br/>    })<br/>  }))</pre> | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_customer_account_id"></a> [customer\_account\_id](#input\_customer\_account\_id) | The account ID of the customer's AWS gov-cloud account | `any` | n/a | yes |
| <a name="input_customer_bucket_names"></a> [customer\_bucket\_names](#input\_customer\_bucket\_names) | The name of the customer buckets for each landscape to replicate objects to | `any` | n/a | yes |
| <a name="input_interface_bucket_write_arns"></a> [interface\_bucket\_write\_arns](#input\_interface\_bucket\_write\_arns) | A list of ARNs to be permitted write access to the interface S3 bucket | `any` | n/a | yes |
| <a name="input_shared_kms_key"></a> [shared\_kms\_key](#input\_shared\_kms\_key) | ARN of the key to encrypt outgoing replication | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_customer_interface"></a> [customer\_interface](#output\_customer\_interface) | #### S3 |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
