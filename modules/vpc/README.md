# Terraform Network Module

This submodule is part of the the `terraform-google-network` module. It creates a vpc network and optionally enables it as a Shared VPC host project.

It supports creating:

- A VPC Network
- Optionally enabling the network as a Shared VPC host

## Compatibility

This module is meant for use with Terraform 0.12. If you haven't [upgraded](https://www.terraform.io/upgrade-guides/0-12.html) and need a Terraform 0.11.x-compatible version of this module, the last released version intended for Terraform 0.11.x is [0.8.0](https://registry.terraform.io/modules/terraform-google-modules/network/google/0.8.0).

## Usage

Basic usage of this submodule is as follows:

```hcl
module "vpc" {
    source  = "terraform-google-modules/network/google//modules/routes"
    version = "~> 2.0.0"

    project_id   = "<PROJECT ID>"
    network_name = "example-vpc"

    shared_vpc_host = false
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| auto\_create\_subnetworks | When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources. | bool | `"false"` | no |
| description | An optional description of this resource. The resource must be recreated to modify this field. | string | `""` | no |
| network\_name | The name of the network being created | string | n/a | yes |
| project\_id | The ID of the project where this VPC will be created | string | n/a | yes |
| routing\_mode | The network routing mode (default 'GLOBAL') | string | `"GLOBAL"` | no |
| shared\_vpc\_host | Makes this project a Shared VPC host if 'true' (default 'false') | string | `"false"` | no |

## Outputs

| Name | Description |
|------|-------------|
| network | The VPC resource being created |
| network\_name | The name of the VPC being created |
| network\_self\_link | The URI of the VPC being created |
| svpc\_host\_project\_id | Shared VPC host project id. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
