# azure-network

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.53.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.6.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 4.3.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.6.3 |
| <a name="provider_time"></a> [time](#provider\_time) | >= 0.12.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_application_security_group.main01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_security_group) | resource |
| [azurerm_nat_gateway.main01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |
| [azurerm_nat_gateway_public_ip_association.main01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association) | resource |
| [azurerm_network_security_group.main01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.customer_default_deny_all](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.customer_default_load_balancer_allow](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.default_security_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_public_ip.main01_nat](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.main01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_route_table.main01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_subnet.main01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_nat_gateway_association.main01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet_network_security_group_association.main01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.main01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_virtual_network.main01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_dns_servers.main01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_dns_servers) | resource |
| [random_id.azurerm_application_security_group](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.azurerm_nat_gateway](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.azurerm_network_security_group](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.azurerm_route_table](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [time_static.azurerm_application_security_group](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [time_static.azurerm_nat_gateway](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [time_static.azurerm_network_security_group](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [time_static.azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [time_static.azurerm_route_table](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_associates_private_route_tables"></a> [associates\_private\_route\_tables](#input\_associates\_private\_route\_tables) | Default:True  Associates each private (non-edge) subnet to a route table. | `bool` | `true` | no |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | The user who initiated the build | `string` | n/a | yes |
| <a name="input_deploy_nat_gateways"></a> [deploy\_nat\_gateways](#input\_deploy\_nat\_gateways) | Default:True  Deploys Nat Gateways per zone | `bool` | `true` | no |
| <a name="input_deploy_private_route_tables"></a> [deploy\_private\_route\_tables](#input\_deploy\_private\_route\_tables) | Default:True  Creates (private) route tables per zone. | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | The Azure region to deploy resources | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A collection of tags to apply | `map(string)` | n/a | yes |
| <a name="input_use_custom_dhcpoptions_dns"></a> [use\_custom\_dhcpoptions\_dns](#input\_use\_custom\_dhcpoptions\_dns) | Use Custom DNS Values for DHCP Options | `list(string)` | `[]` | no |
| <a name="input_use_default_security_rules"></a> [use\_default\_security\_rules](#input\_use\_default\_security\_rules) | Default:True  Use default security rules for the ASG. Allow all egress. Allow all intra-VPC | `bool` | `true` | no |
| <a name="input_vnet_cidr_blocks"></a> [vnet\_cidr\_blocks](#input\_vnet\_cidr\_blocks) | CIDR blocks for the customer VNet. Can include IPv6 | `list(string)` | n/a | yes |
| <a name="input_vnet_subnets"></a> [vnet\_subnets](#input\_vnet\_subnets) | Configuration block for provisioning the customer subnets, subnet 'edge' is required | <pre>map(<br/>    object({               // subnet human-readable name<br/>      cidr = list(string), // Can be one IPv4 and one IPv6 CIDR. IPv6 must be /64<br/>      zone = string        // subnet zone<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_security_group"></a> [application\_security\_group](#output\_application\_security\_group) | n/a |
| <a name="output_application_security_rules"></a> [application\_security\_rules](#output\_application\_security\_rules) | n/a |
| <a name="output_debug_main"></a> [debug\_main](#output\_debug\_main) | n/a |
| <a name="output_nat_gateways"></a> [nat\_gateways](#output\_nat\_gateways) | #### NAT Gateways |
| <a name="output_network_security_group"></a> [network\_security\_group](#output\_network\_security\_group) | ##### Security Groups ## Network |
| <a name="output_resource_group_main01"></a> [resource\_group\_main01](#output\_resource\_group\_main01) | n/a |
| <a name="output_route_tables"></a> [route\_tables](#output\_route\_tables) | #### Route Tables |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | n/a |
| <a name="output_vnet_main01"></a> [vnet\_main01](#output\_vnet\_main01) | #### VNets |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
