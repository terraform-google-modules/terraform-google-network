# example_root

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.49.0 |
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
| <a name="module_network"></a> [network](#module\_network) | ../../aws-network | n/a |
| <a name="module_test"></a> [test](#module\_test) | ../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_key_pair.key](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/key_pair) | resource |
| [random_id.id](https://registry.terraform.io/providers/hashicorp/random/3.6.3/docs/resources/id) | resource |
| [tls_private_key.test_private_key](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/private_key) | resource |
| [aws_ami.instance](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region where the module is run | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | Employee ID that is running the terraform code | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_module_test"></a> [module\_test](#output\_module\_test) | n/a |
| <a name="output_zzz_message"></a> [zzz\_message](#output\_zzz\_message) | n/a |
| <a name="output_zzz_test_private_key"></a> [zzz\_test\_private\_key](#output\_zzz\_test\_private\_key) | output "module\_test\_network" { value = module.network } |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
