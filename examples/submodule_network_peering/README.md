# Simple VPC Network Peering

This example creates a VPC Network peering between two VPCs.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| local\_network\_name | The name of the local VPC network being created | string | `"local-network"` | no |
| peer\_network\_name | The name of the peer VPC network being created | string | `"peer-network"` | no |
| prefix | Name prefix for the network peerings | string | `"network-peering"` | no |
| project\_id | The project ID to put the resources in | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| local\_network\_peering | Network peering resource. |
| peer\_network\_peering | Peer network peering resource. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->