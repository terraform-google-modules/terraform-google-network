# Multiple Networks

This example configures a host network project with two separate networks.

[^]: (autogen_docs_start)


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| project_id | The project ID to host the network in | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| network_01_name | The name of the VPC network-01 |
| network_01_routes | The routes associated with network-01 |
| network_01_self_link | The URI of the VPC network-01 |
| network_01_subnets | The names of the subnets being created on network-01 |
| network_01_subnets_flow_logs | Whether the subnets will have VPC flow logs enabled |
| network_01_subnets_ips | The IP and cidrs of the subnets being created on network-01 |
| network_01_subnets_private_access | Whether the subnets will have access to Google API's without a public IP on network-01 |
| network_01_subnets_regions | The region where the subnets will be created on network-01 |
| network_01_subnets_secondary_ranges | The secondary ranges associated with these subnets on network-01 |
| network_02_name | The name of the VPC network-02 |
| network_02_routes | The routes associated with network-02 |
| network_02_self_link | The URI of the VPC network-02 |
| network_02_subnets | The names of the subnets being created on network-02 |
| network_02_subnets_flow_logs | Whether the subnets will have VPC flow logs enabled |
| network_02_subnets_ips | The IP and cidrs of the subnets being created on network-02 |
| network_02_subnets_private_access | Whether the subnets will have access to Google API's without a public IP on network-02 |
| network_02_subnets_regions | The region where the subnets will be created on network-02 |
| network_02_subnets_secondary_ranges | The secondary ranges associated with these subnets on network-02 |

[^]: (autogen_docs_end)
