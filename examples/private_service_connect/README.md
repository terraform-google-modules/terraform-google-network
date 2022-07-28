# Private Service Connect
This example configures a single VPC inside a project and enables it to consume a Private Service Connect endpoint.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | Project ID for Private Service Connect. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| dns\_zone\_gcr\_name | Name for Managed DNS zone for GCR |
| dns\_zone\_googleapis\_name | Name for Managed DNS zone for GoogleAPIs |
| dns\_zone\_pkg\_dev\_name | Name for Managed DNS zone for PKG\_DEV |
| forwarding\_rule\_name | Forwarding rule resource name. |
| forwarding\_rule\_target | Target resource to receive the matched traffic. Only `all-apis` and `vpc-sc` are valid. |
| global\_address\_id | An identifier for the global address created for the private service connect with format `projects/{{project}}/global/addresses/{{name}}` |
| network\_name | The network name |
| private\_service\_connect\_ip | The private service connect ip |
| private\_service\_connect\_name | Private service connect name |
| project\_id | The project id |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
