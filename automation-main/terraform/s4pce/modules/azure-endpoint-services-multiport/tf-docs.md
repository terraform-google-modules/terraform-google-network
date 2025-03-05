# azure-endpoint-services-multiport

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.5.7 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=4.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=4.3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_lb.loadbalancer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.backend_address_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_nat_rule.nat_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_nat_rule) | resource |
| [azurerm_lb_probe.probe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |
| [azurerm_lb_rule.rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule) | resource |
| [azurerm_private_endpoint.privateendpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_link_service.privatelinkservice](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_link_service) | resource |
| [azurerm_public_ip.public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adv_lb_no_zone"></a> [adv\_lb\_no\_zone](#input\_adv\_lb\_no\_zone) | Optional. Do not assign a zone to the loadbalancer | `bool` | `false` | no |
| <a name="input_context"></a> [context](#input\_context) | n/a | <pre>object({<br/>    account_id             = string<br/>    additional_tags        = map(string)<br/>    build_user             = string<br/>    business               = string<br/>    customer               = string<br/>    delimiter              = string<br/>    environment            = string<br/>    environment_salt       = string<br/>    generated_by           = string<br/>    include_customer_label = bool<br/>    label_order            = list(string)<br/>    managed_by             = string<br/>    module                 = string<br/>    module_version         = string<br/>    name_prefix            = string<br/>    organization           = string<br/>    owner                  = string<br/>    partition              = string<br/>    parent_module          = string<br/>    parent_module_version  = string<br/>    regex_replace_chars    = string<br/>    region                 = string<br/>    root_module            = string<br/>    security_boundary      = string<br/><br/>    custom_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    environment_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    module_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    resource_tags = list(<br/>      object({<br/>        name         = string<br/>        value        = string<br/>        required     = bool<br/>        pass_context = bool<br/>      })<br/>    )<br/><br/>  })</pre> | `null` | no |
| <a name="input_domain_name_labels"></a> [domain\_name\_labels](#input\_domain\_name\_labels) | (Optional) domain name label. This is only needed if we use public IPs/Azure domain names | `list(string)` | `[]` | no |
| <a name="input_enable_domain_name"></a> [enable\_domain\_name](#input\_enable\_domain\_name) | (Optional) whether to use domain name or not | `bool` | `false` | no |
| <a name="input_front_end_ip_zones"></a> [front\_end\_ip\_zones](#input\_front\_end\_ip\_zones) | Zones for loadbalancer frontend IP. | `list(string)` | n/a | yes |
| <a name="input_frontend_private_ip_addresses"></a> [frontend\_private\_ip\_addresses](#input\_frontend\_private\_ip\_addresses) | (Optional) private ip addresses to assign to frontend. Use it with type = private and address allocation is static. | `list(string)` | <pre>[<br/>  ""<br/>]</pre> | no |
| <a name="input_loadbalancer_backend_pool_names"></a> [loadbalancer\_backend\_pool\_names](#input\_loadbalancer\_backend\_pool\_names) | (Required)list of names of LB backend pools. | `list(string)` | <pre>[<br/>  "default-backendpool"<br/>]</pre> | no |
| <a name="input_loadbalancer_enable_floating_ip"></a> [loadbalancer\_enable\_floating\_ip](#input\_loadbalancer\_enable\_floating\_ip) | (Optional) Enable floating ip for load balancer or not. | `bool` | `false` | no |
| <a name="input_loadbalancer_frontend_private_ip_address_allocation"></a> [loadbalancer\_frontend\_private\_ip\_address\_allocation](#input\_loadbalancer\_frontend\_private\_ip\_address\_allocation) | (Optional) Frontend ip allocation type (Static or Dynamic) | `string` | `"Dynamic"` | no |
| <a name="input_loadbalancer_frontendip_private_link_map"></a> [loadbalancer\_frontendip\_private\_link\_map](#input\_loadbalancer\_frontendip\_private\_link\_map) | A map with loadbalancer\_frontend\_ip\_name/private\_link\_service\_name/private\_endpoint\_name. | <pre>map(object({<br/>    loadbalancer_frontend_ip_name = string<br/>    private_link_service_name     = string<br/>    private_endpoint_name         = string<br/>  }))</pre> | n/a | yes |
| <a name="input_loadbalancer_idle_timeout_in_minutes"></a> [loadbalancer\_idle\_timeout\_in\_minutes](#input\_loadbalancer\_idle\_timeout\_in\_minutes) | (Optional) idle timeout in mins | `number` | `5` | no |
| <a name="input_loadbalancer_name"></a> [loadbalancer\_name](#input\_loadbalancer\_name) | (Required) Name for the loadbalancer | `string` | n/a | yes |
| <a name="input_loadbalancer_port"></a> [loadbalancer\_port](#input\_loadbalancer\_port) | (Required) Protocols to be used for lb rules. Format as [frontend\_port, protocol, backend\_port,backend\_pool\_name,loadbalancer\_frontendip\_private\_link\_map\_key] | `map(any)` | n/a | yes |
| <a name="input_loadbalancer_probe"></a> [loadbalancer\_probe](#input\_loadbalancer\_probe) | (Required) Protocols to be used for lb health probes. Format as [protocol, port, request\_path] | `map(any)` | `{}` | no |
| <a name="input_loadbalancer_probe_interval"></a> [loadbalancer\_probe\_interval](#input\_loadbalancer\_probe\_interval) | (Optional) Interval in seconds the load balancer health probe rule does a check | `number` | `5` | no |
| <a name="input_loadbalancer_probe_unhealthy_threshold"></a> [loadbalancer\_probe\_unhealthy\_threshold](#input\_loadbalancer\_probe\_unhealthy\_threshold) | Number of times the load balancer health probe has an unsuccessful attempt before considering the endpoint unhealthy. | `number` | `2` | no |
| <a name="input_loadbalancer_sku"></a> [loadbalancer\_sku](#input\_loadbalancer\_sku) | (Optional) The SKU of the Azure Load Balancer. Accepted values are Basic and Standard. | `string` | `"Standard"` | no |
| <a name="input_loadbalancer_subnet_id"></a> [loadbalancer\_subnet\_id](#input\_loadbalancer\_subnet\_id) | (Optional) LB subnet id to use when in private mode | `string` | `""` | no |
| <a name="input_loadbalancer_type"></a> [loadbalancer\_type](#input\_loadbalancer\_type) | (Optional) Defined if the loadbalancer is private or public | `string` | `"private"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The location/region where the LB will be created. | `string` | n/a | yes |
| <a name="input_pip_allocation_method"></a> [pip\_allocation\_method](#input\_pip\_allocation\_method) | (Optional)  Defines how public IP address is assigned. Options are Static or Dynamic. | `string` | `"Dynamic"` | no |
| <a name="input_pip_sku"></a> [pip\_sku](#input\_pip\_sku) | (Optional) The SKU of Azure public ip. Accepted values are Basic and Standard. | `string` | `"Standard"` | no |
| <a name="input_private_link_endpoint_subnet_id"></a> [private\_link\_endpoint\_subnet\_id](#input\_private\_link\_endpoint\_subnet\_id) | (Required) Subnet id for the Private Endpoint | `any` | n/a | yes |
| <a name="input_private_link_service_subnet_id"></a> [private\_link\_service\_subnet\_id](#input\_private\_link\_service\_subnet\_id) | (Required) Subnet id for the Private Link Service | `any` | n/a | yes |
| <a name="input_remote_port"></a> [remote\_port](#input\_remote\_port) | (Optional) Protocols to be used for remote vm access. [protocol, backend\_port].  Frontend port will be automatically generated starting at 60000 and in the output. | `map(any)` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group for the load balancer. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_lb_backend_address_pool_ids"></a> [azurerm\_lb\_backend\_address\_pool\_ids](#output\_azurerm\_lb\_backend\_address\_pool\_ids) | the id for the azurerm\_lb\_backend\_address\_pool resource |
| <a name="output_azurerm_lb_frontend_ip_configuration"></a> [azurerm\_lb\_frontend\_ip\_configuration](#output\_azurerm\_lb\_frontend\_ip\_configuration) | the frontend\_ip\_configuration for the azurerm\_lb resource |
| <a name="output_azurerm_lb_id"></a> [azurerm\_lb\_id](#output\_azurerm\_lb\_id) | the id for the azurerm\_lb resource |
| <a name="output_azurerm_lb_nat_rule_ids"></a> [azurerm\_lb\_nat\_rule\_ids](#output\_azurerm\_lb\_nat\_rule\_ids) | the ids for the azurerm\_lb\_nat\_rule resources |
| <a name="output_azurerm_loadbalancer_probe_ids"></a> [azurerm\_loadbalancer\_probe\_ids](#output\_azurerm\_loadbalancer\_probe\_ids) | the ids for the azurerm\_loadbalancer\_probe resources |
| <a name="output_azurerm_public_ip_address"></a> [azurerm\_public\_ip\_address](#output\_azurerm\_public\_ip\_address) | the ip address for the azurerm\_lb\_public\_ip resource |
| <a name="output_endpoint_services"></a> [endpoint\_services](#output\_endpoint\_services) | n/a |
| <a name="output_endpoints"></a> [endpoints](#output\_endpoints) | n/a |
| <a name="output_lb_frontend_private_ipaddresses"></a> [lb\_frontend\_private\_ipaddresses](#output\_lb\_frontend\_private\_ipaddresses) | the private frontend ip addresses |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
