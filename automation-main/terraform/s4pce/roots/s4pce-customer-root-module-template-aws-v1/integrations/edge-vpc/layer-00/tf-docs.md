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
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.2 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_aws_security_group_main01_all_egress"></a> [context\_aws\_security\_group\_main01\_all\_egress](#module\_context\_aws\_security\_group\_main01\_all\_egress) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_aws_security_group_main01_ingress"></a> [context\_aws\_security\_group\_main01\_ingress](#module\_context\_aws\_security\_group\_main01\_ingress) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_endpoint_list"></a> [endpoint\_list](#module\_endpoint\_list) | ../../EXAMPLE_SOURCE/terraform/s4pce/modules/aws-endpoint-services-multiport | n/a |
| <a name="module_ha_endpoints"></a> [ha\_endpoints](#module\_ha\_endpoints) | ../../EXAMPLE_SOURCE/terraform/s4pce/modules/aws-endpoint-services-multiport | n/a |
| <a name="module_sftp_endpoints"></a> [sftp\_endpoints](#module\_sftp\_endpoints) | ../../EXAMPLE_SOURCE/terraform/s4pce/modules/terraform-aws-endpoint-multiport-multitarget | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_default_route_table.main01_default](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/default_route_table) | resource |
| [aws_default_security_group.main01_default](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/default_security_group) | resource |
| [aws_security_group.main01_all_egress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group) | resource |
| [aws_security_group.main01_ingress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group) | resource |
| [aws_security_group_rule.main01_all_egress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.main01_ingress_standard_ingress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_subnet.main01_infrastructure_1a](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/subnet) | resource |
| [aws_subnet.main01_infrastructure_1b](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/subnet) | resource |
| [aws_subnet.main01_infrastructure_1c](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/subnet) | resource |
| [aws_vpc.main01](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc) | resource |
| [aws_vpc_endpoint.networkloadbalancer](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint_service.networkloadbalancer](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc_endpoint_service) | resource |
| [aws_vpn_gateway.main01](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpn_gateway) | resource |
| [local_file.file_content](https://registry.terraform.io/providers/hashicorp/local/2.5.2/docs/resources/file) | resource |
| [random_id.networkloadbalancer](https://registry.terraform.io/providers/hashicorp/random/3.6.3/docs/resources/id) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [aws_lb.networkloadbalancer](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/lb) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/partition) | data source |
| [terraform_remote_state.layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.layer_02](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_ha_endpoints"></a> [ha\_endpoints](#input\_ha\_endpoints) | HA endpoints | <pre>map(<br/>    object({<br/>      vhost   = string<br/>      address = string<br/>      ports   = optional(list(string), ["3301", "3601"]) # This is the default when ports is not specified<br/>  }))</pre> | `{}` | no |
| <a name="input_loadbalancer_names"></a> [loadbalancer\_names](#input\_loadbalancer\_names) | List of load balancer unique names to be converted to Private Links. The loadbalancers should be unique to the Customer | `list(string)` | `[]` | no |
| <a name="input_subnet_main01_infrastructure_1a_cidr_block"></a> [subnet\_main01\_infrastructure\_1a\_cidr\_block](#input\_subnet\_main01\_infrastructure\_1a\_cidr\_block) | CIDR block for the main01\_infrastructure\_1a subnet | `any` | n/a | yes |
| <a name="input_subnet_main01_infrastructure_1b_cidr_block"></a> [subnet\_main01\_infrastructure\_1b\_cidr\_block](#input\_subnet\_main01\_infrastructure\_1b\_cidr\_block) | CIDR block for the main01\_infrastructure\_1b subnet | `any` | n/a | yes |
| <a name="input_subnet_main01_infrastructure_1c_cidr_block"></a> [subnet\_main01\_infrastructure\_1c\_cidr\_block](#input\_subnet\_main01\_infrastructure\_1c\_cidr\_block) | CIDR block for the main01\_infrastructure\_1c subnet | `any` | n/a | yes |
| <a name="input_vgw_asn"></a> [vgw\_asn](#input\_vgw\_asn) | Amazon side ASN to assign to the VGW | `string` | `null` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR block for the VPC | `any` | n/a | yes |
| <a name="input_vpc_ingress_cidr_list"></a> [vpc\_ingress\_cidr\_list](#input\_vpc\_ingress\_cidr\_list) | CIDR block allowed to ingress to VPC Endpoints | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint_list"></a> [endpoint\_list](#output\_endpoint\_list) | n/a |
| <a name="output_ha_endpoints"></a> [ha\_endpoints](#output\_ha\_endpoints) | #### Endpoints |
| <a name="output_nlb_endpoints"></a> [nlb\_endpoints](#output\_nlb\_endpoints) | n/a |
| <a name="output_route_table_main01_default"></a> [route\_table\_main01\_default](#output\_route\_table\_main01\_default) | #### Routes |
| <a name="output_security_group_main01_all_egress"></a> [security\_group\_main01\_all\_egress](#output\_security\_group\_main01\_all\_egress) | ##### Security Groups |
| <a name="output_security_group_main01_ingress"></a> [security\_group\_main01\_ingress](#output\_security\_group\_main01\_ingress) | n/a |
| <a name="output_sftp_list"></a> [sftp\_list](#output\_sftp\_list) | n/a |
| <a name="output_subnet_main01_infrastructure_1a"></a> [subnet\_main01\_infrastructure\_1a](#output\_subnet\_main01\_infrastructure\_1a) | #### Subnets |
| <a name="output_subnet_main01_infrastructure_1b"></a> [subnet\_main01\_infrastructure\_1b](#output\_subnet\_main01\_infrastructure\_1b) | n/a |
| <a name="output_subnet_main01_infrastructure_1c"></a> [subnet\_main01\_infrastructure\_1c](#output\_subnet\_main01\_infrastructure\_1c) | n/a |
| <a name="output_vpc_main01"></a> [vpc\_main01](#output\_vpc\_main01) | #### VPC |
| <a name="output_vpn_gateway"></a> [vpn\_gateway](#output\_vpn\_gateway) | #### Gateways |
| <a name="output_zzz_Message"></a> [zzz\_Message](#output\_zzz\_Message) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
