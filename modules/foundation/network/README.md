# Google Cloud Shared VPC Foundation Module

This Terraform module deploys a **Shared VPC Host** network on Google Cloud Platform. It serves as a foundational networking component, integrating with **Network Connectivity Center (NCC)** for Mesh or Star topologies, **Global Network Firewall Policies**, and DNS configurations.

## Prerequisites

### 1. Required APIs

The project where this module is deployed must have the following APIs enabled:

*   `compute.googleapis.com` (Compute Engine)
*   `dns.googleapis.com` (Cloud DNS)
*   `servicenetworking.googleapis.com` (Service Networking / PSA)
*   `networkconnectivity.googleapis.com` (Network Connectivity Center)

### 2. IAM Roles

The Service Account running Terraform requires the following roles at the **Project** level:

*   **Compute Network Admin** (`roles/compute.networkAdmin`): For VPC, Subnets, Routes.
*   **Compute Security Admin** (`roles/compute.securityAdmin`): **Required** for Global Network Firewall Policies.
*   **DNS Administrator** (`roles/dns.admin`): For DNS Policies and Zones.
*   **Network Connectivity Center Admin** (`roles/networkconnectivity.hubAdmin`): For Hub/Spoke management.
*   **Project IAM Admin** (Conditional): If auto-accepting projects into NCC groups.


## Features

*   **Shared VPC:** Can configure the network as a Shared VPC Host (`shared_vpc_host = "true"`).
*   **Network Connectivity Center (NCC):**
    *   Supports **Mesh** (full-mesh connectivity) or **Star** (Hub & Spoke) topologies.
    *   Granular control over spoke export filters and producer route propagation.
*   **Advanced DNS:**
    *   **Spoke Logic:** Automatically creates DNS Peering to a central DNS Hub.
    *   **Hub/Standalone Logic:** Creates DNS Forwarding zones to on-premise target name servers.
    *   Default DNS Policy with logging enabled.
*   **Security:**
    *   **Global Network Firewall Policies:** Uses Next-Gen Firewall policies (hierarchical-style) instead of legacy VPC rules.
    *   **Default Deny:** Priority 65530 rule denies all egress traffic.
    *   **Google APIs:** Priority 1000 rule allows TCP 443 to Restricted Google APIs Virtual IP (VIP).
*   **Connectivity:**
    *   **Cloud NAT:** Optional regional Cloud Router and NAT configuration.
    *   **Private Service Connect (PSC):** Configures endpoints for internal Google API access.
    *   **Private Services Access (PSA):** Configures VPC Peering for Google Managed Services (SQL, Redis, etc.).

## Usage

```hcl
module "shared_vpc_foundation" {
  source  = "terraform-google-modules/network/google//modules/foundation/network"
  version = "~> 13.0"

  project_id = "my-project-id"
  vpc_name   = "core-net" # Final VPC Name: vpc-p-core-net

  # Naming convention code
  resource_code = "p"

  # Subnet Configuration
  subnets = [
    {
      subnet_name           = "sb-prod-us-central1"
      subnet_ip             = "10.0.0.0/24"
      subnet_region         = "us-central1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
      description           = "Production workload subnet"
    }
  ]

  # DNS Configuration (Example: Spoke peering to a DNS Hub)
  dns_config = {
    onprem_forwarding    = true
    type                 = "spoke" # Triggers DNS Peering
    dns_hub_project_id   = "my-hub-project"
    dns_hub_network_name = "vpc-dns-hub"
    domain               = "example.com."
  }

  # Network Connectivity Center (Mesh Topology Example)
  ncc_hub_config = {
    create_hub      = true
    name            = "global-mesh-hub"
    description     = "Global VPC Mesh"
    preset_topology = "MESH"
    hub_labels      = { env = "prod" }

    # Spoke Configuration
    spoke_group                  = "default" # Use "default" for MESH, "center"/"edge" for STAR
    spoke_description            = "Core Network Spoke"
    auto_accept_projects_default = ["my-project-id"]
  }

  # Private Service Connect IP (Must be a valid internal IP)
  private_service_connect_ip = "10.1.0.5"

  # Private Service Access (e.g., for Cloud SQL)
  private_service_cidr       = "10.2.0.0/16"
}
```

## Architecture Details

### DNS Architecture
The module dynamically creates DNS resources based on `var.dns_config`:

| Configuration | Resulting Resource | Note |
|---------------|--------------------|------|
| `type = "spoke"` | **DNS Peering Zone** | Peers `domain` to `dns_hub_network_name`. |
| `type != "spoke"` | **DNS Forwarding Zone** | Forwards `domain` to `target_name_server_addresses`. |

### Firewall Strategy
This module creates a **Network Firewall Policy** attached to the VPC. It does **not** create standard VPC firewall rules.
1.  **Priority 65530 (Egress):** Deny all traffic (Logging enabled).
2.  **Priority 1000 (Egress):** Allow TCP 443 to Restricted Google APIs VIP.
3.  **Optional:** Allow full internal VPC traffic (Ingress/Egress) if `enable_all_vpc_internal_traffic` is true.

### Network Connectivity Center (NCC)
*   **Mesh:** Use `preset_topology = "MESH"` and `spoke_group = "default"`. All attached VPCs can talk to each other.
*   **Star:** Use `preset_topology = "STAR"` and `spoke_group = "center"` (Hub) or `"edge"` (Spoke).
*   **Route Export:** You can filter which subnets are advertised to the Hub using `spoke_exclude_export_ranges`.

## Requirements

*   **Terraform:** `>= 1.3`
*   **Provider:** `google` `>= 7.8`
*   **Provider:** `google-beta` `>= 7.8`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bgp\_always\_compare\_med | If set to true, the Cloud Router will use MED values from the peer even if the AS paths differ. Default is false. | `bool` | `false` | no |
| bgp\_best\_path\_selection\_mode | Specifies the BGP best path selection mode. Valid values are `STANDARD` or `LEGACY`. Default is `LEGACY`. | `string` | `"LEGACY"` | no |
| bgp\_inter\_region\_cost | Specifies the BGP inter-region cost mode. Valid values are `DEFAULT` or `ADD_COST_TO_MED`. | `string` | `null` | no |
| description | An optional description of this network. The resource must be recreated to modify this field. | `string` | `""` | no |
| dns\_config | Configuration block for Cloud DNS policies, peering, and forwarding rules.<br>General Attributes:<br>- enable\_logging: (bool) Toggles DNS query logging on the default DNS policy (default: true).<br>- onprem\_forwarding: (bool) Master toggle to enable resolving on-premise DNS. If true, it provisions either a Peering Zone or Forwarding Zone based on the 'type' attribute.<br>- enable\_inbound\_forwarding: (bool) Enables inbound DNS queries from on-prem to this VPC. Only active if 'onprem\_forwarding' is true (default: true).<br>- type: (string) Defines the architectural role. If set to "spoke", the module creates a DNS Peering Zone. If not "spoke", it creates a DNS Forwarding Zone.<br>- domain: (string) The DNS suffix/domain for the peering or forwarding zone. Required if 'onprem\_forwarding' is true.<br>Spoke Attributes (Required if onprem\_forwarding = true AND type = "spoke"):<br>- dns\_hub\_project\_id: (string) The project ID hosting the Hub VPC to peer DNS queries to.<br>- dns\_hub\_network\_name: (string) The Hub VPC network name to target for DNS peering.<br>Hub/Forwarder Attributes (Required if onprem\_forwarding = true AND type != "spoke"):<br>- target\_name\_server\_addresses: (list of maps) The on-premises or remote name servers to forward DNS queries to. | <pre>object({<br>    enable_logging               = optional(bool, true)<br>    type                         = optional(string, "")<br>    onprem_forwarding            = optional(bool, false)<br>    enable_inbound_forwarding    = optional(bool, true)<br>    dns_hub_project_id           = optional(string, "")<br>    dns_hub_network_name         = optional(string, "")<br>    domain                       = optional(string, "")<br>    target_name_server_addresses = optional(list(map(any)), [])<br>  })</pre> | `{}` | no |
| enable\_all\_vpc\_internal\_traffic | Enable firewall policy rule to allow internal traffic (ingress and egress). | `bool` | `false` | no |
| enable\_gcr\_dns | Enable DNS zone creation for legacy gcr.io. Set to false for GDC/TPC environments where Container Registry is not available. | `bool` | `true` | no |
| enable\_ipv6\_ula | Enabled IPv6 ULA, this is a permanent change and cannot be undone! (default 'false') | `bool` | `false` | no |
| firewall\_enable\_logging | Toggle firewall logging for VPC Firewalls. | `bool` | `true` | no |
| internal\_ipv6\_range | When enabling IPv6 ULA, optionally, specify a /48 from fd20::/20 (default null) | `string` | `null` | no |
| mtu | The network MTU (If set to 0, meaning MTU is unset - defaults to '1460'). Recommended values: 1460 (default for historic reasons), 1500 (Internet default), or 8896 (for Jumbo packets). Allowed are all values in the range 1300 to 8896, inclusively. | `number` | `0` | no |
| nat\_config | Configuration for Cloud NAT and underlying Cloud Routers.<br>Attributes:<br>- enabled: Set to true to create NAT resources. If false, no routers or NAT IPs are provisioned (default: false).<br>- egress\_tags: Network tags used for routing internet egress traffic (default: ["egress-internet"]).<br>- bgp\_asn: The BGP Autonomous System Number assigned to the Cloud Router (default: 64512).<br>- regions: Defines which regions get a NAT router.<br>  - name: The GCP region name (e.g., "us-central1") where the router and NAT will be deployed.<br>  - num\_addresses: The number of static external IP addresses to manually allocate and assign to the NAT gateway in this region (default: 2). | <pre>object({<br>    enabled     = optional(bool, false)<br>    egress_tags = optional(list(string), ["egress-internet"])<br>    bgp_asn     = optional(number, 64512)<br>    regions = optional(list(object({<br>      name          = string<br>      num_addresses = optional(number, 2)<br>    })))<br>  })</pre> | `{}` | no |
| ncc\_hub\_config | Configuration block for Google Cloud Network Connectivity Center (NCC) Hub and Spokes.<br>Hub Creation & Identity:<br>- create\_hub: (bool) Toggles whether to create a new NCC Hub (true) or use an existing one (false).<br>- uri: (string) The URI of an existing Hub. [Required if create\_hub is FALSE]<br>- name: (string) Name of the new NCC Hub. [Required if create\_hub is TRUE]<br>- description: (string) Description for the new NCC Hub. [Required if create\_hub is TRUE]<br>- hub\_labels: (map) Labels to apply to the new Hub. [Required if create\_hub is TRUE]<br>Topology & Routing:<br>- preset\_topology: (string) Network topology for the hub, either "MESH" or "STAR". [Required if create\_hub is TRUE]<br>- policy\_mode: (string) Route policy mode (default: "PRESET").<br>- export\_psc: (bool) Allows exporting Private Service Connect routes across the hub (default: false).<br>VPC Spoke Configuration (Attaches the module's main network):<br>- spoke\_group: (string) The NCC group the spoke belongs to (default: "default").<br>- spoke\_name: (string) Name for the main VPC spoke.<br>- spoke\_description: (string) Description for the main VPC spoke.<br>- spoke\_labels: (map) Labels for the main VPC spoke.<br>- spoke\_exclude\_export\_ranges: (set of strings) IP ranges to exclude from route export.<br>- spoke\_include\_export\_ranges: (set of strings) IP ranges to explicitly include in route export.<br>Producer Network Configuration (Active only if 'var.private\_service\_cidr' is defined):<br>- producer\_description: (string) Description for the linked Private Service Connect (producer) spoke.<br>- producer\_labels: (map) Labels for the producer spoke.<br>- producer\_exclude\_export\_ranges: (set of strings) IP ranges to exclude for the producer network.<br>- producer\_include\_export\_ranges: (set of strings) IP ranges to include for the producer network.<br>Auto-Accept Policies (Configures project auto-acceptance based on topology):<br>- auto\_accept\_projects\_default: (list of strings) Projects allowed in the "default" group (Used when topology is MESH).<br>- auto\_accept\_projects\_center: (list of strings) Projects allowed in the "center" group (Used when topology is STAR).<br>- auto\_accept\_projects\_edge: (list of strings) Projects allowed in the "edge" group (Used when topology is STAR). | <pre>object({<br>    create_hub                     = optional(bool, true)<br>    uri                            = optional(string)<br>    name                           = optional(string)<br>    description                    = optional(string)<br>    hub_labels                     = optional(map(string))<br>    policy_mode                    = optional(string, "PRESET")<br>    preset_topology                = optional(string, "MESH")<br>    export_psc                     = optional(bool, false)<br>    spoke_labels                   = optional(map(string))<br>    spoke_exclude_export_ranges    = optional(set(string), [])<br>    spoke_include_export_ranges    = optional(set(string), [])<br>    spoke_name                     = optional(string, "vpc-spoke")<br>    spoke_description              = optional(string)<br>    spoke_group                    = optional(string, "default")<br>    producer_labels                = optional(map(string))<br>    producer_exclude_export_ranges = optional(set(string), [])<br>    producer_include_export_ranges = optional(set(string), [])<br>    producer_description           = optional(string)<br>    auto_accept_projects_center    = optional(list(string), [])<br>    auto_accept_projects_edge      = optional(list(string), [])<br>    auto_accept_projects_default   = optional(list(string), [])<br>  })</pre> | n/a | yes |
| network\_firewall\_policy\_enforcement\_order | Set the order that Firewall Rules and Firewall Policies are evaluated. Valid values are `BEFORE_CLASSIC_FIREWALL` and `AFTER_CLASSIC_FIREWALL`. (default null or equivalent to `AFTER_CLASSIC_FIREWALL`) | `string` | `null` | no |
| network\_profile | "A full or partial URL of the network profile to apply to this network.<br>This field can be set only at resource creation time. For example, the<br>following are valid URLs:<br>  * https://www.googleapis.com/compute/beta/projects/{projectId}/global/networkProfiles/{network_profile_name}<br>  * projects/{projectId}/global/networkProfiles/{network\_profile\_name} | `string` | `null` | no |
| pkg\_dev\_domain | Domain for Artifact Registry. Change if using a custom universe\_domain. | `string` | `"pkg.dev"` | no |
| private\_service\_cidr | CIDR range for private service networking. Used for Cloud SQL and other managed services. | `string` | `null` | no |
| private\_service\_connect\_ip | The subnet internal IP to be used as the private service connect endpoint in the Shared VPC | `string` | n/a | yes |
| project\_id | Project ID for VPC. | `string` | n/a | yes |
| resource\_code | Standardized grouping code used to categorize resources by their environment (e.g., 'p' for production) or their architectural/topology role (e.g., 'h' for hub, 's' for spoke). Used as an infix in resource names (e.g., dp-p-svpc-default-policy) | `string` | n/a | yes |
| routing\_mode | The network routing mode (default 'GLOBAL') | `string` | `"GLOBAL"` | no |
| secondary\_ranges | Secondary ranges that will be used in some of the subnets | `map(list(object({ range_name = string, ip_cidr_range = string })))` | `{}` | no |
| shared\_vpc\_host | Makes this project a Shared VPC host if 'true' (default 'false') | `bool` | `false` | no |
| subnets | The list of subnets being created. See https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork | <pre>list(object({<br>    subnet_name                      = string<br>    subnet_ip                        = string<br>    subnet_region                    = string<br>    subnet_private_access            = optional(string, "true")<br>    subnet_private_ipv6_access       = optional(string)<br>    subnet_flow_logs                 = optional(string, "true")<br>    subnet_flow_logs_interval        = optional(string, "INTERVAL_5_SEC")<br>    subnet_flow_logs_sampling        = optional(string, "0.5")<br>    subnet_flow_logs_metadata        = optional(string, "INCLUDE_ALL_METADATA")<br>    subnet_flow_logs_metadata_fields = optional(list(string), [])<br>    subnet_flow_logs_filter          = optional(string, "true")<br>    description                      = optional(string)<br>    purpose                          = optional(string)<br>    role                             = optional(string)<br>    stack_type                       = optional(string)<br>    ipv6_access_type                 = optional(string)<br>  }))</pre> | `[]` | no |
| universe\_domain | The universe domain to use for Google Cloud APIs. This defines the API endpoint boundary for your deployment. The default is 'googleapis.com' for the standard public Google Cloud. Modify this value if you are deploying to isolated environments like Google Distributed Cloud (GDC), Trusted Partner Cloud (TPC), or other sovereign cloud environments. | `string` | `"googleapis.com"` | no |
| vpc\_name | The name of the network being created. Complete name will be `vpc-{vpc_name}` | `string` | n/a | yes |
| windows\_activation\_enabled | Enable Windows license activation for Windows workloads. See https://docs.cloud.google.com/compute/docs/instances/windows/creating-managing-windows-instances . | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| dns\_policy | The name of the DNS policy being created |
| firewall\_policy | Policy created for firewall policy rules. |
| ncc\_hub\_uri | The NCC Hub ID |
| network | The created network |
| network\_name | The name of the VPC being created |
| network\_self\_link | The URI of the VPC being created |
| project\_id | VPC project id |
| route\_names | The route names associated with this VPC |
| subnets | A map with keys of form subnet\_region/subnet\_name and values being the outputs of the google\_compute\_subnetwork resources used to create corresponding subnets. |
| subnets\_flow\_logs | Whether the subnets will have VPC flow logs enabled |
| subnets\_ips | The IPs and CIDRs of the subnets being created |
| subnets\_names | The names of the subnets being created |
| subnets\_private\_access | Whether the subnets will have access to Google API's without a public IP |
| subnets\_regions | The region where the subnets will be created |
| subnets\_secondary\_ranges | The secondary ranges associated with these subnets |
| subnets\_self\_links | The self-links of subnets being created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
