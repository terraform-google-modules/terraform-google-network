# dns-steering

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
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.2 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dns_steering"></a> [dns\_steering](#module\_dns\_steering) | ../../EXAMPLE_SOURCE/terraform/s4pce/modules/terraform-aws-dns-steering | n/a |
| <a name="module_module_context"></a> [module\_context](#module\_module\_context) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |

## Resources

| Name | Type |
|------|------|
| [local_file.file_content](https://registry.terraform.io/providers/hashicorp/local/2.5.2/docs/resources/file) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/partition) | data source |
| [terraform_remote_state.edge_vpc_layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_dns_account_profile"></a> [dns\_account\_profile](#input\_dns\_account\_profile) | AWS Profile of the DNS Account | <pre>object({<br/>    name   = string // AWS Profile Name<br/>    region = string // AWS Profile Region<br/>  })</pre> | n/a | yes |
| <a name="input_dns_steering_zone"></a> [dns\_steering\_zone](#input\_dns\_steering\_zone) | DNS Steering Zone information | <pre>object({<br/>    fqdn = string // Top-Level Zone FQDN<br/>    id   = string // Top-Level Zone ID<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_steering"></a> [dns\_steering](#output\_dns\_steering) | n/a |
| <a name="output_zzz___Message1"></a> [zzz\_\_\_Message1](#output\_zzz\_\_\_Message1) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
