# VPC Serverless Connector Beta

This example deploys a single vpc serverless connector in the us-central1 region.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| host\_project\_id | Host Project in which the shared vpc network exists. | `string` | n/a | yes |
| project\_id | Project in which the vpc connector will be deployed. | `string` | n/a | yes |
| subnet\_name | Name of the existing /28 subnet to reserve for the connector. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| connector\_ids | ID of the vpc serverless connector that was deployed. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
