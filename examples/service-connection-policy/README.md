# Service Connection Policy example

This example creates:

- A VPC network and subnetwork
- A Service Connection Policy attached to that network and subnetwork

## Run

```bash
terraform init
terraform apply
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | Project ID. | `string` | n/a | yes |
| region | Region (e.g., us-central1). | `string` | `"us-central1"` | no |
| service\_class | Service class for the managed service (example value shown in README). | `string` | `"gcp-memorystore-redis"` | no |

## Outputs

| Name | Description |
|------|-------------|
| service\_connection\_policy\_id | ID of the created Service Connection Policy. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->