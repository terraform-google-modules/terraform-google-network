# aws-network

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.3 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.6.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.3 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.6.3 |
| <a name="provider_time"></a> [time](#provider\_time) | >= 0.9 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_default_route_table.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table) | resource |
| [aws_default_security_group.main_default_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_egress_only_internet_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/egress_only_internet_gateway) | resource |
| [aws_eip.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.main_default_igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.main_default_igw_ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.main_egress_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.main_ngw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.main_base_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.main_base_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_dhcp_options_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options_association) | resource |
| [aws_vpc_endpoint.private_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint_route_table_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_endpoint_route_table_association.main_default_igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_ipv4_cidr_block_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipv4_cidr_block_association) | resource |
| [aws_vpc_security_group_egress_rule.main_base_egress_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.main_base_egress_ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.vpc_self_ingress_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.vpc_self_ingress_ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [random_id.main_base_egress](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.main_base_ingress](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [time_static.aws_nat_gateway](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [time_static.aws_route_table](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [time_static.aws_subnet](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [time_static.aws_vpc](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_associates_private_route_tables"></a> [associates\_private\_route\_tables](#input\_associates\_private\_route\_tables) | Associates each private (non-edge) subnet to a route table. | `bool` | `true` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region where the module is run | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_custom_dhcpoptions_id"></a> [custom\_dhcpoptions\_id](#input\_custom\_dhcpoptions\_id) | AWS ID of alternative dhcptions to associate with VPC | `string` | `""` | no |
| <a name="input_deploy_nat_gateways"></a> [deploy\_nat\_gateways](#input\_deploy\_nat\_gateways) | Creates NAT/Egress Only Gateway deployment per zone | `bool` | `true` | no |
| <a name="input_deploy_private_route_tables"></a> [deploy\_private\_route\_tables](#input\_deploy\_private\_route\_tables) | Creates (private) route tables per zone. | `bool` | `true` | no |
| <a name="input_network"></a> [network](#input\_network) | Map of Networks and Subnets. A primary network is required | <pre>map(<br/>    object({                                   // network human-readable name. Requires a "primary"<br/>      cidr      = string                       // network cidr<br/>      ipv6_ipam = optional(string, "disabled") // network ipv6 cidr.  Only accepts "aws" for aws generated ipv6 for now.<br/>      subnets = optional(<br/>        map( // subnet human-readable name<br/>          object({<br/>            cidr        = string                 // subnet cidr<br/>            zone        = string                 // subnet zone<br/>            ipv6_netnum = optional(string, null) // Optional ipv6 subnet number. Auto-generates from allocated ipv6 CIDR.<br/>          })<br/>      ), null)<br/>      subnets_edge = optional( // This will be the egress subnet for NGWs and Routes.<br/>        map(                   // subnet human-readable name<br/>          object({<br/>            cidr        = string                 // subnet cidr<br/>            zone        = string                 // subnet zone.  Each Edge Zone must be unique<br/>            ipv6_netnum = optional(string, null) // Optional ipv6 subnet number. Auto-generates from allocated ipv6 CIDR.<br/>          })<br/>  ), null) }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to apply to resources | `map(string)` | n/a | yes |
| <a name="input_use_default_security_rules"></a> [use\_default\_security\_rules](#input\_use\_default\_security\_rules) | Create default security group rules.  All egress. All intra-VPC | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_egress_only_internet_gateway"></a> [egress\_only\_internet\_gateway](#output\_egress\_only\_internet\_gateway) | Egress Only Internet Gateway |
| <a name="output_internet_gateway"></a> [internet\_gateway](#output\_internet\_gateway) | Internet Gateway Output |
| <a name="output_metadata"></a> [metadata](#output\_metadata) | n/a |
| <a name="output_nat_gateways"></a> [nat\_gateways](#output\_nat\_gateways) | NAT Gateways (IPv4) |
| <a name="output_route_tables"></a> [route\_tables](#output\_route\_tables) | Route Tables |
| <a name="output_security_groups"></a> [security\_groups](#output\_security\_groups) | Security Groups |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | Subnets |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | VPCs |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
