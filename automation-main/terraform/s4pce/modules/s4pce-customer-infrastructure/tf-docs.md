# s4pce-customer-infrastructure

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.75.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.2.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.75.0 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.2.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_aws_security_group_customer_access_management"></a> [context\_aws\_security\_group\_customer\_access\_management](#module\_context\_aws\_security\_group\_customer\_access\_management) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_aws_security_group_customer_all_egress"></a> [context\_aws\_security\_group\_customer\_all\_egress](#module\_context\_aws\_security\_group\_customer\_all\_egress) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_aws_security_group_customer_vpc"></a> [context\_aws\_security\_group\_customer\_vpc](#module\_context\_aws\_security\_group\_customer\_vpc) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_s3_customer_backups"></a> [context\_s3\_customer\_backups](#module\_context\_s3\_customer\_backups) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_s3_customer_backups"></a> [s3\_customer\_backups](#module\_s3\_customer\_backups) | ../../../shared/modules/aws-s3bucket | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_default_route_table.customer_default_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table) | resource |
| [aws_default_security_group.customer_default_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_efs_file_system.customer_usr_sap_trans](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.customer_usr_sap_trans_1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_efs_mount_target.customer_usr_sap_trans_1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_efs_mount_target.customer_usr_sap_trans_1c](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_eip.customer_ngw1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip.customer_ngw1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip.customer_ngw1c](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.customer_igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.customer_ngw1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_nat_gateway.customer_ngw1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_nat_gateway.customer_ngw1c](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.customer_default_igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.customer_ngw1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.customer_ngw1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.customer_ngw1c](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route53_zone_association.customer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone_association) | resource |
| [aws_route_table.customer_ngw1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.customer_ngw1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.customer_ngw1c](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.customer_development_1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.customer_development_1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.customer_development_1c](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.customer_production_1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.customer_production_1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.customer_production_1c](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.customer_quality_assurance_1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.customer_quality_assurance_1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.customer_quality_assurance_1c](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.customer_access_management](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.customer_all_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.customer_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.customer_all_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.customer_vpc_standard_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.customer_vpc_standard_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_subnet.customer_development_1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.customer_development_1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.customer_development_1c](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.customer_edge_1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.customer_edge_1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.customer_edge_1c](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.customer_production_1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.customer_production_1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.customer_production_1c](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.customer_quality_assurance_1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.customer_quality_assurance_1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.customer_quality_assurance_1c](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.customer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_dhcp_options_association.dns_resolver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options_association) | resource |
| [aws_vpc_endpoint.additional_endpoints](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.private_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint_route_table_association.customer_default_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_endpoint_route_table_association.customer_ngw1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_endpoint_route_table_association.customer_ngw1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_endpoint_route_table_association.customer_ngw1c](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [null_resource.module_dependency](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_endpoints"></a> [additional\_endpoints](#input\_additional\_endpoints) | Additional interface endpoints | `list(string)` | <pre>[<br/>  "backup",<br/>  "backup-gateway",<br/>  "cloudtrail",<br/>  "monitoring",<br/>  "synthetics",<br/>  "logs",<br/>  "config",<br/>  "ds",<br/>  "ec2",<br/>  "ec2messages",<br/>  "elasticfilesystem",<br/>  "elasticfilesystem-fips",<br/>  "ecs",<br/>  "ecs-agent",<br/>  "ecs-telemetry",<br/>  "ecr.api",<br/>  "ecr.dkr",<br/>  "elasticfilesystem-fips",<br/>  "kms",<br/>  "logs",<br/>  "monitoring",<br/>  "rds",<br/>  "sns",<br/>  "ssm",<br/>  "ssmmessages",<br/>  "sts",<br/>  "identitystore",<br/>  "kms",<br/>  "kms-fips",<br/>  "lambda",<br/>  "elasticloadbalancing",<br/>  "sns",<br/>  "ssm",<br/>  "ssmmessages"<br/>]</pre> | no |
| <a name="input_additional_endpoints_creation"></a> [additional\_endpoints\_creation](#input\_additional\_endpoints\_creation) | Additional endpoints creation state | `bool` | `false` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | `"us-gov-west-1"` | no |
| <a name="input_bucket_expiration"></a> [bucket\_expiration](#input\_bucket\_expiration) | Enable/Disable customer s3 backup bucket\_expiration rule | `string` | `"Disabled"` | no |
| <a name="input_bucket_retention_days"></a> [bucket\_retention\_days](#input\_bucket\_retention\_days) | Number of days before objects are deleted from S3 backup bucket | `number` | `180` | no |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | n/a | <pre>object({<br/>    account_id             = string<br/>    additional_tags        = map(string)<br/>    build_user             = string<br/>    business               = string<br/>    customer               = string<br/>    delimiter              = string<br/>    environment            = string<br/>    environment_salt       = string<br/>    generated_by           = string<br/>    include_customer_label = bool<br/>    label_order            = list(string)<br/>    managed_by             = string<br/>    module                 = string<br/>    module_version         = string<br/>    name_prefix            = string<br/>    organization           = string<br/>    owner                  = string<br/>    partition              = string<br/>    parent_module          = string<br/>    parent_module_version  = string<br/>    regex_replace_chars    = string<br/>    region                 = string<br/>    root_module            = string<br/>    security_boundary      = string<br/><br/>    custom_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    environment_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    module_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    resource_tags = list(<br/>      object({<br/>        name         = string<br/>        value        = string<br/>        required     = bool<br/>        pass_context = bool<br/>      })<br/>    )<br/><br/>  })</pre> | `null` | no |
| <a name="input_custom_efs_throughput_in_mibps"></a> [custom\_efs\_throughput\_in\_mibps](#input\_custom\_efs\_throughput\_in\_mibps) | Use Local Account EFS throughput in mibps | `number` | `20` | no |
| <a name="input_custom_efs_throughput_mode"></a> [custom\_efs\_throughput\_mode](#input\_custom\_efs\_throughput\_mode) | Use Local Account EFS throughput mode | `string` | `"provisioned"` | no |
| <a name="input_custom_no_local_dns_zone"></a> [custom\_no\_local\_dns\_zone](#input\_custom\_no\_local\_dns\_zone) | Use Local Account dns zone | `bool` | `false` | no |
| <a name="input_custom_no_nat_gateways"></a> [custom\_no\_nat\_gateways](#input\_custom\_no\_nat\_gateways) | Disables the creation of NGWs in the private subnet | `bool` | `false` | no |
| <a name="input_default_lifecycle_status"></a> [default\_lifecycle\_status](#input\_default\_lifecycle\_status) | Whether default LCM rule is enabled/disabled | `string` | `"Enabled"` | no |
| <a name="input_module_dependency"></a> [module\_dependency](#input\_module\_dependency) | Used by root modules to create a dependency for order of operation purposes | `string` | `""` | no |
| <a name="input_route53_zone_management_id"></a> [route53\_zone\_management\_id](#input\_route53\_zone\_management\_id) | Management Route53 Hosted ID to associate with | `any` | n/a | yes |
| <a name="input_subnet_development_1a_cidr_block"></a> [subnet\_development\_1a\_cidr\_block](#input\_subnet\_development\_1a\_cidr\_block) | CIDR block for the development 1a subnet | `any` | n/a | yes |
| <a name="input_subnet_development_1b_cidr_block"></a> [subnet\_development\_1b\_cidr\_block](#input\_subnet\_development\_1b\_cidr\_block) | CIDR block for the development 1b subnet | `any` | n/a | yes |
| <a name="input_subnet_development_1c_cidr_block"></a> [subnet\_development\_1c\_cidr\_block](#input\_subnet\_development\_1c\_cidr\_block) | CIDR block for the development 1c subnet | `any` | n/a | yes |
| <a name="input_subnet_edge_1a_cidr_block"></a> [subnet\_edge\_1a\_cidr\_block](#input\_subnet\_edge\_1a\_cidr\_block) | CIDR block for the edge 1a subnet | `any` | n/a | yes |
| <a name="input_subnet_edge_1b_cidr_block"></a> [subnet\_edge\_1b\_cidr\_block](#input\_subnet\_edge\_1b\_cidr\_block) | CIDR block for the edge 1b subnet | `any` | n/a | yes |
| <a name="input_subnet_edge_1c_cidr_block"></a> [subnet\_edge\_1c\_cidr\_block](#input\_subnet\_edge\_1c\_cidr\_block) | CIDR block for the edge 1c subnet | `any` | n/a | yes |
| <a name="input_subnet_production_1a_cidr_block"></a> [subnet\_production\_1a\_cidr\_block](#input\_subnet\_production\_1a\_cidr\_block) | CIDR block for the production 1a subnet | `any` | n/a | yes |
| <a name="input_subnet_production_1b_cidr_block"></a> [subnet\_production\_1b\_cidr\_block](#input\_subnet\_production\_1b\_cidr\_block) | CIDR block for the production 1b subnet | `any` | n/a | yes |
| <a name="input_subnet_production_1c_cidr_block"></a> [subnet\_production\_1c\_cidr\_block](#input\_subnet\_production\_1c\_cidr\_block) | CIDR block for the production 1b subnet | `any` | n/a | yes |
| <a name="input_subnet_quality_assurance_1a_cidr_block"></a> [subnet\_quality\_assurance\_1a\_cidr\_block](#input\_subnet\_quality\_assurance\_1a\_cidr\_block) | CIDR block for the quality-assurance 1a subnet | `any` | n/a | yes |
| <a name="input_subnet_quality_assurance_1b_cidr_block"></a> [subnet\_quality\_assurance\_1b\_cidr\_block](#input\_subnet\_quality\_assurance\_1b\_cidr\_block) | CIDR block for the quality-assurance 1b subnet | `any` | n/a | yes |
| <a name="input_subnet_quality_assurance_1c_cidr_block"></a> [subnet\_quality\_assurance\_1c\_cidr\_block](#input\_subnet\_quality\_assurance\_1c\_cidr\_block) | CIDR block for the quality-assurance 1c subnet | `any` | n/a | yes |
| <a name="input_transition_days_glacier"></a> [transition\_days\_glacier](#input\_transition\_days\_glacier) | Number of days before objects are transitioned to glacier | `number` | `60` | no |
| <a name="input_transition_days_s3ia"></a> [transition\_days\_s3ia](#input\_transition\_days\_s3ia) | Number of days before objects are transitioned to IA | `number` | `30` | no |
| <a name="input_useZoneD"></a> [useZoneD](#input\_useZoneD) | Use zone D instead of zone C | `bool` | `false` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Whether versioning is enabled for s3 bucket | `string` | `"Enabled"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR block for the Customer VPC | `any` | n/a | yes |
| <a name="input_vpc_dhcp_options_id"></a> [vpc\_dhcp\_options\_id](#input\_vpc\_dhcp\_options\_id) | Custom dhcpoptions id to use. | `any` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | AWS VPC Name for the Customer VPC | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_efs_usr_sap_trans"></a> [efs\_usr\_sap\_trans](#output\_efs\_usr\_sap\_trans) | #### EFS |
| <a name="output_internet_gateway"></a> [internet\_gateway](#output\_internet\_gateway) | #### Gateways |
| <a name="output_nat_gateway_1a"></a> [nat\_gateway\_1a](#output\_nat\_gateway\_1a) | n/a |
| <a name="output_nat_gateway_1b"></a> [nat\_gateway\_1b](#output\_nat\_gateway\_1b) | n/a |
| <a name="output_nat_gateway_1c"></a> [nat\_gateway\_1c](#output\_nat\_gateway\_1c) | n/a |
| <a name="output_route53_zone"></a> [route53\_zone](#output\_route53\_zone) | #### Route53 |
| <a name="output_route_table"></a> [route\_table](#output\_route\_table) | n/a |
| <a name="output_route_table_customer_ngw1a"></a> [route\_table\_customer\_ngw1a](#output\_route\_table\_customer\_ngw1a) | n/a |
| <a name="output_route_table_customer_ngw1b"></a> [route\_table\_customer\_ngw1b](#output\_route\_table\_customer\_ngw1b) | n/a |
| <a name="output_route_table_customer_ngw1c"></a> [route\_table\_customer\_ngw1c](#output\_route\_table\_customer\_ngw1c) | n/a |
| <a name="output_route_table_default"></a> [route\_table\_default](#output\_route\_table\_default) | #### Routes |
| <a name="output_s3_backups"></a> [s3\_backups](#output\_s3\_backups) | #### S3 Buckets |
| <a name="output_security_group_all_egress"></a> [security\_group\_all\_egress](#output\_security\_group\_all\_egress) | n/a |
| <a name="output_security_group_customer_access_management"></a> [security\_group\_customer\_access\_management](#output\_security\_group\_customer\_access\_management) | n/a |
| <a name="output_security_group_vpc"></a> [security\_group\_vpc](#output\_security\_group\_vpc) | #### Security Groups |
| <a name="output_subnet_development_1a"></a> [subnet\_development\_1a](#output\_subnet\_development\_1a) | n/a |
| <a name="output_subnet_development_1b"></a> [subnet\_development\_1b](#output\_subnet\_development\_1b) | n/a |
| <a name="output_subnet_development_1c"></a> [subnet\_development\_1c](#output\_subnet\_development\_1c) | n/a |
| <a name="output_subnet_edge_1a"></a> [subnet\_edge\_1a](#output\_subnet\_edge\_1a) | n/a |
| <a name="output_subnet_edge_1b"></a> [subnet\_edge\_1b](#output\_subnet\_edge\_1b) | n/a |
| <a name="output_subnet_edge_1c"></a> [subnet\_edge\_1c](#output\_subnet\_edge\_1c) | n/a |
| <a name="output_subnet_production_1a"></a> [subnet\_production\_1a](#output\_subnet\_production\_1a) | #### Subnets |
| <a name="output_subnet_production_1b"></a> [subnet\_production\_1b](#output\_subnet\_production\_1b) | n/a |
| <a name="output_subnet_production_1c"></a> [subnet\_production\_1c](#output\_subnet\_production\_1c) | n/a |
| <a name="output_subnet_quality_assurance_1a"></a> [subnet\_quality\_assurance\_1a](#output\_subnet\_quality\_assurance\_1a) | n/a |
| <a name="output_subnet_quality_assurance_1b"></a> [subnet\_quality\_assurance\_1b](#output\_subnet\_quality\_assurance\_1b) | n/a |
| <a name="output_subnet_quality_assurance_1c"></a> [subnet\_quality\_assurance\_1c](#output\_subnet\_quality\_assurance\_1c) | n/a |
| <a name="output_vpc_customer"></a> [vpc\_customer](#output\_vpc\_customer) | #### VPC |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
