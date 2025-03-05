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
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_context"></a> [base\_context](#module\_base\_context) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_s4pce_customer_infrastructure"></a> [s4pce\_customer\_infrastructure](#module\_s4pce\_customer\_infrastructure) | EXAMPLE_SOURCE/terraform/s4pce/modules/s4pce-customer-infrastructure | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/partition) | data source |
| [terraform_remote_state.management_layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_endpoints"></a> [additional\_endpoints](#input\_additional\_endpoints) | Additional endpoints | `list(string)` | `[]` | no |
| <a name="input_additional_endpoints_creation"></a> [additional\_endpoints\_creation](#input\_additional\_endpoints\_creation) | Additional endpoints state | `bool` | `false` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_business"></a> [business](#input\_business) | Line of business which the resource is related to e.g., labs, build, ibp, scp, sac, hcm | `any` | n/a | yes |
| <a name="input_business_friendly_name"></a> [business\_friendly\_name](#input\_business\_friendly\_name) | Human readable friendly name of the line of business resources are being deployed for | `string` | n/a | yes |
| <a name="input_business_subsection"></a> [business\_subsection](#input\_business\_subsection) | Name of the line of business subsection | `string` | n/a | yes |
| <a name="input_customer"></a> [customer](#input\_customer) | Customer that uses the deployed system; e.g. `scs`, `management`, `customer00006` | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment classification being deployed into; e.g. `development`, `production` | `string` | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | Name of the organization work this work belongs to; will be used as part of naming prefix in special cases requiring globally unique resources to avoid clashing outside of the organization | `string` | n/a | yes |
| <a name="input_organization_friendly_name"></a> [organization\_friendly\_name](#input\_organization\_friendly\_name) | Human readable friendly name of the organization this work belongs to | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner of the account | `any` | n/a | yes |
| <a name="input_security_boundary"></a> [security\_boundary](#input\_security\_boundary) | Name of the security boundary being deployed into; will be used as part of naming prefix for all resources | `string` | n/a | yes |
| <a name="input_security_boundary_friendly_name"></a> [security\_boundary\_friendly\_name](#input\_security\_boundary\_friendly\_name) | Human readable friendly name of the security boundary being deployed into | `string` | n/a | yes |
| <a name="input_subnet_development_1a_cidr_block"></a> [subnet\_development\_1a\_cidr\_block](#input\_subnet\_development\_1a\_cidr\_block) | CIDR block for the development 1a subnet | `any` | n/a | yes |
| <a name="input_subnet_development_1b_cidr_block"></a> [subnet\_development\_1b\_cidr\_block](#input\_subnet\_development\_1b\_cidr\_block) | CIDR block for the development 1b subnet | `any` | n/a | yes |
| <a name="input_subnet_development_1c_cidr_block"></a> [subnet\_development\_1c\_cidr\_block](#input\_subnet\_development\_1c\_cidr\_block) | CIDR block for the development 1c subnet | `any` | n/a | yes |
| <a name="input_subnet_edge_1a_cidr_block"></a> [subnet\_edge\_1a\_cidr\_block](#input\_subnet\_edge\_1a\_cidr\_block) | CIDR block for the edge 1a subnet | `any` | n/a | yes |
| <a name="input_subnet_edge_1b_cidr_block"></a> [subnet\_edge\_1b\_cidr\_block](#input\_subnet\_edge\_1b\_cidr\_block) | CIDR block for the edge 1b subnet | `any` | n/a | yes |
| <a name="input_subnet_edge_1c_cidr_block"></a> [subnet\_edge\_1c\_cidr\_block](#input\_subnet\_edge\_1c\_cidr\_block) | CIDR block for the edge 1c subnet | `any` | n/a | yes |
| <a name="input_subnet_production_1a_cidr_block"></a> [subnet\_production\_1a\_cidr\_block](#input\_subnet\_production\_1a\_cidr\_block) | CIDR block for the production 1a subnet | `any` | n/a | yes |
| <a name="input_subnet_production_1b_cidr_block"></a> [subnet\_production\_1b\_cidr\_block](#input\_subnet\_production\_1b\_cidr\_block) | CIDR block for the production 1b subnet | `any` | n/a | yes |
| <a name="input_subnet_production_1c_cidr_block"></a> [subnet\_production\_1c\_cidr\_block](#input\_subnet\_production\_1c\_cidr\_block) | CIDR block for the production 1c subnet | `any` | n/a | yes |
| <a name="input_subnet_quality_assurance_1a_cidr_block"></a> [subnet\_quality\_assurance\_1a\_cidr\_block](#input\_subnet\_quality\_assurance\_1a\_cidr\_block) | CIDR block for the quality-assurance 1a subnet | `any` | n/a | yes |
| <a name="input_subnet_quality_assurance_1b_cidr_block"></a> [subnet\_quality\_assurance\_1b\_cidr\_block](#input\_subnet\_quality\_assurance\_1b\_cidr\_block) | CIDR block for the quality-assurance 1b subnet | `any` | n/a | yes |
| <a name="input_subnet_quality_assurance_1c_cidr_block"></a> [subnet\_quality\_assurance\_1c\_cidr\_block](#input\_subnet\_quality\_assurance\_1c\_cidr\_block) | CIDR block for the quality-assurance 1c subnet | `any` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR block for the customer VPC | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output__context"></a> [\_context](#output\_\_context) | #### Metadata variables |
| <a name="output__friendly_name"></a> [\_friendly\_name](#output\_\_friendly\_name) | n/a |
| <a name="output__resource_prefix"></a> [\_resource\_prefix](#output\_\_resource\_prefix) | n/a |
| <a name="output__tags"></a> [\_tags](#output\_\_tags) | n/a |
| <a name="output_infrastructure"></a> [infrastructure](#output\_infrastructure) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
