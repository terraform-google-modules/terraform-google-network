# Foundation network module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dns\_config | DNS configuration. | <pre>object({<br>    enable_logging               = optional(bool, true)<br>    onprem_forwarding            = optional(bool, false)<br>    enable_inbound_forwarding    = optional(bool, true)<br>    dns_hub_project_id           = optional(string, "")<br>    dns_hub_network_name         = optional(string, "")<br>    domain                       = optional(string, "")<br>    target_name_server_addresses = optional(list(map(any)), [])<br>  })</pre> | `{}` | no |
| enable\_all\_vpc\_internal\_traffic | Enable firewall policy rule to allow internal traffic (ingress and egress). | `bool` | `false` | no |
| firewall\_enable\_logging | Toggle firewall logging for VPC Firewalls. | `bool` | `true` | no |
| mode | Network deployment mode, should be set to `hub` or `spoke` when Hub and Spoke architecture used, keep as `null` otherwise. | `string` | `null` | no |
| nat\_config | Configuration of NAT cloud router. | <pre>object({<br>    enabled = optional(bool, false)<br>    bgp_asn = optional(number, 64512)<br>    regions = optional(list(object({<br>      name          = string<br>      num_addresses = optional(number, 2)<br>    })))<br>  })</pre> | `{}` | no |
| ncc\_hub\_config | Network Connectivity Center configuration. | <pre>object({<br>    create_hub                  = optional(bool, true)<br>    uri                         = optional(string)<br>    name                        = optional(string)<br>    description                 = optional(string)<br>    hub_labels                  = optional(map(string))<br>    spoke_labels                = optional(map(string))<br>    policy_mode                 = optional(string, "PRESET")<br>    preset_topology             = optional(string)<br>    export_psc                  = optional(bool, false)<br>    auto_accept_projects_center = optional(list(string), [])<br>    auto_accept_projects_edge   = optional(list(string), [])<br>    star_group                  = optional(string, "center") // TODO add validation<br>  })</pre> | `{}` | no |
| private\_service\_cidr | CIDR range for private service networking. Used for Cloud SQL and other managed services. | `string` | `null` | no |
| private\_service\_connect\_ip | The subnet internal IP to be used as the private service connect endpoint in the Shared VPC | `string` | n/a | yes |
| project\_id | Project ID for Shared VPC. | `string` | n/a | yes |
| resource\_codes | codes for resources created | <pre>object({<br>    short = optional(string, "p")<br>    long  = optional(string, "production")<br>  })</pre> | n/a | yes |
| secondary\_ranges | Secondary ranges that will be used in some of the subnets | `map(list(object({ range_name = string, ip_cidr_range = string })))` | `{}` | no |
| subnets | The list of subnets being created | <pre>list(object({<br>    subnet_name                      = string<br>    subnet_ip                        = string<br>    subnet_region                    = string<br>    subnet_private_access            = optional(string, "false")<br>    subnet_private_ipv6_access       = optional(string)<br>    subnet_flow_logs                 = optional(string, "false")<br>    subnet_flow_logs_interval        = optional(string, "INTERVAL_5_SEC")<br>    subnet_flow_logs_sampling        = optional(string, "0.5")<br>    subnet_flow_logs_metadata        = optional(string, "INCLUDE_ALL_METADATA")<br>    subnet_flow_logs_filter          = optional(string, "true")<br>    subnet_flow_logs_metadata_fields = optional(list(string), [])<br>    description                      = optional(string)<br>    purpose                          = optional(string)<br>    role                             = optional(string)<br>    stack_type                       = optional(string)<br>    ipv6_access_type                 = optional(string)<br>  }))</pre> | `[]` | no |
| vpc\_name | The name of the network being created. Complete name will be `vpc-{vpc_name}` | `string` | n/a | yes |
| windows\_activation\_enabled | Enable Windows license activation for Windows workloads. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| dns\_policy | The name of the DNS policy being created |
| firewall\_policy | Policy created for firewall policy rules. |
| ncc\_hub\_uri | The NCC Hub ID |
| network\_name | The name of the VPC being created |
| network\_self\_link | The URI of the VPC being created |
| subnets\_ips | The IPs and CIDRs of the subnets being created |
| subnets\_names | The names of the subnets being created |
| subnets\_regions | The region where the subnets will be created |
| subnets\_secondary\_ranges | The secondary ranges associated with these subnets |
| subnets\_self\_links | The self-links of subnets being created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
