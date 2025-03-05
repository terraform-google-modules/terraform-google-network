# directory-service

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_directory_service"></a> [directory\_service](#module\_directory\_service) | EXAMPLE_SOURCE/terraform/s4pce/modules/directory-service | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_directory_service_config"></a> [directory\_service\_config](#input\_directory\_service\_config) | Configuration for the directory service | <pre>object({<br/>    netbios        = string<br/>    admin_password = string<br/>    fqdn           = string<br/>  })</pre> | n/a | yes |
| <a name="input_directory_service_create_options"></a> [directory\_service\_create\_options](#input\_directory\_service\_create\_options) | Create options for the directory service | <pre>object({<br/>    cloudwatch_log_group             = optional(bool, true)<br/>    workspace_fullaccess_policy      = optional(bool, false)<br/>    constrained_endpoint             = optional(bool, false)<br/>    constrained_endpoint_dns_records = optional(bool, false)<br/>    outbound_resolver                = optional(bool, false)<br/>  })</pre> | n/a | yes |
| <a name="input_directory_service_subnet_config"></a> [directory\_service\_subnet\_config](#input\_directory\_service\_subnet\_config) | Recommended. Pass in two CIDR Ranges for subnet creation in different AZs. If not defined, will use pre-existing subnets. (Not Recommended) | <pre>map(object({<br/>    cidr_block = string<br/>    az         = string<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_directory_service"></a> [directory\_service](#output\_directory\_service) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
