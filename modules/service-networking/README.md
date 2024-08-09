# Terraform Google service networking

This module creates global network address and a service networking
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| address\_name | Global address name | `string` | n/a | yes |
| address\_prefix\_length | Global address prefix length | `number` | `16` | no |
| address\_purpose | Global address purpose | `string` | `"VPC_PEERING"` | no |
| address\_type | Global address type | `string` | `"INTERNAL"` | no |
| create\_peered\_dns\_domain | Create peered dns domain | `bool` | `false` | no |
| create\_peering\_routes\_config | Create peering route config | `bool` | `false` | no |
| deletion\_policy | Deletion policy for service networking resource | `string` | `null` | no |
| dns\_suffix | Dns suffix | `string` | `null` | no |
| domain\_name | Domain name | `string` | `null` | no |
| export\_custom\_routes | Export custom routes | `bool` | `false` | no |
| import\_custom\_routes | Import custom routes to peering rout config | `bool` | `false` | no |
| network\_id | Network id | `string` | n/a | yes |
| network\_name | Network name | `string` | `null` | no |
| project\_id | Project ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| address\_id | Global address id |
| peering | Service networking connection peering |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
