# Secondary Ranges

This example creates a single simple VPC network inside of a project.

This VPC network has three subnets. The first subnet has two secondary
ranges, and the third has a single secondary range.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| network\_name | The name of the VPC network being created | `any` | n/a | yes |
| project\_id | The project ID to host the network in | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| network\_name | The name of the VPC being created |
| network\_self\_link | The URI of the VPC being created |
| project\_id | VPC project id |
| subnets\_ips | The IP and cidrs of the subnets being created |
| subnets\_names | The names of the subnets being created |
| subnets\_private\_access | Whether the subnets will have access to Google API's without a public IP |
| subnets\_regions | The region where subnets will be created |
| subnets\_secondary\_ranges | The secondary ranges associated with these subnets |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
