#  Network Firewall Policy Rule

This example creates a VPC network, Service Account, tag, address group and 2 `global` network firewall policy. First policy will have a few rules and will be attached to a VPC network. Second policy will not be attached and any VPC and will not have any rules.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The project ID to host the network in | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| firewal\_policy | Firewall policy created |
| firewal\_policy\_no\_rules | Firewall policy created without any rules and association |
| firewal\_policy\_no\_rules\_name | Name of Firewall policy created without any rules and association |
| firewal\_policy\_rules | Firewall policy rules created |
| firewal\_policy\_vpc\_associations | Firewall policy vpc association |
| firewall\_policy\_name | Firewall policy name |
| project\_id | Firewall policy project ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
