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
| <a name="module_base_context"></a> [base\_context](#module\_base\_context) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_ibp_customer_infrastructure"></a> [ibp\_customer\_infrastructure](#module\_ibp\_customer\_infrastructure) | EXAMPLE_SOURCE/terraform/ibp/modules/ibp-customer-infrastructure-v3 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_zone_association.customer](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route53_zone_association) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/partition) | data source |
| [terraform_remote_state.management_layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.management_layer_01](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adv_backup_vault_force_destroy"></a> [adv\_backup\_vault\_force\_destroy](#input\_adv\_backup\_vault\_force\_destroy) | Force destroy recovery points to delete the backup vault | `bool` | `false` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_business"></a> [business](#input\_business) | Line of business which the resource is related to e.g., labs, build, ibp, scp, sac, hcm | `any` | n/a | yes |
| <a name="input_business_friendly_name"></a> [business\_friendly\_name](#input\_business\_friendly\_name) | Human readable friendly name of the line of business resources are being deployed for | `string` | n/a | yes |
| <a name="input_customer"></a> [customer](#input\_customer) | Short name for the customer | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment classification being deployed into; e.g. `development`, `production` | `string` | n/a | yes |
| <a name="input_management_nat_name"></a> [management\_nat\_name](#input\_management\_nat\_name) | AWS managment NAT route table name | `any` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | New Network Variable format | <pre>object({<br/>    use_new_network_model = bool<br/>    primary = object({<br/>      cidr = string<br/>      subnets = map(object({<br/>        zone = string<br/>        cidr = string<br/>      }))<br/>      subnets_edge = map(object({<br/>        zone = string<br/>        cidr = string<br/>      }))<br/>    })<br/>  })</pre> | <pre>{<br/>  "primary": {<br/>    "cidr": "",<br/>    "subnets": {},<br/>    "subnets_edge": {}<br/>  },<br/>  "use_new_network_model": false<br/>}</pre> | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Name of the organization work this work belongs to; will be used as part of naming prefix in special cases requiring globally unique resources to avoid clashing outside of the organization | `string` | n/a | yes |
| <a name="input_organization_friendly_name"></a> [organization\_friendly\_name](#input\_organization\_friendly\_name) | Human readable friendly name of the organization this work belongs to | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner of the account | `any` | n/a | yes |
| <a name="input_security_boundary"></a> [security\_boundary](#input\_security\_boundary) | Name of the security boundary being deployed into; will be used as part of naming prefix for all resources | `string` | n/a | yes |
| <a name="input_security_boundary_friendly_name"></a> [security\_boundary\_friendly\_name](#input\_security\_boundary\_friendly\_name) | Human readable friendly name of the security boundary being deployed into | `string` | n/a | yes |
| <a name="input_subnet_dataservices_1a_cidr_block"></a> [subnet\_dataservices\_1a\_cidr\_block](#input\_subnet\_dataservices\_1a\_cidr\_block) | CIDR block for the dataservices 1a subnet | `string` | `""` | no |
| <a name="input_subnet_dataservices_1b_cidr_block"></a> [subnet\_dataservices\_1b\_cidr\_block](#input\_subnet\_dataservices\_1b\_cidr\_block) | CIDR block for the dataservices 1b subnet | `string` | `""` | no |
| <a name="input_subnet_edge_1a_cidr_block"></a> [subnet\_edge\_1a\_cidr\_block](#input\_subnet\_edge\_1a\_cidr\_block) | CIDR block for the edge 1a subnet | `string` | `""` | no |
| <a name="input_subnet_edge_1b_cidr_block"></a> [subnet\_edge\_1b\_cidr\_block](#input\_subnet\_edge\_1b\_cidr\_block) | CIDR block for the edge 1b subnet | `string` | `""` | no |
| <a name="input_subnet_edge_1c_cidr_block"></a> [subnet\_edge\_1c\_cidr\_block](#input\_subnet\_edge\_1c\_cidr\_block) | CIDR block for the edge 1c subnet | `string` | `""` | no |
| <a name="input_subnet_production_1a_cidr_block"></a> [subnet\_production\_1a\_cidr\_block](#input\_subnet\_production\_1a\_cidr\_block) | CIDR block for the production 1a subnet | `string` | `""` | no |
| <a name="input_subnet_production_1b_cidr_block"></a> [subnet\_production\_1b\_cidr\_block](#input\_subnet\_production\_1b\_cidr\_block) | CIDR block for the production 1b subnet | `string` | `""` | no |
| <a name="input_subnet_staging_1a_cidr_block"></a> [subnet\_staging\_1a\_cidr\_block](#input\_subnet\_staging\_1a\_cidr\_block) | CIDR block for the staging 1a subnet | `string` | `""` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR block for the customer VPC | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output__context"></a> [\_context](#output\_\_context) | Metadata |
| <a name="output_infrastructure"></a> [infrastructure](#output\_infrastructure) | n/a |
| <a name="output_vpc_customer_cidr"></a> [vpc\_customer\_cidr](#output\_vpc\_customer\_cidr) | n/a |
| <a name="output_vpc_prefix"></a> [vpc\_prefix](#output\_vpc\_prefix) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
