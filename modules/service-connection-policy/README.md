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
| description | Optional description for the policy. | `string` | `null` | no |
| labels | Labels to apply to the policy. | `map(string)` | `{}` | no |
| limit | Optional PSC connection limit (psc\_config.limit). | `number` | `null` | no |
| location | Region where the policy will be created (e.g., us-central1). | `string` | n/a | yes |
| name | Name of the Service Connection Policy. | `string` | n/a | yes |
| network | VPC network self\_link (recommended) or id to attach the policy to. | `string` | n/a | yes |
| project\_id | The project ID where the Service Connection Policy will be created. | `string` | n/a | yes |
| service\_class | Service class of the managed service to enable PSC for (see product docs for valid values). | `string` | n/a | yes |
| subnetworks | List of subnetwork self\_links used by PSC (psc\_config.subnetworks). | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The resource ID of the created Service Connection Policy. |
| location | The region of the created Service Connection Policy. |
| name | The name of the created Service Connection Policy. |
| network | The VPC network attached to the policy. |
| service\_class | The service class attached to the policy. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->