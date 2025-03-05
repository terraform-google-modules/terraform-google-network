# example_root

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.49.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.5.2 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.49.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_network"></a> [network](#module\_network) | ../../../../ste-automation/terraform/tools/modules/aws-network | n/a |
| <a name="module_test"></a> [test](#module\_test) | ../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.test](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.test](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_role) | resource |
| [aws_key_pair.test](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/key_pair) | resource |
| [aws_route53_zone.test](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route53_zone) | resource |
| [aws_iam_policy_document.test](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region where the module is run | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | Employee ID that is running the terraform code | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_module_test"></a> [module\_test](#output\_module\_test) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
