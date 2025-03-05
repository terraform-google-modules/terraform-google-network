# layer-00

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
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route.customer_default_management_peer](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route) | resource |
| [aws_route.customer_nat_management_peer_1a](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route) | resource |
| [aws_route.customer_nat_management_peer_1b](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route) | resource |
| [aws_route.customer_nat_management_peer_1c](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route) | resource |
| [aws_route.management_default_customer_peer](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route) | resource |
| [aws_route.management_nat_customer_peer_1a](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route) | resource |
| [aws_route.management_nat_customer_peer_1b](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route) | resource |
| [aws_route.management_nat_customer_peer_1c](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route) | resource |
| [aws_route53_resolver_rule_association.ibp_directory_service](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route53_resolver_rule_association) | resource |
| [aws_security_group_rule.customer_access_management_egress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.customer_access_management_ingress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_vpc_peering_connection.customer](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc_peering_connection) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [terraform_remote_state.layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.management_layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.management_layer_options](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
