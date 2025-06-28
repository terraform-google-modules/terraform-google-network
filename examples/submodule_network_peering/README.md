# Simple VPC Network Peering

This example creates three VPCs: `local-network`, `peer-network-1`, and `peer-network-2`, and sets up VPC peering between `local-network` and both `peer-network-1` and `peer-network-2`.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The project ID to put the resources in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| peering1 | Peering1 module output. |
| peering2 | Peering2 module output. |
| project\_id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
