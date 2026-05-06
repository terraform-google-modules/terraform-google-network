# Terraform Google Network Foundation Module basic example

This Terraform example sets up a foundational Google Cloud Platform (GCP) Virtual Private Cloud (VPC) network.

It uses the `foundation/network` module to create a VPC, define several subnets (including proxy-only subnets for specific regions), configure Private Service Connect (PSC), and establish a Network Connectivity Center (NCC) Hub with automatic project acceptance.

## Features

*   **VPC Network Creation:** Provisions a new VPC network.
*   **Regional Subnets:** Defines primary and proxy-only subnets across `us-central1` and `us-west1` regions with pre-defined CIDR ranges.
*   **Private Service Connect (PSC):** Configures a dedicated IP for Private Service Connect.
*   **Network Connectivity Center (NCC) Hub:** Creates an NCC Hub with automatic acceptance for the specified project, enabling future network connectivity solutions.
*   **Traffic Control:** Disables all VPC internal traffic by default for stricter security.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| network\_name | The name of the VPC network being created | `any` | n/a | yes |
| project\_id | The project ID to host the network in | `any` | n/a | yes |

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
