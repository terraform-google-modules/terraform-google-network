# VPC network peering

This example configures VPC network peering.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| local\_network | Self link to the local network. | `string` | n/a | yes |
| peer\_network | Self link to the peer network. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| local\_network | The local network peering information |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
