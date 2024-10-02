#  hierarchical Firewall Policy Rule

This example creates a Service Account and 2 hierarchical firewall policy. First policy will have a few rules and will be attached to folders. Second policy will not be attached and any folders/org and will not have any rules.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| folder1 | The folder\_id ID 1 to to create firewall policy in | `any` | n/a | yes |
| folder2 | The folder\_id ID 2 to attach firewal policy to | `any` | n/a | yes |
| folder3 | The folder\_id ID 3 to attach firewal policy to | `any` | n/a | yes |
| project\_id | The project ID to host the network in | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| firewal\_policy\_no\_rules\_id | ID of Firewall policy created without any rules and association |
| firewal\_policy\_no\_rules\_name | Name of Firewall policy created without any rules and association |
| firewal\_policy\_no\_rules\_parent\_folder | Firewall policy parent |
| fw\_policy\_id | Firewall policy ID |
| fw\_policy\_name | Firewall policy name |
| fw\_policy\_parent\_folder | Firewall policy parent |
| project\_id | Project ID |
| rules | Firewall policy rules |
| target\_associations | Firewall policy association |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
