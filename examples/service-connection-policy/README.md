# Service Connection Policy example

This example creates:
- A VPC network and a subnetwork
- A Service Connection Policy attached to that network and subnetwork

All values are hardcoded except `project_id`.

## Run

```bash
terraform init
terraform apply
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | Project ID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| service\_connection\_policy\_ids | IDs of the created Service Connection Policies. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->