# Firewall Rules

This example configures a VPC with firewall rules inside of a project.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| network\_name | The name of the VPC network being created | string | n/a | yes |
| project\_id | The project ID to host the network in | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| network\_name | The name of the VPC being created |
| network\_self\_link | The URI of the VPC being created |
| project\_id | VPC project id |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
