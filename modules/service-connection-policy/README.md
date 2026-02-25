# Service Connection Policy

Creates a **Network Connectivity Service Connection Policy** to enable
**Private Service Connect (PSC)** connectivity for supported managed services in Google Cloud.

This module allows you to define which VPC network and subnetworks will be used
to automatically provision PSC endpoints for compatible services.

## Requirements

The following APIs must be enabled in the target project:

- `networkconnectivity.googleapis.com`
- `compute.googleapis.com`

## Provider

This module declares the `google` provider only.  
If you need to use features that are still in beta, you can inject the
`google-beta` provider from the root module:

```hcl
provider "google-beta" {
  project = var.project_id
  region  = var.region
}

module "service_connection_policy" {
  source = "terraform-google-modules/network/google//modules/service-connection-policy"

  providers = {
    google = google-beta
  }

  # ...
}


## Usage

module "service_connection_policy" {
  source  = "terraform-google-modules/network/google//modules/service-connection-policy"
  version = "~> 13.1"

  project_id    = "my-project"
  name          = "example-scp"
  location      = "us-east4"
  network        = "projects/my-project/global/networks/default"
  service_class = "gcp-memorystore-redis"

  subnetworks = [
    "projects/my-project/regions/us-east4/subnetworks/default"
  ]

  labels = {
    env = "dev"
  }
}

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