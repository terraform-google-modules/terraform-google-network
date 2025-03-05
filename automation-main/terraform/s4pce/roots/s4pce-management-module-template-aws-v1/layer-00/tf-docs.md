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

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_context"></a> [base\_context](#module\_base\_context) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_aws_route53_resolver_endpoint_main01_inbound"></a> [context\_aws\_route53\_resolver\_endpoint\_main01\_inbound](#module\_context\_aws\_route53\_resolver\_endpoint\_main01\_inbound) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_aws_route53_zone_main01"></a> [context\_aws\_route53\_zone\_main01](#module\_context\_aws\_route53\_zone\_main01) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_aws_security_group_main01_access_edge"></a> [context\_aws\_security\_group\_main01\_access\_edge](#module\_context\_aws\_security\_group\_main01\_access\_edge) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_aws_security_group_main01_access_edge_nessus"></a> [context\_aws\_security\_group\_main01\_access\_edge\_nessus](#module\_context\_aws\_security\_group\_main01\_access\_edge\_nessus) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_aws_security_group_main01_access_edge_ssh"></a> [context\_aws\_security\_group\_main01\_access\_edge\_ssh](#module\_context\_aws\_security\_group\_main01\_access\_edge\_ssh) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_aws_security_group_main01_all_egress"></a> [context\_aws\_security\_group\_main01\_all\_egress](#module\_context\_aws\_security\_group\_main01\_all\_egress) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_aws_security_group_main01_efs_common"></a> [context\_aws\_security\_group\_main01\_efs\_common](#module\_context\_aws\_security\_group\_main01\_efs\_common) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_aws_security_group_main01_relay"></a> [context\_aws\_security\_group\_main01\_relay](#module\_context\_aws\_security\_group\_main01\_relay) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_aws_security_group_main01_vpc"></a> [context\_aws\_security\_group\_main01\_vpc](#module\_context\_aws\_security\_group\_main01\_vpc) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_default_route_table.main01_default](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/default_route_table) | resource |
| [aws_default_security_group.main01_default](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/default_security_group) | resource |
| [aws_eip.main01_nat_edge_1a](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/eip) | resource |
| [aws_eip.main01_nat_edge_1b](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/eip) | resource |
| [aws_eip.main01_nat_edge_1c](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/eip) | resource |
| [aws_internet_gateway.main01](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.main01_nat_edge_1a](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/nat_gateway) | resource |
| [aws_nat_gateway.main01_nat_edge_1b](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/nat_gateway) | resource |
| [aws_nat_gateway.main01_nat_edge_1c](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/nat_gateway) | resource |
| [aws_route.main01_default_route_igw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route) | resource |
| [aws_route.main01_nat_edge_1a_route](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route) | resource |
| [aws_route.main01_nat_edge_1b_route](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route) | resource |
| [aws_route.main01_nat_edge_1c_route](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route) | resource |
| [aws_route53_resolver_endpoint.main01_inbound](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route53_resolver_endpoint) | resource |
| [aws_route53_vpc_association_authorization.main01](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route53_vpc_association_authorization) | resource |
| [aws_route53_zone.main01](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route53_zone) | resource |
| [aws_route_table.main01_nat_edge_1a](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route_table) | resource |
| [aws_route_table.main01_nat_edge_1b](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route_table) | resource |
| [aws_route_table.main01_nat_edge_1c](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route_table) | resource |
| [aws_route_table_association.main01_infrastructure_1a](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.main01_infrastructure_1b](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.main01_infrastructure_1c](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route_table_association) | resource |
| [aws_security_group.main01_access_edge](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group) | resource |
| [aws_security_group.main01_access_edge_nessus](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group) | resource |
| [aws_security_group.main01_access_edge_ssh](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group) | resource |
| [aws_security_group.main01_all_egress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group) | resource |
| [aws_security_group.main01_efs_common](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group) | resource |
| [aws_security_group.main01_relay](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group) | resource |
| [aws_security_group.main01_vpc](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group) | resource |
| [aws_security_group_rule.main01_access_edge_dns_tcp](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.main01_access_edge_dns_udp](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.main01_access_edge_openvpn](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.main01_access_edge_whitelist_http](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.main01_access_edge_whitelist_https](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.main01_access_edge_whitelist_nessus_8834](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.main01_access_edge_whitelist_ssh](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.main01_all_egress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.main01_relay_standard_ingress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.main01_vpc_standard_egress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.main01_vpc_standard_ingress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_subnet.main01_edge_1a](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/subnet) | resource |
| [aws_subnet.main01_edge_1b](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/subnet) | resource |
| [aws_subnet.main01_edge_1c](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/subnet) | resource |
| [aws_subnet.main01_infrastructure_1a](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/subnet) | resource |
| [aws_subnet.main01_infrastructure_1b](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/subnet) | resource |
| [aws_subnet.main01_infrastructure_1c](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/subnet) | resource |
| [aws_vpc.main01](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc) | resource |
| [aws_vpc_dhcp_options.main01](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc_dhcp_options) | resource |
| [aws_vpc_dhcp_options_association.main01](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc_dhcp_options_association) | resource |
| [aws_vpc_endpoint.private_s3](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint_route_table_association.main01_default_s3](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_endpoint_route_table_association.main01_infrastructure_1a_s3](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_endpoint_route_table_association.main01_infrastructure_1b_s3](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_endpoint_route_table_association.main01_infrastructure_1c_s3](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_business"></a> [business](#input\_business) | Name of the line of business resources are being deployed for; will be used as part of naming prefix for all resources | `string` | n/a | yes |
| <a name="input_business_friendly_name"></a> [business\_friendly\_name](#input\_business\_friendly\_name) | Human readable friendly name of the line of business resources are being deployed for | `string` | n/a | yes |
| <a name="input_business_subsection"></a> [business\_subsection](#input\_business\_subsection) | Name of the line of business subsection | `string` | n/a | yes |
| <a name="input_cloud_in_country"></a> [cloud\_in\_country](#input\_cloud\_in\_country) | (Optional) The country being deployed into | `object({ name = string, formatted = string, friendly = string })` | <pre>{<br/>  "formatted": null,<br/>  "friendly": null,<br/>  "name": null<br/>}</pre> | no |
| <a name="input_customer"></a> [customer](#input\_customer) | Customer that uses the deployed system; e.g. `ns2`, `management`, `customer00006` | `string` | n/a | yes |
| <a name="input_dns_authorization_vpc_ids"></a> [dns\_authorization\_vpc\_ids](#input\_dns\_authorization\_vpc\_ids) | This is used to authorize VPCs in other accounts to be associated to the internal FQDN. This will only authorize. Association should be done from the other account provider. | `list(object({ vpc_id = string, region = string, description = string }))` | `[]` | no |
| <a name="input_dns_fqdn"></a> [dns\_fqdn](#input\_dns\_fqdn) | Sets the FQDN of the private hosted zone in Route 53 for the DNS Domain | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment classification being deployed into; e.g. `development`, `production` | `string` | n/a | yes |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | (Default set within context) Ordering of the labels to be picked up by the environment's base\_context; used for resource name prefixing | `list(string)` | `null` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Name of the organization work this work belongs to; will be used as part of naming prefix in special cases requiring globally unique resources to avoid clashing outside of the organization | `string` | n/a | yes |
| <a name="input_organization_friendly_name"></a> [organization\_friendly\_name](#input\_organization\_friendly\_name) | Human readable friendly name of the organization this work belongs to | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Email address directing communication to the party responsible for the system; e.g., `isso@sapns2.com`, `isse@sapsn2.com`, `dhibpops@sapns2.com` | `string` | n/a | yes |
| <a name="input_security_boundary"></a> [security\_boundary](#input\_security\_boundary) | Name of the security boundary being deployed into; will be used as part of naming prefix for all resources | `string` | n/a | yes |
| <a name="input_security_boundary_friendly_name"></a> [security\_boundary\_friendly\_name](#input\_security\_boundary\_friendly\_name) | Human readable friendly name of the security boundary being deployed into | `string` | n/a | yes |
| <a name="input_subnet_main01_edge_1a_cidr_block"></a> [subnet\_main01\_edge\_1a\_cidr\_block](#input\_subnet\_main01\_edge\_1a\_cidr\_block) | CIDR block for the main01\_edge\_1a subnet | `any` | n/a | yes |
| <a name="input_subnet_main01_edge_1b_cidr_block"></a> [subnet\_main01\_edge\_1b\_cidr\_block](#input\_subnet\_main01\_edge\_1b\_cidr\_block) | CIDR block for the main01\_edge\_1b subnet | `any` | n/a | yes |
| <a name="input_subnet_main01_edge_1c_cidr_block"></a> [subnet\_main01\_edge\_1c\_cidr\_block](#input\_subnet\_main01\_edge\_1c\_cidr\_block) | CIDR block for the main01\_edge\_1c subnet | `any` | n/a | yes |
| <a name="input_subnet_main01_infrastructure_1a_cidr_block"></a> [subnet\_main01\_infrastructure\_1a\_cidr\_block](#input\_subnet\_main01\_infrastructure\_1a\_cidr\_block) | CIDR block for the main01\_infrastructure\_1a subnet | `any` | n/a | yes |
| <a name="input_subnet_main01_infrastructure_1b_cidr_block"></a> [subnet\_main01\_infrastructure\_1b\_cidr\_block](#input\_subnet\_main01\_infrastructure\_1b\_cidr\_block) | CIDR block for the main01\_infrastructure\_1b subnet | `any` | n/a | yes |
| <a name="input_subnet_main01_infrastructure_1c_cidr_block"></a> [subnet\_main01\_infrastructure\_1c\_cidr\_block](#input\_subnet\_main01\_infrastructure\_1c\_cidr\_block) | CIDR block for the main01\_infrastructure\_1c subnet | `any` | n/a | yes |
| <a name="input_tenant_vpc_cidr_block"></a> [tenant\_vpc\_cidr\_block](#input\_tenant\_vpc\_cidr\_block) | CIDR superblock for the tenant VPCs | `list(string)` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR block for the VPC | `any` | n/a | yes |
| <a name="input_whitelisted_ip_addresses"></a> [whitelisted\_ip\_addresses](#input\_whitelisted\_ip\_addresses) | Map of ip addresses to whitelist access to HashiCorp Vault | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output__context"></a> [\_context](#output\_\_context) | #### Metadata variables |
| <a name="output__friendly_name"></a> [\_friendly\_name](#output\_\_friendly\_name) | n/a |
| <a name="output__resource_prefix"></a> [\_resource\_prefix](#output\_\_resource\_prefix) | n/a |
| <a name="output__tags"></a> [\_tags](#output\_\_tags) | n/a |
| <a name="output_internet_gateway_main01"></a> [internet\_gateway\_main01](#output\_internet\_gateway\_main01) | #### Gateways |
| <a name="output_nat_gateway_main01_nat_edge_1a"></a> [nat\_gateway\_main01\_nat\_edge\_1a](#output\_nat\_gateway\_main01\_nat\_edge\_1a) | n/a |
| <a name="output_nat_gateway_main01_nat_edge_1b"></a> [nat\_gateway\_main01\_nat\_edge\_1b](#output\_nat\_gateway\_main01\_nat\_edge\_1b) | n/a |
| <a name="output_nat_gateway_main01_nat_edge_1c"></a> [nat\_gateway\_main01\_nat\_edge\_1c](#output\_nat\_gateway\_main01\_nat\_edge\_1c) | n/a |
| <a name="output_route53_resolver_endpoint_main01_inbound"></a> [route53\_resolver\_endpoint\_main01\_inbound](#output\_route53\_resolver\_endpoint\_main01\_inbound) | n/a |
| <a name="output_route53_zone_main01"></a> [route53\_zone\_main01](#output\_route53\_zone\_main01) | #### Route53 |
| <a name="output_route_table_main01_default"></a> [route\_table\_main01\_default](#output\_route\_table\_main01\_default) | #### Routes |
| <a name="output_route_table_main01_nat_edge_1a"></a> [route\_table\_main01\_nat\_edge\_1a](#output\_route\_table\_main01\_nat\_edge\_1a) | n/a |
| <a name="output_route_table_main01_nat_edge_1b"></a> [route\_table\_main01\_nat\_edge\_1b](#output\_route\_table\_main01\_nat\_edge\_1b) | n/a |
| <a name="output_route_table_main01_nat_edge_1c"></a> [route\_table\_main01\_nat\_edge\_1c](#output\_route\_table\_main01\_nat\_edge\_1c) | n/a |
| <a name="output_security_group_main01_access_edge"></a> [security\_group\_main01\_access\_edge](#output\_security\_group\_main01\_access\_edge) | n/a |
| <a name="output_security_group_main01_access_edge_nessus"></a> [security\_group\_main01\_access\_edge\_nessus](#output\_security\_group\_main01\_access\_edge\_nessus) | n/a |
| <a name="output_security_group_main01_access_edge_ssh"></a> [security\_group\_main01\_access\_edge\_ssh](#output\_security\_group\_main01\_access\_edge\_ssh) | n/a |
| <a name="output_security_group_main01_all_egress"></a> [security\_group\_main01\_all\_egress](#output\_security\_group\_main01\_all\_egress) | n/a |
| <a name="output_security_group_main01_efs_common"></a> [security\_group\_main01\_efs\_common](#output\_security\_group\_main01\_efs\_common) | n/a |
| <a name="output_security_group_main01_relay"></a> [security\_group\_main01\_relay](#output\_security\_group\_main01\_relay) | n/a |
| <a name="output_security_group_main01_vpc"></a> [security\_group\_main01\_vpc](#output\_security\_group\_main01\_vpc) | ##### Security Groups |
| <a name="output_subnet_main01_edge_1a"></a> [subnet\_main01\_edge\_1a](#output\_subnet\_main01\_edge\_1a) | n/a |
| <a name="output_subnet_main01_edge_1b"></a> [subnet\_main01\_edge\_1b](#output\_subnet\_main01\_edge\_1b) | n/a |
| <a name="output_subnet_main01_edge_1c"></a> [subnet\_main01\_edge\_1c](#output\_subnet\_main01\_edge\_1c) | n/a |
| <a name="output_subnet_main01_infrastructure_1a"></a> [subnet\_main01\_infrastructure\_1a](#output\_subnet\_main01\_infrastructure\_1a) | #### Subnets |
| <a name="output_subnet_main01_infrastructure_1b"></a> [subnet\_main01\_infrastructure\_1b](#output\_subnet\_main01\_infrastructure\_1b) | n/a |
| <a name="output_subnet_main01_infrastructure_1c"></a> [subnet\_main01\_infrastructure\_1c](#output\_subnet\_main01\_infrastructure\_1c) | n/a |
| <a name="output_vpc_main01"></a> [vpc\_main01](#output\_vpc\_main01) | #### VPC |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
