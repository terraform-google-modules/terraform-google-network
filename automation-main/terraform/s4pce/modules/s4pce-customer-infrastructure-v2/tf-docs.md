<!-- BEGIN_TF_DOCS -->
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
| [aws_backup_plan.main01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_plan) | resource |
| [aws_backup_selection.main01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_selection) | resource |
| [aws_backup_vault.main01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_vault) | resource |
| [aws_default_route_table.customer_default_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table) | resource |
| [aws_default_security_group.customer_default_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_efs_file_system.customer_usr_sap_trans](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_file_system.ha_app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.customer_usr_sap_trans](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_efs_mount_target.ha_app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_eip.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.customer_igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.customer_default_igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.customer_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route53_zone_association.customer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone_association) | resource |
| [aws_route_table.customer_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.customer_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.customer_access_management](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.customer_all_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.customer_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.customer_all_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_subnet.customer_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.customer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_dhcp_options_association.dns_resolver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options_association) | resource |
| [aws_vpc_endpoint.additional_endpoints](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.private_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint_route_table_association.additional_endpoints_routes_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_endpoint_route_table_association.customer_default_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_endpoint_route_table_association.customer_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_ipv4_cidr_block_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipv4_cidr_block_association) | resource |
| [aws_vpc_security_group_egress_rule.vpc_self_egress_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.vpc_self_ingress_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [null_resource.module_dependency](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_kms_alias.ec2_backups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_alias) | data source |
| [aws_subnet.primary_landscape](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_endpoints"></a> [additional\_endpoints](#input\_additional\_endpoints) | Additional interface endpoints | `list(string)` | <pre>[<br>  "backup",<br>  "backup-gateway",<br>  "cloudtrail",<br>  "monitoring",<br>  "synthetics",<br>  "logs",<br>  "config",<br>  "ds",<br>  "ec2",<br>  "ec2messages",<br>  "elasticfilesystem",<br>  "elasticfilesystem-fips",<br>  "ecs",<br>  "ecs-agent",<br>  "ecs-telemetry",<br>  "ecr.api",<br>  "ecr.dkr",<br>  "elasticfilesystem-fips",<br>  "kms",<br>  "logs",<br>  "monitoring",<br>  "rds",<br>  "sns",<br>  "ssm",<br>  "ssmmessages",<br>  "sts",<br>  "identitystore",<br>  "kms",<br>  "kms-fips",<br>  "lambda",<br>  "elasticloadbalancing",<br>  "sns",<br>  "ssm",<br>  "ssmmessages"<br>]</pre> | no |
| <a name="input_additional_endpoints_creation"></a> [additional\_endpoints\_creation](#input\_additional\_endpoints\_creation) | Additional endpoints creation state | `bool` | `false` | no |
| <a name="input_adv_backup_vault_force_destroy"></a> [adv\_backup\_vault\_force\_destroy](#input\_adv\_backup\_vault\_force\_destroy) | Force destroy recovery points to delete the backup vault | `bool` | `false` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | `"us-gov-west-1"` | no |
| <a name="input_backup_service_arn"></a> [backup\_service\_arn](#input\_backup\_service\_arn) | AWS Backup Service Role Arn | `any` | `null` | no |
| <a name="input_bucket_expiration"></a> [bucket\_expiration](#input\_bucket\_expiration) | Enable/Disable customer s3 backup bucket\_expiration rule | `string` | `"Disabled"` | no |
| <a name="input_bucket_retention_days"></a> [bucket\_retention\_days](#input\_bucket\_retention\_days) | Number of days before objects are deleted from S3 backup bucket | `number` | `180` | no |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | n/a | <pre>object({<br>    account_id             = string<br>    additional_tags        = map(string)<br>    build_user             = string<br>    business               = string<br>    customer               = string<br>    delimiter              = string<br>    environment            = string<br>    environment_salt       = string<br>    generated_by           = string<br>    include_customer_label = bool<br>    label_order            = list(string)<br>    managed_by             = string<br>    module                 = string<br>    module_version         = string<br>    name_prefix            = string<br>    organization           = string<br>    owner                  = string<br>    partition              = string<br>    parent_module          = string<br>    parent_module_version  = string<br>    regex_replace_chars    = string<br>    region                 = string<br>    root_module            = string<br>    security_boundary      = string<br><br>    custom_values = object({<br>      kv     = map(string)<br>      locals = any<br>      tags = list(object({<br>        name     = string<br>        value    = string<br>        required = bool<br>      }))<br>    })<br><br>    environment_values = object({<br>      kv     = map(string)<br>      locals = any<br>      tags = list(object({<br>        name     = string<br>        value    = string<br>        required = bool<br>      }))<br>    })<br><br>    module_values = object({<br>      kv     = map(string)<br>      locals = any<br>      tags = list(object({<br>        name     = string<br>        value    = string<br>        required = bool<br>      }))<br>    })<br><br>    resource_tags = list(<br>      object({<br>        name         = string<br>        value        = string<br>        required     = bool<br>        pass_context = bool<br>      })<br>    )<br><br>  })</pre> | `null` | no |
| <a name="input_custom_efs_throughput_in_mibps"></a> [custom\_efs\_throughput\_in\_mibps](#input\_custom\_efs\_throughput\_in\_mibps) | Use Local Account EFS throughput in mibps | `number` | `20` | no |
| <a name="input_custom_efs_throughput_mode"></a> [custom\_efs\_throughput\_mode](#input\_custom\_efs\_throughput\_mode) | Use Local Account EFS throughput mode | `string` | `"provisioned"` | no |
| <a name="input_custom_no_local_dns_zone"></a> [custom\_no\_local\_dns\_zone](#input\_custom\_no\_local\_dns\_zone) | Use Local Account dns zone | `bool` | `false` | no |
| <a name="input_custom_no_nat_gateways"></a> [custom\_no\_nat\_gateways](#input\_custom\_no\_nat\_gateways) | Disables the creation of NGWs in the private subnet | `bool` | `false` | no |
| <a name="input_default_lifecycle_status"></a> [default\_lifecycle\_status](#input\_default\_lifecycle\_status) | Whether default LCM rule is enabled/disabled | `string` | `"Enabled"` | no |
| <a name="input_deploy_ha_efs"></a> [deploy\_ha\_efs](#input\_deploy\_ha\_efs) | Boolean Value. Default False. True to deploy HA-EFS | `bool` | `false` | no |
| <a name="input_enable_backup"></a> [enable\_backup](#input\_enable\_backup) | ### Disabling/Enabling Backup Plan Variable | `number` | `1` | no |
| <a name="input_module_dependency"></a> [module\_dependency](#input\_module\_dependency) | Used by root modules to create a dependency for order of operation purposes | `string` | `""` | no |
| <a name="input_network"></a> [network](#input\_network) | Map of Networks and Subnets. A primary network is required | <pre>map(<br>    object({                                   // network human-readable name. Requires a "primary"<br>      cidr      = string                       // network cidr<br>      primary_landscape = string // Primary deployment landscape. Must be contained within the subnet name. Ex: primary_landscape='production' requires subnet_name='production*'"<br>      landscape_default_deployment_zones = map(<br>        object({                // landscape name<br>          default_zone = string // default subnet zone for the landscape<br>        })<br>      )<br>      subnets = optional(<br>        map( // subnet human-readable name<br>          object({                               // Subnet name (must contain the landscape name)<br>            cidr        = string                 // subnet cidr<br>            zone        = string                 // subnet zone<br>          })<br>      ), null)<br>      subnets_edge = optional( // This will be the egress subnet for NGWs and Routes.<br>        map(                   // subnet human-readable name<br>          object({<br>            cidr        = string                 // subnet cidr<br>            zone        = string                 // subnet zone.  Each Edge Zone must be unique<br>          })<br>  ), null) }))</pre> | n/a | yes |
| <a name="input_route53_zone_management_id"></a> [route53\_zone\_management\_id](#input\_route53\_zone\_management\_id) | Management Route53 Hosted ID to associate with | `any` | n/a | yes |
| <a name="input_transition_days_glacier"></a> [transition\_days\_glacier](#input\_transition\_days\_glacier) | Number of days before objects are transitioned to glacier | `number` | `60` | no |
| <a name="input_transition_days_s3ia"></a> [transition\_days\_s3ia](#input\_transition\_days\_s3ia) | Number of days before objects are transitioned to IA | `number` | `30` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Whether versioning is enabled for s3 bucket | `string` | `"Enabled"` | no |
| <a name="input_vpc_dhcp_options_id"></a> [vpc\_dhcp\_options\_id](#input\_vpc\_dhcp\_options\_id) | Custom dhcpoptions id to use. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_backup_plan_id"></a> [aws\_backup\_plan\_id](#output\_aws\_backup\_plan\_id) | #### AWS Backup Service |
| <a name="output_efs_ha_app"></a> [efs\_ha\_app](#output\_efs\_ha\_app) | n/a |
| <a name="output_efs_usr_sap_trans"></a> [efs\_usr\_sap\_trans](#output\_efs\_usr\_sap\_trans) | #### EFS |
| <a name="output_internet_gateway"></a> [internet\_gateway](#output\_internet\_gateway) | #### Gateways |
| <a name="output_metadata"></a> [metadata](#output\_metadata) | n/a |
| <a name="output_nat_gateway"></a> [nat\_gateway](#output\_nat\_gateway) | n/a |
| <a name="output_network"></a> [network](#output\_network) | ##### Network |
| <a name="output_route53_zone"></a> [route53\_zone](#output\_route53\_zone) | #### Route53 |
| <a name="output_route_table"></a> [route\_table](#output\_route\_table) | #### Routes |
| <a name="output_s3_backups"></a> [s3\_backups](#output\_s3\_backups) | #### S3 Buckets |
| <a name="output_security_group_all_egress"></a> [security\_group\_all\_egress](#output\_security\_group\_all\_egress) | n/a |
| <a name="output_security_group_customer_access_management"></a> [security\_group\_customer\_access\_management](#output\_security\_group\_customer\_access\_management) | n/a |
| <a name="output_security_group_vpc"></a> [security\_group\_vpc](#output\_security\_group\_vpc) | #### Security Groups |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | #### Subnets |
| <a name="output_vpc_customer"></a> [vpc\_customer](#output\_vpc\_customer) | #### VPC |
<!-- END_TF_DOCS -->