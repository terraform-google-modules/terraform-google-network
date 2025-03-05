# ibp-customer-infrastructure-v2

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.10.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.1.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.10.0 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.1.1 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_aws_security_group_customer_access_management"></a> [context\_aws\_security\_group\_customer\_access\_management](#module\_context\_aws\_security\_group\_customer\_access\_management) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_aws_security_group_customer_all_egress"></a> [context\_aws\_security\_group\_customer\_all\_egress](#module\_context\_aws\_security\_group\_customer\_all\_egress) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_aws_security_group_customer_vpc"></a> [context\_aws\_security\_group\_customer\_vpc](#module\_context\_aws\_security\_group\_customer\_vpc) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_backup_plan.main01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_plan) | resource |
| [aws_backup_selection.main01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_selection) | resource |
| [aws_backup_vault.main01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_vault) | resource |
| [aws_default_route_table.customer_default_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table) | resource |
| [aws_default_security_group.customer_default_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_eip.vpc_ngw1_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip.vpc_ngw2_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.customer_igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.customer_ngw1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_nat_gateway.customer_ngw2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.customer_default_igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.customer_default_management_peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.customer_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.customer_nat_gateway_b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.customer_nat_gateway_management_peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.management_default_customer_peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.management_nat_customer_peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.customer_nat_gateway_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.customer_nat_gateway_route_b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.customer_dataservices_1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.customer_dataservices_1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.customer_production_1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.customer_production_1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.customer_staging_1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_s3_bucket.s3_backups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.s3_binaries](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.s3_backups_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_acl.s3_binaries_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_lifecycle_configuration.s3_backups_lifecycle](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_lifecycle_configuration.s3_binaries_lifecycle](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_ownership_controls.s3_backups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_ownership_controls.s3_binaries](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_public_access_block.s3_backups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.s3_binaries](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_versioning.s3_backups_versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_versioning.s3_binaries_versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_security_group.customer_access_management](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.customer_all_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.customer_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.customer_access_management_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.customer_access_management_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.customer_all_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.customer_vpc_standard_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.customer_vpc_standard_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_subnet.customer_dataservices_1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.customer_dataservices_1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.customer_edge_1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.customer_edge_1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.customer_edge_1c](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.customer_production_1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.customer_production_1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.customer_staging_1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.customer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_dhcp_options_association.dns_resolver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options_association) | resource |
| [aws_vpc_endpoint.private_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint_route_table_association.customer_default_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_endpoint_route_table_association.customer_nat_gateway_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_peering_connection.customer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |
| [null_resource.module_dependency](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_id.s3_backups](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.s3_binaries](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_kms_alias.ec2_backups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_alias) | data source |
| [aws_route_table.management_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_table) | data source |
| [aws_vpc.management](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | `"us-gov-west-1"` | no |
| <a name="input_backup_versioning"></a> [backup\_versioning](#input\_backup\_versioning) | Whether versioning is enabled for s3 bucket | `string` | `"Enabled"` | no |
| <a name="input_binaries_versioning"></a> [binaries\_versioning](#input\_binaries\_versioning) | Whether versioning is enabled for s3 binaries bucket | `string` | `"Enabled"` | no |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | n/a | <pre>object({<br/>    account_id             = string<br/>    additional_tags        = map(string)<br/>    build_user             = string<br/>    business               = string<br/>    customer               = string<br/>    delimiter              = string<br/>    environment            = string<br/>    environment_salt       = string<br/>    generated_by           = string<br/>    include_customer_label = bool<br/>    label_order            = list(string)<br/>    managed_by             = string<br/>    module                 = string<br/>    module_version         = string<br/>    name_prefix            = string<br/>    organization           = string<br/>    owner                  = string<br/>    partition              = string<br/>    parent_module          = string<br/>    parent_module_version  = string<br/>    regex_replace_chars    = string<br/>    region                 = string<br/>    root_module            = string<br/>    security_boundary      = string<br/><br/>    custom_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    environment_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    module_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    resource_tags = list(<br/>      object({<br/>        name         = string<br/>        value        = string<br/>        required     = bool<br/>        pass_context = bool<br/>      })<br/>    )<br/><br/>  })</pre> | `null` | no |
| <a name="input_customer"></a> [customer](#input\_customer) | Customer Tag value | `any` | n/a | yes |
| <a name="input_enable_backup"></a> [enable\_backup](#input\_enable\_backup) | ### Disabling/Enabling Backup Plan Variable | `number` | `1` | no |
| <a name="input_management_backup_service_arn"></a> [management\_backup\_service\_arn](#input\_management\_backup\_service\_arn) | AWS Backup Service Role Arn | `any` | n/a | yes |
| <a name="input_management_nat_name"></a> [management\_nat\_name](#input\_management\_nat\_name) | AWS managment NAT route table name | `string` | `"nat"` | no |
| <a name="input_management_vpc_name"></a> [management\_vpc\_name](#input\_management\_vpc\_name) | AWS vpc name of the management vpc | `string` | `"ibp-management"` | no |
| <a name="input_module_dependency"></a> [module\_dependency](#input\_module\_dependency) | Used by root modules to create a dependency for order of operation purposes | `string` | `""` | no |
| <a name="input_subnet_dataservices_1a_cidr_block"></a> [subnet\_dataservices\_1a\_cidr\_block](#input\_subnet\_dataservices\_1a\_cidr\_block) | CIDR block for the dataservices 1a subnet | `any` | n/a | yes |
| <a name="input_subnet_dataservices_1b_cidr_block"></a> [subnet\_dataservices\_1b\_cidr\_block](#input\_subnet\_dataservices\_1b\_cidr\_block) | CIDR block for the dataservices 1b subnet | `any` | n/a | yes |
| <a name="input_subnet_edge_1a_cidr_block"></a> [subnet\_edge\_1a\_cidr\_block](#input\_subnet\_edge\_1a\_cidr\_block) | CIDR block for the edge 1a subnet | `any` | n/a | yes |
| <a name="input_subnet_edge_1b_cidr_block"></a> [subnet\_edge\_1b\_cidr\_block](#input\_subnet\_edge\_1b\_cidr\_block) | CIDR block for the edge 1b subnet | `any` | n/a | yes |
| <a name="input_subnet_edge_1c_cidr_block"></a> [subnet\_edge\_1c\_cidr\_block](#input\_subnet\_edge\_1c\_cidr\_block) | CIDR block for the edge 1c subnet | `any` | n/a | yes |
| <a name="input_subnet_production_1a_cidr_block"></a> [subnet\_production\_1a\_cidr\_block](#input\_subnet\_production\_1a\_cidr\_block) | CIDR block for the production 1a subnet | `any` | n/a | yes |
| <a name="input_subnet_production_1b_cidr_block"></a> [subnet\_production\_1b\_cidr\_block](#input\_subnet\_production\_1b\_cidr\_block) | CIDR block for the production 1b subnet | `any` | n/a | yes |
| <a name="input_subnet_staging_1a_cidr_block"></a> [subnet\_staging\_1a\_cidr\_block](#input\_subnet\_staging\_1a\_cidr\_block) | CIDR block for the staging 1a subnet | `any` | n/a | yes |
| <a name="input_subnet_staging_1b_cidr_block"></a> [subnet\_staging\_1b\_cidr\_block](#input\_subnet\_staging\_1b\_cidr\_block) | CIDR block for the subnet 1b subnet | `any` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR block for the customer VPC | `any` | n/a | yes |
| <a name="input_vpc_custom_name"></a> [vpc\_custom\_name](#input\_vpc\_custom\_name) | AWS VPC Name for the Customer VPC | `any` | n/a | yes |
| <a name="input_vpc_dhcp_options_id"></a> [vpc\_dhcp\_options\_id](#input\_vpc\_dhcp\_options\_id) | Custom dhcpoptions id to use. Defaults to Management VPCs dhcpoptions otherwise | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_account_id"></a> [aws\_account\_id](#output\_aws\_account\_id) | #### AWS Metadata |
| <a name="output_aws_backup_plan_id"></a> [aws\_backup\_plan\_id](#output\_aws\_backup\_plan\_id) | #### AWS Backup Service |
| <a name="output_aws_caller_arn"></a> [aws\_caller\_arn](#output\_aws\_caller\_arn) | n/a |
| <a name="output_aws_caller_user"></a> [aws\_caller\_user](#output\_aws\_caller\_user) | n/a |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | #### Gateways |
| <a name="output_nat_gateway"></a> [nat\_gateway](#output\_nat\_gateway) | n/a |
| <a name="output_nat_gateway_eip"></a> [nat\_gateway\_eip](#output\_nat\_gateway\_eip) | n/a |
| <a name="output_nat_gateway_id"></a> [nat\_gateway\_id](#output\_nat\_gateway\_id) | n/a |
| <a name="output_nat_gateway_name"></a> [nat\_gateway\_name](#output\_nat\_gateway\_name) | n/a |
| <a name="output_nat_gateway_route_table_id"></a> [nat\_gateway\_route\_table\_id](#output\_nat\_gateway\_route\_table\_id) | n/a |
| <a name="output_route_table"></a> [route\_table](#output\_route\_table) | n/a |
| <a name="output_route_table_default_id"></a> [route\_table\_default\_id](#output\_route\_table\_default\_id) | #### Route Tables |
| <a name="output_route_table_default_name"></a> [route\_table\_default\_name](#output\_route\_table\_default\_name) | n/a |
| <a name="output_route_table_nat_gateway_id"></a> [route\_table\_nat\_gateway\_id](#output\_route\_table\_nat\_gateway\_id) | n/a |
| <a name="output_route_table_nat_gateway_name"></a> [route\_table\_nat\_gateway\_name](#output\_route\_table\_nat\_gateway\_name) | n/a |
| <a name="output_s3_bucket_backups_arn"></a> [s3\_bucket\_backups\_arn](#output\_s3\_bucket\_backups\_arn) | #### S3 Buckets |
| <a name="output_s3_bucket_backups_id"></a> [s3\_bucket\_backups\_id](#output\_s3\_bucket\_backups\_id) | n/a |
| <a name="output_s3_bucket_binaries_arn"></a> [s3\_bucket\_binaries\_arn](#output\_s3\_bucket\_binaries\_arn) | n/a |
| <a name="output_s3_bucket_binaries_id"></a> [s3\_bucket\_binaries\_id](#output\_s3\_bucket\_binaries\_id) | n/a |
| <a name="output_security_group_access_management_id"></a> [security\_group\_access\_management\_id](#output\_security\_group\_access\_management\_id) | #### Security Groups |
| <a name="output_security_group_access_management_name"></a> [security\_group\_access\_management\_name](#output\_security\_group\_access\_management\_name) | n/a |
| <a name="output_security_group_all_egress_id"></a> [security\_group\_all\_egress\_id](#output\_security\_group\_all\_egress\_id) | n/a |
| <a name="output_security_group_vpc_id"></a> [security\_group\_vpc\_id](#output\_security\_group\_vpc\_id) | n/a |
| <a name="output_subnet_dataservices_1a_id"></a> [subnet\_dataservices\_1a\_id](#output\_subnet\_dataservices\_1a\_id) | n/a |
| <a name="output_subnet_dataservices_1a_name"></a> [subnet\_dataservices\_1a\_name](#output\_subnet\_dataservices\_1a\_name) | n/a |
| <a name="output_subnet_dataservices_1b_id"></a> [subnet\_dataservices\_1b\_id](#output\_subnet\_dataservices\_1b\_id) | n/a |
| <a name="output_subnet_dataservices_1b_name"></a> [subnet\_dataservices\_1b\_name](#output\_subnet\_dataservices\_1b\_name) | n/a |
| <a name="output_subnet_edge_1a_id"></a> [subnet\_edge\_1a\_id](#output\_subnet\_edge\_1a\_id) | n/a |
| <a name="output_subnet_edge_1a_name"></a> [subnet\_edge\_1a\_name](#output\_subnet\_edge\_1a\_name) | #### Subnets |
| <a name="output_subnet_edge_1b_id"></a> [subnet\_edge\_1b\_id](#output\_subnet\_edge\_1b\_id) | n/a |
| <a name="output_subnet_edge_1b_name"></a> [subnet\_edge\_1b\_name](#output\_subnet\_edge\_1b\_name) | n/a |
| <a name="output_subnet_edge_1c_id"></a> [subnet\_edge\_1c\_id](#output\_subnet\_edge\_1c\_id) | n/a |
| <a name="output_subnet_edge_1c_name"></a> [subnet\_edge\_1c\_name](#output\_subnet\_edge\_1c\_name) | n/a |
| <a name="output_subnet_production_1a_id"></a> [subnet\_production\_1a\_id](#output\_subnet\_production\_1a\_id) | n/a |
| <a name="output_subnet_production_1a_name"></a> [subnet\_production\_1a\_name](#output\_subnet\_production\_1a\_name) | n/a |
| <a name="output_subnet_production_1b_id"></a> [subnet\_production\_1b\_id](#output\_subnet\_production\_1b\_id) | n/a |
| <a name="output_subnet_production_1b_name"></a> [subnet\_production\_1b\_name](#output\_subnet\_production\_1b\_name) | n/a |
| <a name="output_subnet_staging_1a_id"></a> [subnet\_staging\_1a\_id](#output\_subnet\_staging\_1a\_id) | n/a |
| <a name="output_subnet_staging_1a_name"></a> [subnet\_staging\_1a\_name](#output\_subnet\_staging\_1a\_name) | n/a |
| <a name="output_vpc_customer_cidr_block"></a> [vpc\_customer\_cidr\_block](#output\_vpc\_customer\_cidr\_block) | n/a |
| <a name="output_vpc_customer_id"></a> [vpc\_customer\_id](#output\_vpc\_customer\_id) | n/a |
| <a name="output_vpc_customer_name"></a> [vpc\_customer\_name](#output\_vpc\_customer\_name) | #### Customer VPC |
| <a name="output_vpc_customer_s3_endpoint_id"></a> [vpc\_customer\_s3\_endpoint\_id](#output\_vpc\_customer\_s3\_endpoint\_id) | n/a |
| <a name="output_vpc_managemenet_cidr_block"></a> [vpc\_managemenet\_cidr\_block](#output\_vpc\_managemenet\_cidr\_block) | n/a |
| <a name="output_vpc_management_dhcp_opts"></a> [vpc\_management\_dhcp\_opts](#output\_vpc\_management\_dhcp\_opts) | n/a |
| <a name="output_vpc_management_id"></a> [vpc\_management\_id](#output\_vpc\_management\_id) | n/a |
| <a name="output_vpc_management_name"></a> [vpc\_management\_name](#output\_vpc\_management\_name) | #### Management VPC |
| <a name="output_vpc_management_peering_connection_id"></a> [vpc\_management\_peering\_connection\_id](#output\_vpc\_management\_peering\_connection\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
