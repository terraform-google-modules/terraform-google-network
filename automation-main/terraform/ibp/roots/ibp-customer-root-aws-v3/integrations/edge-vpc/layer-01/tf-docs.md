# layer-01

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

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.49.0 |
| <a name="provider_dns"></a> [dns](#provider\_dns) | n/a |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_aws_lb_edge_cpids"></a> [context\_aws\_lb\_edge\_cpids](#module\_context\_aws\_lb\_edge\_cpids) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_lb.edge_cpids](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/lb) | resource |
| [aws_lb_listener.edge_cpids](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.edge_cpids](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.edge_cpids](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/lb_target_group_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [dns_a_record_set.edge_cpids](https://registry.terraform.io/providers/hashicorp/dns/latest/docs/data-sources/a_record_set) | data source |
| [terraform_remote_state.integration_layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.layer_02](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_edge_cpids"></a> [alb\_edge\_cpids](#output\_alb\_edge\_cpids) | n/a |
| <a name="output_lb_target_group_edge_cpids"></a> [lb\_target\_group\_edge\_cpids](#output\_lb\_target\_group\_edge\_cpids) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
