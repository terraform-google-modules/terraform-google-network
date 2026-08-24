/**
 * Copyright 2026 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "project_id" {
  description = "Project ID for VPC."
  type        = string
}

variable "resource_code" {
  type        = string
  description = "Standardized grouping code used to categorize resources by their environment (e.g., 'p' for production) or their architectural/topology role (e.g., 'h' for hub, 's' for spoke). Used as an infix in resource names (e.g., dp-p-svpc-default-policy)"
}

variable "vpc_name" {
  description = "The name of the network being created. Complete name will be `vpc-{vpc_name}`"
  type        = string
}

variable "description" {
  type        = string
  description = "An optional description of this network. The resource must be recreated to modify this field."
  default     = ""
}

variable "shared_vpc_host" {
  description = "Makes this project a Shared VPC host if 'true' (default 'false')"
  type        = bool
  default     = false
}

variable "routing_mode" {
  type        = string
  description = "The network routing mode (default 'GLOBAL')"
  default     = "GLOBAL"
}

variable "subnets" {
  description = "The list of subnets being created. See https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork"
  type = list(object({
    subnet_name                      = string
    subnet_ip                        = string
    subnet_region                    = string
    subnet_private_access            = optional(string, "true")
    subnet_private_ipv6_access       = optional(string)
    subnet_flow_logs                 = optional(string, "true")
    subnet_flow_logs_interval        = optional(string, "INTERVAL_5_SEC")
    subnet_flow_logs_sampling        = optional(string, "0.5")
    subnet_flow_logs_metadata        = optional(string, "INCLUDE_ALL_METADATA")
    subnet_flow_logs_metadata_fields = optional(list(string), [])
    subnet_flow_logs_filter          = optional(string, "true")
    description                      = optional(string)
    purpose                          = optional(string)
    role                             = optional(string)
    stack_type                       = optional(string)
    ipv6_access_type                 = optional(string)
  }))
  default = []
}

variable "secondary_ranges" {
  description = "Secondary ranges that will be used in some of the subnets"
  type        = map(list(object({ range_name = string, ip_cidr_range = string })))
  default     = {}
}

variable "nat_config" {
  description = <<-EOT
    Configuration for Cloud NAT and underlying Cloud Routers.
    Attributes:
    - enabled: Set to true to create NAT resources. If false, no routers or NAT IPs are provisioned (default: false).
    - egress_tags: Network tags used for routing internet egress traffic (default: ["egress-internet"]).
    - bgp_asn: The BGP Autonomous System Number assigned to the Cloud Router (default: 64512).
    - regions: Defines which regions get a NAT router.
      - name: The GCP region name (e.g., "us-central1") where the router and NAT will be deployed.
      - num_addresses: The number of static external IP addresses to manually allocate and assign to the NAT gateway in this region (default: 2).
  EOT
  type = object({
    enabled     = optional(bool, false)
    egress_tags = optional(list(string), ["egress-internet"])
    bgp_asn     = optional(number, 64512)
    regions = optional(list(object({
      name          = string
      num_addresses = optional(number, 2)
    })))
  })
  default = {}
}

variable "windows_activation_enabled" {
  description = "Enable Windows license activation for Windows workloads. See https://docs.cloud.google.com/compute/docs/instances/windows/creating-managing-windows-instances ."
  type        = bool
  default     = false
}

variable "private_service_cidr" {
  description = "CIDR range for private service networking. Used for Cloud SQL and other managed services."
  type        = string
  default     = null
}

variable "private_service_connect_ip" {
  description = "The subnet internal IP to be used as the private service connect endpoint in the Shared VPC"
  type        = string
}

variable "firewall_enable_logging" {
  description = "Toggle firewall logging for VPC Firewalls."
  type        = bool
  default     = true
}

variable "enable_all_vpc_internal_traffic" {
  description = "Enable firewall policy rule to allow internal traffic (ingress and egress)."
  type        = bool
  default     = false
}

variable "dns_config" {
  description = <<-EOT
    Configuration block for Cloud DNS policies, peering, and forwarding rules.
    General Attributes:
    - enable_logging: (bool) Toggles DNS query logging on the default DNS policy (default: true).
    - onprem_forwarding: (bool) Master toggle to enable resolving on-premise DNS. If true, it provisions either a Peering Zone or Forwarding Zone based on the 'type' attribute.
    - enable_inbound_forwarding: (bool) Enables inbound DNS queries from on-prem to this VPC. Only active if 'onprem_forwarding' is true (default: true).
    - type: (string) Defines the architectural role. If set to "spoke", the module creates a DNS Peering Zone. If not "spoke", it creates a DNS Forwarding Zone.
    - domain: (string) The DNS suffix/domain for the peering or forwarding zone. Required if 'onprem_forwarding' is true.
    Spoke Attributes (Required if onprem_forwarding = true AND type = "spoke"):
    - dns_hub_project_id: (string) The project ID hosting the Hub VPC to peer DNS queries to.
    - dns_hub_network_name: (string) The Hub VPC network name to target for DNS peering.
    Hub/Forwarder Attributes (Required if onprem_forwarding = true AND type != "spoke"):
    - target_name_server_addresses: (list of maps) The on-premises or remote name servers to forward DNS queries to.
  EOT
  type = object({
    enable_logging               = optional(bool, true)
    type                         = optional(string, "")
    onprem_forwarding            = optional(bool, false)
    enable_inbound_forwarding    = optional(bool, true)
    dns_hub_project_id           = optional(string, "")
    dns_hub_network_name         = optional(string, "")
    domain                       = optional(string, "")
    target_name_server_addresses = optional(list(map(any)), [])
  })
  default = {}

  validation {
    condition = var.dns_config.onprem_forwarding == false || (
      var.dns_config.type == "spoke" ? (
        var.dns_config.domain != "" &&
        var.dns_config.dns_hub_project_id != "" &&
        var.dns_config.dns_hub_network_name != ""
        ) : (
        var.dns_config.domain != "" &&
        length(var.dns_config.target_name_server_addresses) > 0
      )
    )
    error_message = "When 'onprem_forwarding' is true: If type is 'spoke', 'dns_hub_project_id' and 'dns_hub_network_name' are required. If type is not spoke, 'domain' and 'target_name_server_addresses' are required."
  }
}

variable "ncc_hub_config" {
  description = <<-EOT
    Configuration block for Google Cloud Network Connectivity Center (NCC) Hub and Spokes.
    Hub Creation & Identity:
    - create_hub: (bool) Toggles whether to create a new NCC Hub (true) or use an existing one (false).
    - uri: (string) The URI of an existing Hub. [Required if create_hub is FALSE]
    - name: (string) Name of the new NCC Hub. [Required if create_hub is TRUE]
    - description: (string) Description for the new NCC Hub. [Required if create_hub is TRUE]
    - hub_labels: (map) Labels to apply to the new Hub. [Required if create_hub is TRUE]
    Topology & Routing:
    - preset_topology: (string) Network topology for the hub, either "MESH" or "STAR". [Required if create_hub is TRUE]
    - policy_mode: (string) Route policy mode (default: "PRESET").
    - export_psc: (bool) Allows exporting Private Service Connect routes across the hub (default: false).
    VPC Spoke Configuration (Attaches the module's main network):
    - spoke_group: (string) The NCC group the spoke belongs to (default: "default").
    - spoke_name: (string) Name for the main VPC spoke.
    - spoke_description: (string) Description for the main VPC spoke.
    - spoke_labels: (map) Labels for the main VPC spoke.
    - spoke_exclude_export_ranges: (set of strings) IP ranges to exclude from route export.
    - spoke_include_export_ranges: (set of strings) IP ranges to explicitly include in route export.
    Producer Network Configuration (Active only if 'var.private_service_cidr' is defined):
    - producer_description: (string) Description for the linked Private Service Connect (producer) spoke.
    - producer_labels: (map) Labels for the producer spoke.
    - producer_exclude_export_ranges: (set of strings) IP ranges to exclude for the producer network.
    - producer_include_export_ranges: (set of strings) IP ranges to include for the producer network.
    Auto-Accept Policies (Configures project auto-acceptance based on topology):
    - auto_accept_projects_default: (list of strings) Projects allowed in the "default" group (Used when topology is MESH).
    - auto_accept_projects_center: (list of strings) Projects allowed in the "center" group (Used when topology is STAR).
    - auto_accept_projects_edge: (list of strings) Projects allowed in the "edge" group (Used when topology is STAR).
  EOT
  type = object({
    create_hub                     = optional(bool, true)
    uri                            = optional(string)
    name                           = optional(string)
    description                    = optional(string)
    hub_labels                     = optional(map(string))
    policy_mode                    = optional(string, "PRESET")
    preset_topology                = optional(string, "MESH")
    export_psc                     = optional(bool, false)
    spoke_labels                   = optional(map(string))
    spoke_exclude_export_ranges    = optional(set(string), [])
    spoke_include_export_ranges    = optional(set(string), [])
    spoke_name                     = optional(string, "vpc-spoke")
    spoke_description              = optional(string)
    spoke_group                    = optional(string, "default")
    producer_labels                = optional(map(string))
    producer_exclude_export_ranges = optional(set(string), [])
    producer_include_export_ranges = optional(set(string), [])
    producer_description           = optional(string)
    auto_accept_projects_center    = optional(list(string), [])
    auto_accept_projects_edge      = optional(list(string), [])
    auto_accept_projects_default   = optional(list(string), [])
  })

  default = {}

  validation {
    condition = (
      (
        var.ncc_hub_config.create_hub == true &&
        var.ncc_hub_config.name != null &&
        var.ncc_hub_config.description != null &&
        var.ncc_hub_config.hub_labels != null &&
        var.ncc_hub_config.preset_topology != null
      )
      ||
      (
        var.ncc_hub_config.create_hub == false &&
        var.ncc_hub_config.uri != null
      )
    )
    error_message = "Invalid NCC Hub configuration. If create_hub is TRUE: name, description, labels, and preset_topology are required. If create_hub is FALSE: uri is required."
  }
}

variable "mtu" {
  type        = number
  description = "The network MTU (If set to 0, meaning MTU is unset - defaults to '1460'). Recommended values: 1460 (default for historic reasons), 1500 (Internet default), or 8896 (for Jumbo packets). Allowed are all values in the range 1300 to 8896, inclusively."
  default     = 0
}

variable "enable_ipv6_ula" {
  type        = bool
  description = "Enabled IPv6 ULA, this is a permanent change and cannot be undone! (default 'false')"
  default     = false
}

variable "internal_ipv6_range" {
  type        = string
  description = "When enabling IPv6 ULA, optionally, specify a /48 from fd20::/20 (default null)"
  default     = null
}

variable "network_firewall_policy_enforcement_order" {
  type        = string
  description = "Set the order that Firewall Rules and Firewall Policies are evaluated. Valid values are `BEFORE_CLASSIC_FIREWALL` and `AFTER_CLASSIC_FIREWALL`. (default null or equivalent to `AFTER_CLASSIC_FIREWALL`)"
  default     = null
}

variable "network_profile" {
  type        = string
  description = <<-EOT
    "A full or partial URL of the network profile to apply to this network.
    This field can be set only at resource creation time. For example, the
    following are valid URLs:
      * https://www.googleapis.com/compute/beta/projects/{projectId}/global/networkProfiles/{network_profile_name}
      * projects/{projectId}/global/networkProfiles/{network_profile_name}
    EOT
  default     = null
}

variable "bgp_always_compare_med" {
  type        = bool
  description = "If set to true, the Cloud Router will use MED values from the peer even if the AS paths differ. Default is false."
  default     = false
}

variable "bgp_best_path_selection_mode" {
  type        = string
  description = "Specifies the BGP best path selection mode. Valid values are `STANDARD` or `LEGACY`. Default is `LEGACY`."
  default     = "LEGACY"
}

variable "bgp_inter_region_cost" {
  type        = string
  description = "Specifies the BGP inter-region cost mode. Valid values are `DEFAULT` or `ADD_COST_TO_MED`."
  default     = null
}
