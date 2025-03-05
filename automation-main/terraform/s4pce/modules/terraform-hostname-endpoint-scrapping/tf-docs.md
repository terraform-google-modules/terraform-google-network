# terraform-hostname-endpoint-scrapping

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.7 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | >= 2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.file_content](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_name"></a> [customer\_name](#input\_customer\_name) | customer name | `string` | n/a | yes |
| <a name="input_endpoint_list"></a> [endpoint\_list](#input\_endpoint\_list) | endpoint list from edge vpc | `map(any)` | n/a | yes |
| <a name="input_generated_file_name"></a> [generated\_file\_name](#input\_generated\_file\_name) | name for the generated file | `string` | `"./pce.txt"` | no |
| <a name="input_raw_list"></a> [raw\_list](#input\_raw\_list) | raw instance list from infrastructure layer | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint_list"></a> [endpoint\_list](#output\_endpoint\_list) | n/a |
| <a name="output_hostname_customhostname_pair"></a> [hostname\_customhostname\_pair](#output\_hostname\_customhostname\_pair) | n/a |
| <a name="output_processed_list"></a> [processed\_list](#output\_processed\_list) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
