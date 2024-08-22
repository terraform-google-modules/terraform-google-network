# Terraform Google service networking

This module creates global network address and a service networking. The google_service_networking_connection terraform resource allows to establish a private connection between a Google Cloud Platform (GCP) VPC network and a supported Google service, such as Cloud SQL, BigQuery, or a third-party service.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_peered\_dns\_domain | Create peered dns domain | `bool` | `false` | no |
| create\_peering\_routes\_config | Create peering route config | `bool` | `false` | no |
| deletion\_policy | Deletion policy for service networking resource | `string` | `null` | no |
| dns\_suffix | Dns suffix | `string` | `null` | no |
| domain\_name | Domain name | `string` | `null` | no |
| export\_custom\_routes | Export custom routes | `bool` | `false` | no |
| global\_addresses | List of global addresses to be created | <pre>list(object({<br>    name : string,<br>    purpose : optional(string, "VPC_PEERING"),<br>    type : optional(string, "INTERNAL"),<br>    address : optional(string, null),<br>    prefix_length : optional(number, 16)<br>  }))</pre> | n/a | yes |
| import\_custom\_routes | Import custom routes to peering rout config | `bool` | `false` | no |
| network\_name | Network name | `string` | n/a | yes |
| project\_id | Project ID | `string` | n/a | yes |
| service | Service to create service networking connection | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| address\_ids | Global address id |
| peering | Service networking connection peering |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
