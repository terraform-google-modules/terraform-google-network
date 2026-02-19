# Private Service Connect Endpoints For Published Services

This module enables the usage of [Private Service Connect](https://cloud.google.com/vpc/docs/private-service-connect) for a specific subnetwork.

The resources created/managed by this module are:

- Regional Address resource to configure `Private Service Connect For Published Services` endpoint
- Regional Forwarding Rule resource to target a Producer Service Attachment

Both resources are created under the provided `project_id`.

## Usage

Basic usage of this module is as follows:

IPv4
```hcl
module "private_service_connect_endpoints_for_published_services" {
  source  = "terraform-google-modules/network/google//modules/private-service-connect-endpoints-for-published-services"
  version = "~> 16.0"

  project_id             = "my-project-id"
  region                 = "us-central1"
  network                = "my-network-name"
  subnetwork             = "my-subnet-name"
  service_attachment     = "https://www.googleapis.com/compute/v1/projects/producer-project/regions/us-central1/serviceAttachments/producer-sa"

  depends_on = [module.consumer-network]
}
```

IPv6
```hcl
module "private_service_connect_endpoints_for_published_services" {
  source  = "terraform-google-modules/network/google//modules/private-service-connect-endpoints-for-published-services"
  version = "~> 13.0"

  project_id           = "my-project-id"
  region               = "us-central1"
  network              = "my-network-name"
  subnetwork           = "my-subnet-name"
  ip_version           = "IPV6"
  service_attachment   = "https://www.googleapis.com/compute/v1/projects/producer-project/regions/us-central1/serviceAttachments/producer-sa"

  depends_on = [module.consumer-network]
}
```

Private Service Connect IP must fulfill requirements detailed [here](https://cloud.google.com/vpc/docs/configure-private-service-connect-apis#ip-address-requirements).

A functional example is included in the [examples/private_service_connect_endpoints_for_published_services](./examples/private_service_connect_endpoints_for_published_services) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| address\_name | Private Service Connect Endpoint address name. | `string` | `"psc-for-published-services-endpoint-address"` | no |
| forwarding\_rule\_name | Private Service Connect Forwarding Rule resource name. Follow regular GCE naming pattern: https://docs.cloud.google.com/compute/docs/naming-resources#resource-name-format. | `string` | `"psc-for-published-services-endpoint"` | no |
| ip\_address | Private Service Connect Endpoint IP address. GCP will pick an IP if left unset. | `string` | `null` | no |
| ip\_version | `IPv4`or `IPv6`. Only set this field when private\_service\_connect\_ip is unset. If both ip\_address and ip\_version are unset, GCP will pick an IPv4 address. | `string` | `null` | no |
| network | Name, id or self link of the network to create resources in. For Shared VPC case, use network self link. | `string` | n/a | yes |
| project\_id | Project ID in which to provision the resources. | `string` | n/a | yes |
| psc\_global\_access | Whether to allow Private Service Connect global access. | `bool` | `false` | no |
| region | Region in which to provision the resources. | `string` | n/a | yes |
| service\_attachment | The target service attachment resource URL for this Private Service Connect Endpoint. | `string` | n/a | yes |
| service\_directory\_namespace | Service Directory namespace to register the forwarding rule under. | `string` | `null` | no |
| subnetwork | Name, id or self link of the subnetwork to create resources in. For Shared VPC case, use subnetwork self link. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| address\_id | Private Service Connect address ID with format `projects/{$project}/regions/{$region}/addresses/{$name}`. |
| address\_name | Private Service Connect address name. |
| address\_self\_link | Private Service Connect address self link with format `https://www.googleapis.com/compute/v1/projects/{$project}/regions/{$region}/addresses/{$name}`. |
| forwarding\_rule\_id | Private Service Connect forwarding rule ID with format `projects/{$project}/regions/{$region}/forwardingRules/{$name}`. |
| forwarding\_rule\_name | Private Service Connect forwarding rule resource name. |
| forwarding\_rule\_self\_link | Private Service Connect forwarding rule self link with format `https://www.googleapis.com/compute/v1/projects/{$project}/regions/{$region}/forwardingRules/{$name}`. |
| ip\_address | Private Service Connect IP address. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v1.5+
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v7.11+

### Service Account

A service account with the following roles must be used to provision
the resources of this module:

- Network Admin: `roles/compute.networkAdmin`
- Service Directory Admin: `roles/servicedirectory.admin`

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Google Cloud Compute API: `compute.googleapis.com`
- Service Directory API: `servicedirectory.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.
