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

*   **Shared VPC:** Automatically configures the network as a Shared VPC Host (`shared_vpc_host = "true"`).
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

  # Naming convention codes
  resource_codes = {
    short = "p"
    long  = "production"
  }

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

*   **Terraform:** `>= 0.13`
*   **Provider:** `google` `>= 3.50` (Excluding `6.26.0`, `6.27.0`)
*   **Provider:** `google-beta` `>= 3.50`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dns\_config | DNS configuration. | <pre>object({<br>    enable_logging               = optional(bool, true)<br>    onprem_forwarding            = optional(bool, false)<br>    enable_inbound_forwarding    = optional(bool, true)<br>    dns_hub_project_id           = optional(string, "")<br>    dns_hub_network_name         = optional(string, "")<br>    domain                       = optional(string, "")<br>    type                         = optional(string, "")<br>    target_name_server_addresses = optional(list(map(any)), [])<br>  })</pre> | `{}` | no |
| enable\_all\_vpc\_internal\_traffic | Enable firewall policy rule to allow internal traffic (ingress and egress). | `bool` | `false` | no |
| firewall\_enable\_logging | Toggle firewall logging for VPC Firewalls. | `bool` | `true` | no |
| nat\_config | Configuration of NAT cloud router. | <pre>object({<br>    enabled = optional(bool, false)<br>    bgp_asn = optional(number, 64512)<br>    regions = optional(list(object({<br>      name          = string<br>      num_addresses = optional(number, 2)<br>    })))<br>  })</pre> | `{}` | no |
| ncc\_hub\_config | Network Connectivity Center configuration. | <pre>object({<br>    create_hub                     = optional(bool, true)<br>    uri                            = optional(string)<br>    name                           = optional(string)<br>    description                    = optional(string)<br>    hub_labels                     = optional(map(string))<br>    policy_mode                    = optional(string, "PRESET")<br>    preset_topology                = optional(string, "MESH")<br>    export_psc                     = optional(bool, false)<br>    spoke_labels                   = optional(map(string))<br>    spoke_exclude_export_ranges    = optional(set(string), [])<br>    spoke_include_export_ranges    = optional(set(string), [])<br>    spoke_description              = optional(string)<br>    spoke_group                    = optional(string, "default")<br>    producer_labels                = optional(map(string))<br>    producer_exclude_export_ranges = optional(set(string), [])<br>    producer_include_export_ranges = optional(set(string), [])<br>    producer_description           = optional(string)<br>    auto_accept_projects_center    = optional(list(string), [])<br>    auto_accept_projects_edge      = optional(list(string), [])<br>    auto_accept_projects_default   = optional(list(string), [])<br>  })</pre> | `{}` | no |
| private\_service\_cidr | CIDR range for private service networking. Used for Cloud SQL and other managed services. | `string` | `null` | no |
| private\_service\_connect\_ip | The subnet internal IP to be used as the private service connect endpoint in the Shared VPC | `string` | n/a | yes |
| project\_id | Project ID for Shared VPC. | `string` | n/a | yes |
| resource\_codes | codes for resources created | <pre>object({<br>    short = optional(string, "p")<br>    long  = optional(string, "production")<br>  })</pre> | n/a | yes |
| secondary\_ranges | Secondary ranges that will be used in some of the subnets | `map(list(object({ range_name = string, ip_cidr_range = string })))` | `{}` | no |
| subnets | The list of subnets being created | <pre>list(object({<br>    subnet_name                      = string<br>    subnet_ip                        = string<br>    subnet_region                    = string<br>    subnet_private_access            = optional(string, "false")<br>    subnet_private_ipv6_access       = optional(string)<br>    subnet_flow_logs                 = optional(string, "false")<br>    subnet_flow_logs_interval        = optional(string, "INTERVAL_5_SEC")<br>    subnet_flow_logs_sampling        = optional(string, "0.5")<br>    subnet_flow_logs_metadata        = optional(string, "INCLUDE_ALL_METADATA")<br>    subnet_flow_logs_filter          = optional(string, "true")<br>    subnet_flow_logs_metadata_fields = optional(list(string), [])<br>    description                      = optional(string)<br>    purpose                          = optional(string)<br>    role                             = optional(string)<br>    stack_type                       = optional(string)<br>    ipv6_access_type                 = optional(string)<br>  }))</pre> | `[]` | no |
| vpc\_name | The name of the network being created. Complete name will be `vpc-{vpc_name}` | `string` | n/a | yes |
| windows\_activation\_enabled | Enable Windows license activation for Windows workloads. See https://docs.cloud.google.com/compute/docs/instances/windows/creating-managing-windows-instances . | `bool` | `false` | no |

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
