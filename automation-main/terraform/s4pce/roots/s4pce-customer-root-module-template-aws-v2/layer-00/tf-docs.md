<!-- BEGIN_TF_DOCS -->
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
| <a name="module_base_context"></a> [base\_context](#module\_base\_context) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_s4pce_customer_infrastructure"></a> [s4pce\_customer\_infrastructure](#module\_s4pce\_customer\_infrastructure) | EXAMPLE_SOURCE/terraform/s4pce/modules/s4pce-customer-infrastructure-v2 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/partition) | data source |
| [terraform_remote_state.management_layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.management_layer_01](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_endpoints"></a> [additional\_endpoints](#input\_additional\_endpoints) | Additional endpoints | `list(string)` | `[]` | no |
| <a name="input_additional_endpoints_creation"></a> [additional\_endpoints\_creation](#input\_additional\_endpoints\_creation) | Additional endpoints state | `bool` | `false` | no |
| <a name="input_adv_backup_vault_force_destroy"></a> [adv\_backup\_vault\_force\_destroy](#input\_adv\_backup\_vault\_force\_destroy) | Force destroy recovery points to delete the backup vault | `bool` | `false` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `any` | n/a | yes |
| <a name="input_bucket_expiration"></a> [bucket\_expiration](#input\_bucket\_expiration) | Enable/Disable customer s3 backup bucket\_expiration rule | `string` | `"Disabled"` | no |
| <a name="input_bucket_retention_days"></a> [bucket\_retention\_days](#input\_bucket\_retention\_days) | Number of days before objects are deleted from S3 backup bucket | `number` | `180` | no |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_business"></a> [business](#input\_business) | Line of business which the resource is related to e.g., labs, build, ibp, scp, sac, hcm | `any` | n/a | yes |
| <a name="input_business_friendly_name"></a> [business\_friendly\_name](#input\_business\_friendly\_name) | Human readable friendly name of the line of business resources are being deployed for | `string` | n/a | yes |
| <a name="input_business_subsection"></a> [business\_subsection](#input\_business\_subsection) | Name of the line of business subsection | `string` | n/a | yes |
| <a name="input_custom_efs_throughput_in_mibps"></a> [custom\_efs\_throughput\_in\_mibps](#input\_custom\_efs\_throughput\_in\_mibps) | Use Local Account EFS throughput in mibps | `number` | `20` | no |
| <a name="input_custom_efs_throughput_mode"></a> [custom\_efs\_throughput\_mode](#input\_custom\_efs\_throughput\_mode) | Use Local Account EFS throughput mode | `string` | `"provisioned"` | no |
| <a name="input_custom_no_local_dns_zone"></a> [custom\_no\_local\_dns\_zone](#input\_custom\_no\_local\_dns\_zone) | Use Local Account dns zone | `bool` | `false` | no |
| <a name="input_custom_no_nat_gateways"></a> [custom\_no\_nat\_gateways](#input\_custom\_no\_nat\_gateways) | Disables the creation of NGWs in the private subnet | `bool` | `false` | no |
| <a name="input_customer"></a> [customer](#input\_customer) | Customer that uses the deployed system; e.g. `scs`, `management`, `customer00006` | `string` | n/a | yes |
| <a name="input_default_lifecycle_status"></a> [default\_lifecycle\_status](#input\_default\_lifecycle\_status) | Whether default LCM rule is enabled/disabled | `string` | `"Enabled"` | no |
| <a name="input_deploy_ha_efs"></a> [deploy\_ha\_efs](#input\_deploy\_ha\_efs) | Boolean Value. Default False. True to deploy HA-EFS | `bool` | `false` | no |
| <a name="input_enable_backup"></a> [enable\_backup](#input\_enable\_backup) | ### Disabling/Enabling Backup Plan Variable | `number` | `1` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment classification being deployed into; e.g. `development`, `production` | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | Map of Networks and Subnets. A primary network is required | <pre>map(<br>    object({                                   // network human-readable name. Requires a "primary"<br>      cidr      = string                       // network cidr<br>      primary_landscape = string // Primary deployment landscape. Must be contained within the subnet name. Ex: primary_landscape='production' requires subnet_name='production*'"<br>      landscape_default_deployment_zones = map(<br>        object({                // landscape name<br>          default_zone = string // default subnet zone for the landscape<br>        })<br>      )<br>      subnets = optional(<br>        map( // subnet human-readable name<br>          object({                               // Subnet name (must contain the landscape name)<br>            cidr        = string                 // subnet cidr<br>            zone        = string                 // subnet zone<br>          })<br>      ), null)<br>      subnets_edge = optional( // This will be the egress subnet for NGWs and Routes.<br>        map(                   // subnet human-readable name<br>          object({<br>            cidr        = string                 // subnet cidr<br>            zone        = string                 // subnet zone.  Each Edge Zone must be unique<br>          })<br>  ), null) }))</pre> | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | Name of the organization work this work belongs to; will be used as part of naming prefix in special cases requiring globally unique resources to avoid clashing outside of the organization | `string` | n/a | yes |
| <a name="input_organization_friendly_name"></a> [organization\_friendly\_name](#input\_organization\_friendly\_name) | Human readable friendly name of the organization this work belongs to | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner of the account | `any` | n/a | yes |
| <a name="input_security_boundary"></a> [security\_boundary](#input\_security\_boundary) | Name of the security boundary being deployed into; will be used as part of naming prefix for all resources | `string` | n/a | yes |
| <a name="input_security_boundary_friendly_name"></a> [security\_boundary\_friendly\_name](#input\_security\_boundary\_friendly\_name) | Human readable friendly name of the security boundary being deployed into | `string` | n/a | yes |
| <a name="input_transition_days_glacier"></a> [transition\_days\_glacier](#input\_transition\_days\_glacier) | Number of days before objects are transitioned to glacier | `number` | `60` | no |
| <a name="input_transition_days_s3ia"></a> [transition\_days\_s3ia](#input\_transition\_days\_s3ia) | Number of days before objects are transitioned to IA | `number` | `30` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Whether versioning is enabled for s3 bucket | `string` | `"Enabled"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output__context"></a> [\_context](#output\_\_context) | #### Metadata variables |
| <a name="output__friendly_name"></a> [\_friendly\_name](#output\_\_friendly\_name) | n/a |
| <a name="output__resource_prefix"></a> [\_resource\_prefix](#output\_\_resource\_prefix) | n/a |
| <a name="output__tags"></a> [\_tags](#output\_\_tags) | n/a |
| <a name="output_infrastructure"></a> [infrastructure](#output\_infrastructure) | n/a |
<!-- END_TF_DOCS -->