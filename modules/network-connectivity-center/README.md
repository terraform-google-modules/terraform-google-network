# Terraform Network Connectivity Center Module

This submodule is part of the the `terraform-google-network` module. It creates a Network Connectivity Center Hub and attaches spokes.

## Usage

Basic usage of this submodule is as follows:

```hcl
module "ncc" {
    source  = "terraform-google-modules/network/google//modules/network-connectivity-center"
    version = "~> 15.1"

    project_id   = "<PROJECT ID>"
}
```

An extensive example that also contains the creation and attachment of multiple spokes can be found in [examples/network-connectivity-center](../../examples/network_connectivity_center/)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| export\_psc | Whether Private Service Connect transitivity is enabled for the hub | `bool` | `false` | no |
| hub\_configuration | Configuration for the Network Connectivity Center hub. Set 'create' to true to create a new hub. If 'create' is false, you must provide the 'uri' of an existing hub. | <pre>object({<br>    create       = optional(bool, true)<br>    existing_uri = optional(string)<br>  })</pre> | `{}` | no |
| hybrid\_spokes | VLAN attachments and VPN Tunnels that are associated with the spoke. Type must be one of `interconnect` and `vpn`. | <pre>map(object({<br>    location                   = string<br>    uris                       = set(string)<br>    site_to_site_data_transfer = optional(bool, false)<br>    type                       = string<br>    description                = optional(string)<br>    labels                     = optional(map(string))<br>    include_import_ranges      = optional(list(string), [])<br>    group                      = optional(string)<br>  }))</pre> | `{}` | no |
| ncc\_groups | Groups for Hubs using the star topolgy | <pre>map(object({<br>    name                 = string<br>    labels               = optional(map(string))<br>    description          = optional(string)<br>    auto_accept_projects = optional(list(string), [])<br>  }))</pre> | `{}` | no |
| ncc\_hub\_description | The description of the NCC Hub | `string` | `null` | no |
| ncc\_hub\_labels | These labels will be added the NCC hub | `map(string)` | `{}` | no |
| ncc\_hub\_name | The Name of the NCC Hub | `string` | n/a | yes |
| ncc\_hub\_policy\_mode | The policy mode of the hub. Type must be one of `PRESET` or `CUSTOM`. | `string` | `"PRESET"` | no |
| ncc\_hub\_preset\_topology | The topology implemented in the hub. Type must be one of `STAR`, `MESH` or `HYBRID_INSPECTION`. | `string` | `null` | no |
| project\_id | Project ID of the project that holds the network. | `string` | n/a | yes |
| router\_appliance\_spokes | Router appliance instances that are associated with the spoke. | <pre>map(object({<br>    instances = set(object({<br>      virtual_machine = string<br>      ip_address      = string<br>    }))<br>    location                   = string<br>    site_to_site_data_transfer = optional(bool, false)<br>    description                = optional(string)<br>    labels                     = optional(map(string))<br>    include_import_ranges      = optional(list(string), [])<br>    group                      = optional(string)<br>  }))</pre> | `{}` | no |
| spoke\_labels | These labels will be added to all NCC spokes | `map(string)` | `{}` | no |
| vpc\_spokes | VPC network that is associated with the spoke. link\_producer\_vpc\_network: Producer VPC network that is peered with vpc network | <pre>map(object({<br>    uri                   = string<br>    exclude_export_ranges = optional(set(string), [])<br>    include_export_ranges = optional(set(string), [])<br>    description           = optional(string)<br>    labels                = optional(map(string))<br>    group                 = optional(string)<br><br>    link_producer_vpc_network = optional(object({<br>      network_name          = string<br>      peering               = string<br>      include_export_ranges = optional(list(string))<br>      exclude_export_ranges = optional(list(string))<br>      description           = optional(string)<br>      labels                = optional(map(string))<br>      group                 = optional(string)<br>    }))<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| groups | All group objects |
| hybrid\_spokes | All hybrid spoke objects |
| ncc\_hub | The NCC Hub object |
| ncc\_hub\_id | The NCC Hub ID |
| producer\_vpc\_network\_spoke | All producer network vpc spoke objects |
| router\_appliance\_spokes | All router appliance spoke objects |
| spokes | All spoke objects prefixed with the type of spoke (vpc, hybrid, appliance) |
| vpc\_spokes | All vpc spoke objects |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
