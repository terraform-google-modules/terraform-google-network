# Simple Project

This example configures a single auto mode VPC inside of a project.

#  Auto mode network

This example configures a single simple auto mode VPC network inside of a project.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The project ID to host the network in | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| auto | The value of the auto mode setting |
| network\_name | The name of the VPC being created |
| network\_self\_link | The URI of the VPC being created |
| project\_id | VPC project id |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
