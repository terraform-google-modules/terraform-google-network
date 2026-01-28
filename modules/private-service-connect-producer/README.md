# Private Service Connect Producer

## Description
Module to deploy Private Service Connect NAT subnets and a service attachment.

- User provides the producer network and Internal Load Balancer.
- This module creates NAT subnets with `PRIVATE_SERVICE_CONNECT` purpose and a service attachment.
- In case of shared VPC, the module will create the NAT subnets in the host project.
- This module does not support existing NAT subnets as input.

## Documentation
- [Publish services by using Private Service Connect](http://cloud/vpc/docs/configure-private-service-connect-producer)

## Cost
[Blueprint cost details](https://cloud.google.com/products/calculator?id=02fb0c45-cc29-4567-8cc6-f72ac9024add)

## Usage

Basic usage of this module is as follows:

IPv4

```hcl
module "psc_producer" {
  source  = "terraform-google-modules/psc-producer/google"
  version = "~> 13.1"

  project = "my-project-id"
  network = "my-network-name"
  name    = "producer-sa"

  region                = "us-central1"
  connection_preference = "ACCEPT_MANUAL"
  consumer_accept_lists = [
    {
      project_id_or_num = "accepted-project-id"
      connection_limit  = 10
    },
  ]
  consumer_reject_lists = ["rejected-project-id"]
  nat_subnets           = [
    {
      ipv4_range = "10.10.20.0/24"
    }
  ]
  target_service        = var.forwarding_rule_url
}
```

IPv6

```hcl
module "psc_producer" {
  source  = "terraform-google-modules/psc-producer/google"
  version = "~> 0.1"

  project = "my-project-id"
  network = "my-network-name"
  name    = "producer-sa"

  region                = "us-central1"
  connection_preference = "ACCEPT_MANUAL"
  consumer_accept_lists = [
    {
      project_id_or_num = "accepted-project-id"
      connection_limit  = 10
    },
  ]
  consumer_reject_lists = ["rejected-project-id"]
  nat_subnets           = [
    {
      stack_type = "IPV6_ONLY"
    }
  ]
  target_service        = var.forwarding_rule_url
}
```

IPv4_IPv6

```hcl
module "psc_producer" {
  source  = "terraform-google-modules/psc-producer/google"
  version = "~> 0.1"

  project = "my-project-id"
  network = "my-network-name"
  name    = "producer-sa"

  region                = "us-central1"
  connection_preference = "ACCEPT_MANUAL"
  consumer_accept_lists = [
    {
      project_id_or_num = "accepted-project-id"
      connection_limit  = 10
    },
  ]
  consumer_reject_lists = ["rejected-project-id"]
  nat_subnets           = [
    {
      name       = "producer-nat-subnet-0"
      stack_type = "IPV4_IPV6"
      ipv4_range = "10.10.20.0/24" # required for dual-stack subnet
    }
    {
      name       = "producer-nat-subnet-1"
      stack_type = "IPV4_IPV6"
      ipv4_range = "10.10.30.0/24" # required for dual-stack subnet
    }
  ]
  target_service        = var.forwarding_rule_url
}
```

Shared VPC

```hcl
module "psc_producer" {
  source  = "terraform-google-modules/psc-producer/google"
  version = "~> 0.1"

  project = "service-project-id"
  network_project = "host-project-id"
  network = "host-network-name"
  name    = "producer-sa"

  region                = "us-central1"
  connection_preference = "ACCEPT_AUTOMATIC"
  nat_subnets           = [
    {
      stack_type = "IPV6_ONLY"
    }
  ]
  target_service        = var.forwarding_rule_url
}
```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| connection\_preference | ACCEPT\_AUTOMATIC or ACCEPT\_MANUAL | `string` | n/a | yes |
| consumer\_accept\_lists | (Optional) An array of projects/networks that are allowed to connect to this service attachment: The list needs to be either project-based or network-based. | <pre>list(object({<br>    project_id_or_num = optional(string)<br>    network_url       = optional(string)<br>    connection_limit  = number<br>  }))</pre> | `[]` | no |
| consumer\_reject\_lists | (Optional) An array of projects/networks that are not allowed to connect to this service attachment. | `list(string)` | `null` | no |
| domain\_names | (Optional) The domain names to be used during the integration between the PSC connected endpoints and the Cloud DNS. | `list(string)` | `null` | no |
| enable\_proxy\_protocol | (Optional) Enables the proxy protocol which is for supplying client TCP/IP address data in TCP connections that traverse proxies on their way to destination servers. | `bool` | `false` | no |
| name | Name for the service attachment. | `string` | n/a | yes |
| nat\_subnets | NAT Subnets.<br>  - subnet\_name: (Optional) Name of the subnet. Defaults to `$var.name-nat-subnet-$index` if unset.<br>  - ipv4\_range: (Optional) IPv4 range is required for IPV4\_ONLY and IPV4\_IPV6 stack type. Leave ipv4\_range unset for IPV6\_ONLY subnet.<br>  - stack\_type: (Optional) IPV4\_ONLY, IPV4\_IPV6 or IPV6\_ONLY. IPv6 range is assigned by GCP. | <pre>list(object({<br>    subnet_name = optional(string)<br>    ipv4_range  = optional(string)<br>    stack_type  = optional(string)<br>  }))</pre> | n/a | yes |
| network | Name, id or self link of the network to create resources in. | `string` | n/a | yes |
| network\_project\_id | (Optional) Name of the project for the Shared VPC host network, in which the NAT subnets will be created. Required for Shared VPC case. | `string` | `null` | no |
| project\_id | The project to deploy to, if not set the default provider project is used. | `string` | n/a | yes |
| propagated\_connection\_limit | (Optional) The number of consumer spokes that connected Private Service Connect endpoints can be propagated to through Network Connectivity Center. | `number` | `null` | no |
| reconcile\_connections | (Optional) Determines whether a consumer accept/reject list change can reconcile the statuses of existing ACCEPTED or REJECTED PSC endpoints. | `bool` | `false` | no |
| region | Region for cloud resources. | `string` | n/a | yes |
| target\_service | Target service URL ex. ILB, SWP. Supported types: https://cloud.google.com/vpc/docs/configure-private-service-connect-producer#lb-types | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| service\_attachment\_id | ID of the service attachment with format `projects/{$project}/regions/{$region}/serviceAttachments/{$name}` |
| service\_attachment\_name | Name of the service attachment |
| service\_attachment\_self\_link | Self link of the service attachment with format `https://www.googleapis.com/compute/v1/projects/{$project}/regions/{$region}/serviceAttachments/{$name}` |

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

- Network Admin: `roles/compute.networkAdmin` (in case of Shared VPC, ensure this permission is enabled for both the host project and the service project).

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Google Cloud Compute API: `compute.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.
