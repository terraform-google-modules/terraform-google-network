# Service Connection Policy

Creates one or more **Network Connectivity Service Connection Policies** to enable
**Private Service Connect (PSC)** connectivity for supported managed services,
and can optionally enable required APIs.

## Requirements

The following APIs must be enabled in the target project:

- `serviceconsumermanagement.googleapis.com`
- `networkconnectivity.googleapis.com`
- `compute.googleapis.com`

By default, this module can enable the required APIs automatically (see `enable_apis`).

## Usage

```hcl
module "service_connection_policy" {
  source  = "terraform-google-modules/network/google//modules/service-connection-policy"
  version = "~> 18.1"

  project_id = "my-project"

  service_connection_policies = {
    "example-scp" = {
      location        = "us-east4"
      service_class   = "gcp-memorystore-redis"
      network_project = "my-project"
      network_name    = "example-vpc"
      subnet_names    = ["psc-subnet"]
      labels          = { env = "dev" }
      # limit                                        = 120
      # description                                  = "Example policy"
      # producer_instance_location                   = "CUSTOM_RESOURCE_HIERARCHY_LEVELS"
      # allowed_google_producers_resource_hierarchy_level = ["projects/my-project"]
    }
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enable\_apis | Whether to enable required APIs in the project. | `bool` | `true` | no |
| project\_id | The project ID where APIs will be enabled (when enable\_apis is true). | `string` | n/a | yes |
| service\_connection\_policies | The Service Connection Policies to create. | <pre>map(object({<br>    description     = optional(string)<br>    location        = string<br>    service_class   = string<br>    network_name    = string<br>    network_project = string<br>    subnet_names    = list(string)<br>    limit           = optional(number)<br>    producer_instance_location                         = optional(string)<br>    allowed_google_producers_resource_hierarchy_level = optional(list(string))<br>    labels          = optional(map(string), {})<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| service\_connection\_policies | Service Connection Policies created. |
| service\_connection\_policy\_ids | IDs of the created Service Connection Policies. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->