# customer-hosted-zone

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
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | ../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.main01](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route53_record) | resource |
| [aws_route53_zone.main01](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route53_zone) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/partition) | data source |
| [terraform_remote_state.layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_customer_dns_map"></a> [customer\_dns\_map](#input\_customer\_dns\_map) | Map of customer records to add to private hosted zone. | <pre>map(<br/>    object({<br/>      type = string,<br/>      data = list(string),<br/>      zone = string<br/>  }))</pre> | n/a | yes |
| <a name="input_customer_hosted_zones"></a> [customer\_hosted\_zones](#input\_customer\_hosted\_zones) | Private Hosted Zone of the Customer | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route53_customer_hosted_zone"></a> [route53\_customer\_hosted\_zone](#output\_route53\_customer\_hosted\_zone) | n/a |
| <a name="output_route53_customer_records"></a> [route53\_customer\_records](#output\_route53\_customer\_records) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
