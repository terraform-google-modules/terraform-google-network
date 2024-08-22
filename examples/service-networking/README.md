# Terraform service networking example
This example creates service networking with a global address.

```
resource "google_compute_network" "peering_network" {
  name                    = "private-network"
  auto_create_subnetworks = "false"
  project                 = var.project_id
}

module "service_networking" {
  source  = "terraform-google-modules/network/google//modules/service-networking"
  version = "~> 9.0"

  project_id       = var.project_id
  network_name     = google_compute_network.peering_network.name
  global_addresses = [{ name : "global-address" }]
  service          = "servicenetworking.googleapis.com"
}
```

In the above terraform, a service networking connection is created. It enables managed services (cloud sql,memorystore) on internal IP addresses (VPC) to service consumers (cloud-run). Service consumers use private services access to privately connect to the service.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | Project ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| peering | Service networking peering output |
| project\_id | Project ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
