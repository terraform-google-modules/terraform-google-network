# layer-00

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
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_aws_default_route_table_edge_vpc"></a> [context\_aws\_default\_route\_table\_edge\_vpc](#module\_context\_aws\_default\_route\_table\_edge\_vpc) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_aws_default_security_group_edge_vpc"></a> [context\_aws\_default\_security\_group\_edge\_vpc](#module\_context\_aws\_default\_security\_group\_edge\_vpc) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_aws_security_group_all_egress"></a> [context\_aws\_security\_group\_all\_egress](#module\_context\_aws\_security\_group\_all\_egress) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_aws_security_group_ingress"></a> [context\_aws\_security\_group\_ingress](#module\_context\_aws\_security\_group\_ingress) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_aws_subnet_edge_vpc_1a"></a> [context\_aws\_subnet\_edge\_vpc\_1a](#module\_context\_aws\_subnet\_edge\_vpc\_1a) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_aws_subnet_edge_vpc_1b"></a> [context\_aws\_subnet\_edge\_vpc\_1b](#module\_context\_aws\_subnet\_edge\_vpc\_1b) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_aws_vpc_edge"></a> [context\_aws\_vpc\_edge](#module\_context\_aws\_vpc\_edge) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_endpoint_cpids"></a> [endpoint\_cpids](#module\_endpoint\_cpids) | ../../EXAMPLE_SOURCE/terraform/ibp/modules/aws-endpoint-services | n/a |
| <a name="module_endpoint_webdispatcher_44301"></a> [endpoint\_webdispatcher\_44301](#module\_endpoint\_webdispatcher\_44301) | ../../EXAMPLE_SOURCE/terraform/ibp/modules/aws-endpoint-services | n/a |
| <a name="module_endpoint_webdispatcher_44303"></a> [endpoint\_webdispatcher\_44303](#module\_endpoint\_webdispatcher\_44303) | ../../EXAMPLE_SOURCE/terraform/ibp/modules/aws-endpoint-services | n/a |
| <a name="module_endpoint_webdispatcher_44304"></a> [endpoint\_webdispatcher\_44304](#module\_endpoint\_webdispatcher\_44304) | ../../EXAMPLE_SOURCE/terraform/ibp/modules/aws-endpoint-services | n/a |
| <a name="module_endpoint_webdispatcher_44306"></a> [endpoint\_webdispatcher\_44306](#module\_endpoint\_webdispatcher\_44306) | ../../EXAMPLE_SOURCE/terraform/ibp/modules/aws-endpoint-services | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_default_route_table.edge_vpc_default_route](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/default_route_table) | resource |
| [aws_default_security_group.edge_vpc](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/default_security_group) | resource |
| [aws_security_group.edge_vpc_all_egress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group) | resource |
| [aws_security_group.edge_vpc_ingress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group) | resource |
| [aws_subnet.edge_vpc_1a](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/subnet) | resource |
| [aws_subnet.edge_vpc_1b](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/subnet) | resource |
| [aws_vpc.edge_vpc](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [terraform_remote_state.layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.layer_02](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_edge_vpc_1a_az"></a> [edge\_vpc\_1a\_az](#input\_edge\_vpc\_1a\_az) | Zone for subnet 1a | `string` | n/a | yes |
| <a name="input_edge_vpc_1a_cidr"></a> [edge\_vpc\_1a\_cidr](#input\_edge\_vpc\_1a\_cidr) | Edge VPC subnet for subnet 1a | `any` | n/a | yes |
| <a name="input_edge_vpc_1b_az"></a> [edge\_vpc\_1b\_az](#input\_edge\_vpc\_1b\_az) | Zone for subnet 1a | `string` | n/a | yes |
| <a name="input_edge_vpc_1b_cidr"></a> [edge\_vpc\_1b\_cidr](#input\_edge\_vpc\_1b\_cidr) | Edge VPC subnet for subnet 1b | `any` | n/a | yes |
| <a name="input_edge_vpc_cidr"></a> [edge\_vpc\_cidr](#input\_edge\_vpc\_cidr) | Edge VPC CIDR block | `any` | n/a | yes |
| <a name="input_edge_vpc_ingress_cidr_list"></a> [edge\_vpc\_ingress\_cidr\_list](#input\_edge\_vpc\_ingress\_cidr\_list) | Edge VPC ingress CIDR list | `any` | n/a | yes |
| <a name="input_endpoint_nlb_subnets"></a> [endpoint\_nlb\_subnets](#input\_endpoint\_nlb\_subnets) | Subnet (key) where to create nlb for endpoint services. Key matches subnet created in layer-00. Restrict one subnet (key) per zone. | `list(string)` | <pre>[<br/>  "dataservices_1",<br/>  "dataservices_2"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cpids_endpoint_dns_entry"></a> [cpids\_endpoint\_dns\_entry](#output\_cpids\_endpoint\_dns\_entry) | n/a |
| <a name="output_edge_cpids_endpoint"></a> [edge\_cpids\_endpoint](#output\_edge\_cpids\_endpoint) | ##### Endpoint |
| <a name="output_edge_vpc_id"></a> [edge\_vpc\_id](#output\_edge\_vpc\_id) | ##### Edge VPC |
| <a name="output_edge_webdispatcher_44301_endpoint"></a> [edge\_webdispatcher\_44301\_endpoint](#output\_edge\_webdispatcher\_44301\_endpoint) | n/a |
| <a name="output_edge_webdispatcher_44303_endpoint"></a> [edge\_webdispatcher\_44303\_endpoint](#output\_edge\_webdispatcher\_44303\_endpoint) | n/a |
| <a name="output_security_group_edge_vpc_all_egress_id"></a> [security\_group\_edge\_vpc\_all\_egress\_id](#output\_security\_group\_edge\_vpc\_all\_egress\_id) | ##### Security Groups |
| <a name="output_security_group_edge_vpc_ingress_id"></a> [security\_group\_edge\_vpc\_ingress\_id](#output\_security\_group\_edge\_vpc\_ingress\_id) | n/a |
| <a name="output_subnet_edge_vpc_1a_id"></a> [subnet\_edge\_vpc\_1a\_id](#output\_subnet\_edge\_vpc\_1a\_id) | ##### Subnets |
| <a name="output_subnet_edge_vpc_1b_id"></a> [subnet\_edge\_vpc\_1b\_id](#output\_subnet\_edge\_vpc\_1b\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
