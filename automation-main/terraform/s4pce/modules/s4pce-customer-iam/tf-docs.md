<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_iam_role_customer_default"></a> [iam\_role\_customer\_default](#module\_iam\_role\_customer\_default) | ../../../shared/modules/aws-iam-role | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.s3_backups_readlist_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.s3_backups_write_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_context"></a> [context](#input\_context) | n/a | <pre>object({<br>    account_id             = string<br>    additional_tags        = map(string)<br>    build_user             = string<br>    business               = string<br>    customer               = string<br>    delimiter              = string<br>    environment            = string<br>    environment_salt       = string<br>    generated_by           = string<br>    include_customer_label = bool<br>    label_order            = list(string)<br>    managed_by             = string<br>    module                 = string<br>    module_version         = string<br>    name_prefix            = string<br>    organization           = string<br>    owner                  = string<br>    partition              = string<br>    parent_module          = string<br>    parent_module_version  = string<br>    regex_replace_chars    = string<br>    region                 = string<br>    root_module            = string<br>    security_boundary      = string<br><br>    custom_values = object({<br>      kv     = map(string)<br>      locals = any<br>      tags = list(object({<br>        name     = string<br>        value    = string<br>        required = bool<br>      }))<br>    })<br><br>    environment_values = object({<br>      kv     = map(string)<br>      locals = any<br>      tags = list(object({<br>        name     = string<br>        value    = string<br>        required = bool<br>      }))<br>    })<br><br>    module_values = object({<br>      kv     = map(string)<br>      locals = any<br>      tags = list(object({<br>        name     = string<br>        value    = string<br>        required = bool<br>      }))<br>    })<br><br>    resource_tags = list(<br>      object({<br>        name         = string<br>        value        = string<br>        required     = bool<br>        pass_context = bool<br>      })<br>    )<br><br>  })</pre> | `null` | no |
| <a name="input_iam_role_customer_default_additional_policy_arn"></a> [iam\_role\_customer\_default\_additional\_policy\_arn](#input\_iam\_role\_customer\_default\_additional\_policy\_arn) | list of additional policy ARNs to add to the customer default IAM role | `list(string)` | `[]` | no |
| <a name="input_s3_backups_bucket_arn"></a> [s3\_backups\_bucket\_arn](#input\_s3\_backups\_bucket\_arn) | The PCE Customer S3 backups bucket ARN. | `string` | n/a | yes |
| <a name="input_ste_automation_path"></a> [ste\_automation\_path](#input\_ste\_automation\_path) | The path to the ste-automation repository | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_customer_default"></a> [iam\_role\_customer\_default](#output\_iam\_role\_customer\_default) | n/a |
<!-- END_TF_DOCS -->