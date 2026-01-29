# Private Service Connect Endpoints for Published Services
This example creates a Private Service Connect endpoint which targets a producer service attachment.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| private\_service\_connect\_producer\_project\_id | Producer project ID for Private Service Connect. | `string` | n/a | yes |
| project\_id | Project ID for Private Service Connect. | `string` | n/a | yes |
| region | Region for Private Service Connect. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| address\_id | An identifier for the address created for the private service connect with format projects/{$project}/regions/{$region}/addresses/{$name}. |
| address\_name | Private Service Connect address name. |
| forwarding\_rule\_name | Private Service Connect forwarding rule resource name. |
| ip\_address | Private Service Connect IP address. |
| project\_id | The project id |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
