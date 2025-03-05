# azure-network

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lb_network"></a> [lb\_network](#module\_lb\_network) | ../terraform-azurerm-network | n/a |
| <a name="module_private_link_endpoint_network"></a> [private\_link\_endpoint\_network](#module\_private\_link\_endpoint\_network) | ../terraform-azurerm-network | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | The address space that is used by the virtual network. | `string` | `"10.0.0.0/16"` | no |
| <a name="input_address_space2"></a> [address\_space2](#input\_address\_space2) | The address space that is used by the virtual network. | `string` | `"10.0.0.0/16"` | no |
| <a name="input_az_location"></a> [az\_location](#input\_az\_location) | azure region. | `string` | `"eastus"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group. | `string` | n/a | yes |
| <a name="input_skip_provider_registration"></a> [skip\_provider\_registration](#input\_skip\_provider\_registration) | n/a | `bool` | `false` | no |
| <a name="input_subnet_enforce_private_link_endpoint_network_policies"></a> [subnet\_enforce\_private\_link\_endpoint\_network\_policies](#input\_subnet\_enforce\_private\_link\_endpoint\_network\_policies) | A map with key (string) `subnet name`, value (bool) `true` or `false` to indicate enable or disable network policies for the private link endpoint on the subnet. Default value is false. | `map(bool)` | `{}` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of public subnet ids inside the vNet. | `list(string)` | `[]` | no |
| <a name="input_subnet_ids2"></a> [subnet\_ids2](#input\_subnet\_ids2) | A list of public subnet ids inside the vNet. | `list(string)` | `[]` | no |
| <a name="input_subnet_names"></a> [subnet\_names](#input\_subnet\_names) | A list of public subnets inside the vNet. | `list(string)` | <pre>[<br/>  "samprivate_link_endpoint-subnet"<br/>]</pre> | no |
| <a name="input_subnet_names2"></a> [subnet\_names2](#input\_subnet\_names2) | A list of public subnets inside the vNet. | `list(string)` | <pre>[<br/>  "samprivate_link_endpoint-subnet"<br/>]</pre> | no |
| <a name="input_subnet_prefixes"></a> [subnet\_prefixes](#input\_subnet\_prefixes) | The address prefix to use for the subnet. | `list(string)` | <pre>[<br/>  "10.0.1.0/24"<br/>]</pre> | no |
| <a name="input_subnet_prefixes2"></a> [subnet\_prefixes2](#input\_subnet\_prefixes2) | The address prefix to use for the subnet. | `list(string)` | <pre>[<br/>  "10.0.1.0/24"<br/>]</pre> | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of the vnet to create | `string` | n/a | yes |
| <a name="input_vnet_name2"></a> [vnet\_name2](#input\_vnet\_name2) | Name of the vnet to create | `string` | `"samprivate_link_endpoint-vnet"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lb_vnet_address_space"></a> [lb\_vnet\_address\_space](#output\_lb\_vnet\_address\_space) | The address space of the newly created vNet |
| <a name="output_lb_vnet_id"></a> [lb\_vnet\_id](#output\_lb\_vnet\_id) | The id of the newly created vNet |
| <a name="output_lb_vnet_location"></a> [lb\_vnet\_location](#output\_lb\_vnet\_location) | The location of the newly created vNet |
| <a name="output_lb_vnet_name"></a> [lb\_vnet\_name](#output\_lb\_vnet\_name) | The name of the newly created vNet |
| <a name="output_lb_vnet_subnets"></a> [lb\_vnet\_subnets](#output\_lb\_vnet\_subnets) | The ids of subnets created inside the newly created vNet |
| <a name="output_private_link_endpoint_vnet_address_space"></a> [private\_link\_endpoint\_vnet\_address\_space](#output\_private\_link\_endpoint\_vnet\_address\_space) | The address space of the newly created vNet |
| <a name="output_private_link_endpoint_vnet_id"></a> [private\_link\_endpoint\_vnet\_id](#output\_private\_link\_endpoint\_vnet\_id) | The id of the newly created vNet |
| <a name="output_private_link_endpoint_vnet_location"></a> [private\_link\_endpoint\_vnet\_location](#output\_private\_link\_endpoint\_vnet\_location) | The location of the newly created vNet |
| <a name="output_private_link_endpoint_vnet_name"></a> [private\_link\_endpoint\_vnet\_name](#output\_private\_link\_endpoint\_vnet\_name) | The name of the newly created vNet |
| <a name="output_private_link_endpoint_vnet_subnets"></a> [private\_link\_endpoint\_vnet\_subnets](#output\_private\_link\_endpoint\_vnet\_subnets) | The ids of subnets created inside the newly created vNet |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
