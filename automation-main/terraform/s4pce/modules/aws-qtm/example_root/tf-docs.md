# example_root

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
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.49.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.5 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_context"></a> [context](#module\_context) | ../../../../shared/modules/terraform-null-context | n/a |
| <a name="module_network"></a> [network](#module\_network) | ../../../../tools/modules/aws-network | n/a |
| <a name="module_qtm_dev"></a> [qtm\_dev](#module\_qtm\_dev) | ../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.test_env](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/acm_certificate) | resource |
| [aws_iam_instance_profile.test_env](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.test_env](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_role) | resource |
| [aws_key_pair.test_env](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/key_pair) | resource |
| [random_id.test_env](https://registry.terraform.io/providers/hashicorp/random/3.6.3/docs/resources/id) | resource |
| [tls_private_key.test_env](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/private_key) | resource |
| [aws_caller_identity.test_env](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.test_env](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.test_env](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_module"></a> [module](#output\_module) | n/a |
| <a name="output_zzz_message"></a> [zzz\_message](#output\_zzz\_message) | n/a |
| <a name="output_zzz_test_private_key"></a> [zzz\_test\_private\_key](#output\_zzz\_test\_private\_key) | output "module\_test\_network" { value = module.network } |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
