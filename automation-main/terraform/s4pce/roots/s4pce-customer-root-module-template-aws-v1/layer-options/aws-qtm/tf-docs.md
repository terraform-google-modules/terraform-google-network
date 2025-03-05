# aws-qtm

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_qtm_example"></a> [qtm\_example](#module\_qtm\_example) | EXAMPLE_SOURCE/terraform/s4pce/modules/aws-qtm | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_qtm_certificate_arn"></a> [qtm\_certificate\_arn](#input\_qtm\_certificate\_arn) | The ARN of the SSL Certificate to attach.  This is assumed to have already been imported into the ACM. | `string` | n/a | yes |
| <a name="input_qtm_vm_values"></a> [qtm\_vm\_values](#input\_qtm\_vm\_values) | Values for QTM virtual machines.<br/>(Set of 3. qtm\_database, qtm\_application, qtm\_webdispatcher)<br/>Optional ami values will default to either<br/>the image\_database or image\_application variables | <pre>object({<br/>    qtm_database = object({<br/>      instance_type                 = string<br/>      meta_key_name                 = string<br/>      ami_name                      = optional(string, null)<br/>      ami_owner                     = optional(string, null)<br/>      additional_tags               = optional(map(string), null)<br/>      additional_security_group_ids = optional(list(string), [])<br/>    })<br/>    qtm_application = object({<br/>      instance_type                 = string<br/>      meta_key_name                 = string<br/>      ami_name                      = optional(string, null)<br/>      ami_owner                     = optional(string, null)<br/>      additional_tags               = optional(map(string), null)<br/>      additional_security_group_ids = optional(list(string), [])<br/>    })<br/>    qtm_webdispatcher = object({<br/>      instance_type                 = string<br/>      meta_key_name                 = string<br/>      ami_name                      = optional(string, null)<br/>      ami_owner                     = optional(string, null)<br/>      additional_tags               = optional(map(string), null)<br/>      additional_security_group_ids = optional(list(string), [])<br/>    })<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_module"></a> [module](#output\_module) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
