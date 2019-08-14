# Simple Project With Firewall

This example configures a single simple VPC inside of a project, and adds a basic firewall.

This VPC has two subnets, with no secondary ranges.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| network\_name | The name of the VPC network being created | string | n/a | yes |
| project\_id | The project ID to host the network in | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| admin\_ranges | Firewall attributes for admin ranges. |
| internal\_ranges | Firewall attributes for internal ranges. |
| network\_name | The name of the VPC being created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
