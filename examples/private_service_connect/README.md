# Private Service Connect
This example configures a single VPC inside a project and enables it to consume a Private Service Connect endpoint.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment\_code | A short form of the folder level resources (environment) within the Google Cloud organization. | `string` | n/a | yes |
| project\_id | Project ID for Private Service Connect. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| global\_address\_id | An identifier for the global address created for the private service connect with format `projects/{{project}}/global/addresses/{{name}}` |
| private\_service\_connect\_ip | The private service connect ip |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->