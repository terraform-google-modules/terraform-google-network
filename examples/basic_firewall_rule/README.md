#  Firewall Rule

This example configures a single firewall rule inside of a project.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The project ID to host the network in | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| name | The name of the firewall rule being created |
| network\_name | The name of the VPC network where the firewall is applied |
| project\_id | VPC project id |
| rule\_self\_link | The URI of the VPC being created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
