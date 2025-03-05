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
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_endpoint_test_instance"></a> [endpoint\_test\_instance](#module\_endpoint\_test\_instance) | ../../ | n/a |
| <a name="module_endpoint_test_ip"></a> [endpoint\_test\_ip](#module\_endpoint\_test\_ip) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [terraform_remote_state.layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `any` | n/a | yes |
| <a name="input_bucket"></a> [bucket](#input\_bucket) | Bucket holding the state file of the network (layer-00) | `string` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_key"></a> [key](#input\_key) | Path to the state file of the network (layer-00) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_test_instance"></a> [test\_instance](#output\_test\_instance) | n/a |
| <a name="output_test_ip"></a> [test\_ip](#output\_test\_ip) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
