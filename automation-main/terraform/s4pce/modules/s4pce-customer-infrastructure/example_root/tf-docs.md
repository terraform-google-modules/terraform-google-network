# example_root

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.49.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.49.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_context"></a> [base\_context](#module\_base\_context) | ../../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_s4pce_customer_infrastructure"></a> [s4pce\_customer\_infrastructure](#module\_s4pce\_customer\_infrastructure) | ../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_zone.test](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route53_zone) | resource |
| [aws_vpc_dhcp_options.test](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc_dhcp_options) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/partition) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region where the module is run | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | Employee ID that is running the terraform code | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_infrastructure"></a> [infrastructure](#output\_infrastructure) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
