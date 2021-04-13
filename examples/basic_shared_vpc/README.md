# Simple shared VPC Project

This example enables shared VPC on a host project and attaches a service project.

#  Custom mode network

This example configures a single simple custom mode VPC network inside of a project.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project | The host project ID | `any` | n/a | yes |
| service\_project | The service project ID | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| project | Host project ID |
| service\_project | Service project ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
