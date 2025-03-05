# aws-endpoint-services

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.38 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.38 |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lb.networkloadbalancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.networkloadbalancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.networkloadbalancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.networkloadbalancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_vpc_endpoint.networkloadbalancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint_service.networkloadbalancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_service) | resource |
| [aws_vpc_endpoint_service_allowed_principal.allow_principal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_service_allowed_principal) | resource |
| [time_sleep.networkloadbalancer](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [aws_subnet.networkloadbalancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_endpoint_edge_vpc_id"></a> [endpoint\_edge\_vpc\_id](#input\_endpoint\_edge\_vpc\_id) | Edge VPC ID | `any` | n/a | yes |
| <a name="input_endpoint_security_group_list"></a> [endpoint\_security\_group\_list](#input\_endpoint\_security\_group\_list) | Security groups applied to the endpoint. | `any` | n/a | yes |
| <a name="input_endpoint_subnet_list"></a> [endpoint\_subnet\_list](#input\_endpoint\_subnet\_list) | Subnets to place the endpoints into. | `any` | n/a | yes |
| <a name="input_nlb_deletion_protection"></a> [nlb\_deletion\_protection](#input\_nlb\_deletion\_protection) | Enables/Disables termination protection | `bool` | `false` | no |
| <a name="input_nlb_instance_id"></a> [nlb\_instance\_id](#input\_nlb\_instance\_id) | Instance or IP address to forward the Network Load Balancer to. | `any` | n/a | yes |
| <a name="input_nlb_listener_port"></a> [nlb\_listener\_port](#input\_nlb\_listener\_port) | Port of the destination target | `any` | n/a | yes |
| <a name="input_nlb_name"></a> [nlb\_name](#input\_nlb\_name) | Name of the Network Load Balancer | `any` | n/a | yes |
| <a name="input_nlb_subnet_list"></a> [nlb\_subnet\_list](#input\_nlb\_subnet\_list) | Subnets the load balancer will reside in. | `any` | n/a | yes |
| <a name="input_nlb_target_az_all"></a> [nlb\_target\_az\_all](#input\_nlb\_target\_az\_all) | Sets the AZ to `all`. Required if IP is outside the VPC | `bool` | `false` | no |
| <a name="input_nlb_target_ip"></a> [nlb\_target\_ip](#input\_nlb\_target\_ip) | Target IP address instead of instance type | `bool` | `false` | no |
| <a name="input_nlb_target_port"></a> [nlb\_target\_port](#input\_nlb\_target\_port) | Port of the destination target | `any` | n/a | yes |
| <a name="input_principal_arns"></a> [principal\_arns](#input\_principal\_arns) | ARNs of the principals to allow | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint_dns_entry"></a> [endpoint\_dns\_entry](#output\_endpoint\_dns\_entry) | n/a |
| <a name="output_endpoint_eni"></a> [endpoint\_eni](#output\_endpoint\_eni) | n/a |
| <a name="output_endpoint_id"></a> [endpoint\_id](#output\_endpoint\_id) | n/a |
| <a name="output_endpoint_service_id"></a> [endpoint\_service\_id](#output\_endpoint\_service\_id) | n/a |
| <a name="output_endpoint_service_name"></a> [endpoint\_service\_name](#output\_endpoint\_service\_name) | n/a |
| <a name="output_networkloadbalancer_dns_name"></a> [networkloadbalancer\_dns\_name](#output\_networkloadbalancer\_dns\_name) | n/a |
| <a name="output_networkloadbalancer_id"></a> [networkloadbalancer\_id](#output\_networkloadbalancer\_id) | n/a |
| <a name="output_networkloadbalancer_name"></a> [networkloadbalancer\_name](#output\_networkloadbalancer\_name) | n/a |
| <a name="output_targetgroup_arn"></a> [targetgroup\_arn](#output\_targetgroup\_arn) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
