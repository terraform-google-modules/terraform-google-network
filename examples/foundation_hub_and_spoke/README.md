# Terraform Google Cloud Hub-and-Spoke Network Example

This example demonstrates how to implement a Hub-and-Spoke network topology on Google Cloud Platform (GCP) using the `foundation/network` module.
It provisions two separate VPC networks: a "Hub" network and a "Spoke" network, and configures them to work together through Network Connectivity Center (NCC) and shared DNS.

## Architecture Overview

The example sets up:

*   **Hub Network:**
    *   A dedicated VPC network (`var.network_name_hub`) in `var.project_id_hub`.
    *   Primary and proxy-only subnets in `us-central1` and `us-west1`.
    *   Configures Private Service Connect (PSC).
    *   Sets up an NCC Hub that automatically accepts connections from the Hub and Spoke projects.
    *   Configures a Cloud DNS forwarding policy to an on-premises DNS server.
    *   Enables Cloud NAT with two IP addresses per region.
    *   Disables all VPC internal traffic by default for stricter security.

*   **Spoke Network:**
    *   A dedicated VPC network (`var.network_name_spoke`) in `var.project_id_spoke`.
    *   Primary and proxy-only subnets in `us-central1` and `us-west1`.
    *   Configures Private Service Connect (PSC).
    *   Connects to the NCC Hub created by the `hub` module as a Spoke.
    *   Configures Cloud DNS to use the Hub network's DNS policy.
    *   Includes secondary IP ranges for GKE pods and services in `us-central1`.
    *   Disables all VPC internal traffic by default.

This setup provides centralized network services and control in the Hub, while allowing application-specific deployments in the Spoke network(s).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| network\_name\_hub | The name of the hub VPC network being created | `any` | n/a | yes |
| network\_name\_spoke | The name of the spoke VPC network being created | `any` | n/a | yes |
| project\_id\_hub | The project ID to host the hub network in | `any` | n/a | yes |
| project\_id\_spoke | The project ID to host the spoke network in | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| hub\_dns\_policy | The name of the DNS policy being created |
| hub\_firewall\_policy | Policy created for firewall policy rules. |
| hub\_network | The created network |
| hub\_network\_name | The name of the VPC being created |
| hub\_network\_self\_link | The URI of the VPC being created |
| hub\_route\_names | The route names associated with this VPC |
| hub\_subnets | A map with keys of form subnet\_region/subnet\_name and values being the outputs of the google\_compute\_subnetwork resources used to create corresponding subnets. |
| hub\_subnets\_flow\_logs | Whether the subnets will have VPC flow logs enabled |
| hub\_subnets\_ips | The IPs and CIDRs of the subnets being created |
| hub\_subnets\_names | The names of the subnets being created |
| hub\_subnets\_private\_access | Whether the subnets will have access to Google API's without a public IP |
| hub\_subnets\_regions | The region where the subnets will be created |
| hub\_subnets\_secondary\_ranges | The secondary ranges associated with these subnets |
| hub\_subnets\_self\_links | The self-links of subnets being created |
| ncc\_hub\_uri | The NCC Hub ID |
| project\_id\_hub | VPC project id |
| project\_id\_spoke | VPC project id |
| spoke\_dns\_policy | The name of the DNS policy being created |
| spoke\_firewall\_policy | Policy created for firewall policy rules. |
| spoke\_network | The created network |
| spoke\_network\_name | The name of the VPC being created |
| spoke\_network\_self\_link | The URI of the VPC being created |
| spoke\_route\_names | The route names associated with this VPC |
| spoke\_subnets | A map with keys of form subnet\_region/subnet\_name and values being the outputs of the google\_compute\_subnetwork resources used to create corresponding subnets. |
| spoke\_subnets\_flow\_logs | Whether the subnets will have VPC flow logs enabled |
| spoke\_subnets\_ips | The IPs and CIDRs of the subnets being created |
| spoke\_subnets\_names | The names of the subnets being created |
| spoke\_subnets\_private\_access | Whether the subnets will have access to Google API's without a public IP |
| spoke\_subnets\_regions | The region where the subnets will be created |
| spoke\_subnets\_secondary\_ranges | The secondary ranges associated with these subnets |
| spoke\_subnets\_self\_links | The self-links of subnets being created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
