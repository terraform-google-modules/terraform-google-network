# Service Connection Policy

Creates **Network Connectivity Service Connection Policies** to enable
**Private Service Connect (PSC)** connectivity for supported managed services.

This module follows the same general pattern used by the Redis Cluster module:
- Accepts a map of policies (`service_connection_policies`)
- Constructs network and subnetwork self-links from `network_project`, `network_name`, and `subnet_names`
- Optionally enables required APIs

## Requirements

The following APIs must be enabled in the target project:

- `networkconnectivity.googleapis.com`
- `compute.googleapis.com`

By default, this module can enable the required APIs automatically (see `enable_apis`).

## Usage

```hcl
module "service_connection_policy" {
  source  = "terraform-google-modules/network/google//modules/service-connection-policy"
  version = "~> 13.1"

  project_id    = "my-project"
  location      = "us-east4"
  service_class = "gcp-memorystore-redis"

  service_connection_policies = {
    "example-scp" = {
      network_project = "my-project"
      network_name    = "example-vpc"
      subnet_names    = ["psc-subnet"]
      labels          = { env = "dev" }
      # limit        = 120
      # description  = "Example policy"
    }
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| activate\_apis | APIs to enable when enable\_apis is true. | `list(string)` | <pre>[<br>  "networkconnectivity.googleapis.com",<br>  "compute.googleapis.com"<br>]</pre> | no |
| enable\_apis | Whether to enable required APIs in the project. | `bool` | `true` | no |
| location | Region where the Service Connection Policies will be created (e.g., us-east4). | `string` | n/a | yes |
| project\_id | The project ID where APIs will be enabled (when enable\_apis is true). | `string` | n/a | yes |
| service\_class | Service class of the managed service to enable PSC for (see product docs for valid values). | `string` | n/a | yes |
| service\_connection\_policies | The Service Connection Policies to create. | <pre>map(object({<br>    description     = optional(string)<br>    network_name    = string<br>    network_project = string<br>    subnet_names    = list(string)<br>    limit           = optional(number)<br>    labels          = optional(map(string), {})<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| service\_connection\_policies | Service Connection Policies created. |
| service\_connection\_policy\_ids | IDs of the created Service Connection Policies. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->