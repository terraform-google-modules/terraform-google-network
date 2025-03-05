# layer-00

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.49.0 |
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
| <a name="module_iam_role_gardener_shoot_worker_default"></a> [iam\_role\_gardener\_shoot\_worker\_default](#module\_iam\_role\_gardener\_shoot\_worker\_default) | ../../../EXAMPLE_SOURCE/terraform/shared/modules/aws-iam-role | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_db_subnet_group.rds_subnets](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/db_subnet_group) | resource |
| [aws_default_route_table.shoot_default](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/default_route_table) | resource |
| [aws_default_security_group.shoot_default](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/default_security_group) | resource |
| [aws_iam_policy.gardener_shoot_worker_node_default](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.gardener_shoot_worker_node_efs_access](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_policy) | resource |
| [aws_internet_gateway.shoot_igw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/internet_gateway) | resource |
| [aws_route.management_route](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route) | resource |
| [aws_route.shoot_default_management_peer](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route) | resource |
| [aws_route.shoot_default_route_igw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route) | resource |
| [aws_route_table.secondary_subnets](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route_table) | resource |
| [aws_route_table_association.secondary_subnets](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route_table_association) | resource |
| [aws_security_group.shoot_access_management](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group) | resource |
| [aws_security_group.shoot_all_egress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group) | resource |
| [aws_security_group.shoot_vpc](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group) | resource |
| [aws_security_group_rule.shoot_access_management_egress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.shoot_access_management_ingress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.shoot_all_egress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.shoot_vpc_standard_egress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.shoot_vpc_standard_ingress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_subnet.secondary_subnets](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/subnet) | resource |
| [aws_vpc.shoot](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc) | resource |
| [aws_vpc_dhcp_options.shoot](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc_dhcp_options) | resource |
| [aws_vpc_dhcp_options_association.vpc_dhcp_options_association](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc_dhcp_options_association) | resource |
| [aws_vpc_ipv4_cidr_block_association.shoot_secondary_cidr](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc_ipv4_cidr_block_association) | resource |
| [aws_vpc_peering_connection.shoot](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc_peering_connection) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/partition) | data source |
| [terraform_remote_state.layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `any` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR block for the VPC. Gardener will deploy resources here. | `string` | n/a | yes |
| <a name="input_vpc_domain_name"></a> [vpc\_domain\_name](#input\_vpc\_domain\_name) | VPC Domain name for use in DHCP-Opts | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC being created | `string` | `"shoot-vpc"` | no |
| <a name="input_vpc_secondary_cidr_block"></a> [vpc\_secondary\_cidr\_block](#input\_vpc\_secondary\_cidr\_block) | Addtional CIDR block for the VPC.  Used for RDS and Private Link Resources | `string` | n/a | yes |
| <a name="input_vpc_secondary_subnets"></a> [vpc\_secondary\_subnets](#input\_vpc\_secondary\_subnets) | Subnets for RDS and Private Link Resources, place in secondary CIDR to ensure separate from Gardener | <pre>map(<br/>    object({<br/>      cidr    = string<br/>      zone    = string<br/>      for_rds = optional(bool, false)<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_vpc_peering_connection_shoot"></a> [aws\_vpc\_peering\_connection\_shoot](#output\_aws\_vpc\_peering\_connection\_shoot) | #### Outputs |
| <a name="output_iam_role_gardener_shoot_worker_default"></a> [iam\_role\_gardener\_shoot\_worker\_default](#output\_iam\_role\_gardener\_shoot\_worker\_default) | #### Outputs |
| <a name="output_secondary_subnets"></a> [secondary\_subnets](#output\_secondary\_subnets) | #### Outputs |
| <a name="output_security_group_shoot_access_management"></a> [security\_group\_shoot\_access\_management](#output\_security\_group\_shoot\_access\_management) | n/a |
| <a name="output_security_group_shoot_all_egress"></a> [security\_group\_shoot\_all\_egress](#output\_security\_group\_shoot\_all\_egress) | n/a |
| <a name="output_security_group_shoot_vpc"></a> [security\_group\_shoot\_vpc](#output\_security\_group\_shoot\_vpc) | #### Outputs |
| <a name="output_subnet_group_rds_sftpgo"></a> [subnet\_group\_rds\_sftpgo](#output\_subnet\_group\_rds\_sftpgo) | n/a |
| <a name="output_vpc_shoot"></a> [vpc\_shoot](#output\_vpc\_shoot) | #### Outputs |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
