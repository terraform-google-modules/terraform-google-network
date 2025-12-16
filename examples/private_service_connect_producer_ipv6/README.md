# Private Service Connect Producer IPv6

This example creates a service attachment with IPv6_ONLY NAT subnet.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The ID of the project in which to provision resources. | `string` | n/a | yes |
| region | The region in which to provision resources. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| nat\_subnets | The NAT subnets. |
| service\_attachment\_name | The service attachment name. |
| service\_attachment\_self\_link | The service attachment self link. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
