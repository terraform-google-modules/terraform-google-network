# Terraform Network Module

This modules makes it easy to set up a new VPC Network in GCP by defining your network and subnet ranges in a concise syntax.

It supports creating:

- A Google Virtual Private Network (VPC)
- Subnets within the VPC
- Secondary ranges for the subnets (if applicable)

## Compatibility

This module is meant for use with Terraform 0.12. If you haven't [upgraded](https://www.terraform.io/upgrade-guides/0-12.html) and need a Terraform 0.11.x-compatible version of this module, the last released version intended for Terraform 0.11.x is [0.8.0](https://registry.terraform.io/modules/terraform-google-modules/network/google/0.8.0).

## Usage
You can go to the examples folder, however the usage of the module could be like this in your own main.tf file:

```hcl
module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 1.0.0"

    project_id   = "<PROJECT ID>"
    network_name = "example-vpc"
    routing_mode = "GLOBAL"

    subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = "us-west1"
        },
        {
            subnet_name           = "subnet-02"
            subnet_ip             = "10.10.20.0/24"
            subnet_region         = "us-west1"
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
        },
    ]

    secondary_ranges = {
        subnet-01 = [
            {
                range_name    = "subnet-01-secondary-01"
                ip_cidr_range = "192.168.64.0/24"
            },
        ]

        subnet-02 = []
    }

    routes = [
        {
            name                   = "egress-internet"
            description            = "route through IGW to access internet"
            destination_range      = "0.0.0.0/0"
            tags                   = "egress-inet"
            next_hop_internet      = "true"
        },
        {
            name                   = "app-proxy"
            description            = "route through proxy to reach app"
            destination_range      = "10.50.10.0/24"
            tags                   = "app-proxy"
            next_hop_instance      = "app-proxy-instance"
            next_hop_instance_zone = "us-west1-a"
        },
    ]
}
```

Then perform the following commands on the root folder:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| auto\_create\_subnetworks | When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources. | bool | `"false"` | no |
| delete\_default\_internet\_gateway\_routes | If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted | string | `"false"` | no |
| description | An optional description of this resource. The resource must be recreated to modify this field. | string | `""` | no |
| network\_name | The name of the network being created | string | n/a | yes |
| project\_id | The ID of the project where this VPC will be created | string | n/a | yes |
| routes | List of routes being created in this VPC | list(map(string)) | `<list>` | no |
| routing\_mode | The network routing mode (default 'GLOBAL') | string | `"GLOBAL"` | no |
| secondary\_ranges | Secondary ranges that will be used in some of the subnets | object | `<map>` | no |
| shared\_vpc\_host | Makes this project a Shared VPC host if 'true' (default 'false') | string | `"false"` | no |
| subnets | The list of subnets being created | list(map(string)) | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| network\_name | The name of the VPC being created |
| network\_self\_link | The URI of the VPC being created |
| routes | The routes associated with this VPC |
| subnets\_flow\_logs | Whether the subnets will have VPC flow logs enabled |
| subnets\_ips | The IPs and CIDRs of the subnets being created |
| subnets\_names | The names of the subnets being created |
| subnets\_private\_access | Whether the subnets will have access to Google API's without a public IP |
| subnets\_regions | The region where the subnets will be created |
| subnets\_secondary\_ranges | The secondary ranges associated with these subnets |
| subnets\_self\_links | The self-links of subnets being created |
| svpc\_host\_project\_id | Shared VPC host project id. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

### Subnet Inputs
The subnets list contains maps, where each object represents a subnet. Each map has the following inputs (please see examples folder for additional references):

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| subnet_name | The name of the subnet being created  | string | - | yes |
| subnet_ip | The IP and CIDR range of the subnet being created | string | - | yes |
| subnet_region | The region where the subnet will be created  | string | - | yes |
| subnet_private_access | Whether this subnet will have private Google access enabled | string | false | no |
| subnet_flow_logs  | Whether the subnet will record and send flow log data to logging | string | false | no |

### Route Inputs
The routes list contains maps, where each object represents a route. For the next_hop_* inputs, only one is possible to be used in each route. Having two next_hop_* inputs will produce an error. Each map has the following inputs (please see examples folder for additional references):

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| name | The name of the route being created  | string | - | no |
| description | The description of the route being created | string | - | no |
| tags | The network tags assigned to this route. This is a list in string format. Eg. "tag-01,tag-02"| string | - | yes |
| destination_range | The destination range of outgoing packets that this route applies to. Only IPv4 is supported | string | - | yes
| next_hop_internet | Whether the next hop to this route will the default internet gateway. Use "true" to enable this as next hop | string | - | yes |
| next_hop_ip | Network IP address of an instance that should handle matching packets | string | - | yes |
| next_hop_instance |  URL or name of an instance that should handle matching packets. If just name is specified "next_hop_instance_zone" is required | string | - | yes |
| next_hop_instance_zone |  The zone of the instance specified in next_hop_instance. Only required if next_hop_instance is specified as a name | string | - | no |
| next_hop_vpn_tunnel | URL to a VpnTunnel that should handle matching packets | string | - | yes |
| priority | The priority of this route. Priority is used to break ties in cases where there is more than one matching route of equal prefix length. In the case of two routes with equal prefix length, the one with the lowest-numbered priority value wins | string | 1000 | yes |

## Requirements
### Installed Software
- [Terraform](https://www.terraform.io/downloads.html) ~> 0.12.0
- [Terraform Provider for GCP][terraform-provider-google] ~> 2.10.0
- [gcloud](https://cloud.google.com/sdk/gcloud/) >243.0.0

### Configure a Service Account
In order to execute this module you must have a Service Account with the following roles:

- roles/compute.networkAdmin on the organization or folder

If you are going to manage a Shared VPC, you must have either:

- roles/compute.xpnAdmin on the organization
- roles/compute.xpnAdmin on the folder (beta)

### Enable API's
In order to operate with the Service Account you must activate the following API on the project where the Service Account was created:

- Compute Engine API - compute.googleapis.com

## File structure
The project has the following folders and files:

- /: root folder
- /examples: examples for using this module
- /test: Folders with files for testing the module (see Testing section on this file)
- /main.tf: main file for this module, contains all the resources to create
- /variables.tf: all the variables for the module
- /output.tf: the outputs of the module
- /README.md: this file

## Testing and documentation generation

### Requirements
- [docker](https://docker.com/)

### Integration testing
##### Terraform integration tests

The module's integration tests are designed to be run within a Docker
container containing all the dependencies required for testing. The
`docker_test_integration` make target wraps this behavior but requires the
following configuration to execute properly:

- Configure a service account with the roles documented above and export the JSON key to the `SERVICE_ACCOUNT_JSON` environment variable

        export SERVICE_ACCOUNT_JSON=$(< /path/to/credentials.json)

- Create `test/fixtures/shared/terraform.tfvars` and populate with the required Terraform input variables (see `test/fixtures/shared/terraform.tfvars.sample` for more information)

Once those steps have been completed run `make docker_test_integration` from
the root of the repository to execute the tests within the `project_id`
provided. Infrastructure from `test/fixtures/*` will be provisioned,
integration tests from `test/integration/*` will be executed, and the
infrastructure will be deprovisioned to complete the process.

### Autogeneration of documentation from .tf files
Run
```
make generate_docs
```

### Lint testing

Lint testing is also performed within a Docker container containing all the
dependencies required for lint tests. Execute those tests by running `make
docker_test_lint` from the root of the repository.

Successful output looks similar to the following:

```
Checking for trailing whitespace
Checking for missing newline at end of file
Running shellcheck
Checking file headers
Running flake8
Running terraform fmt
terraform fmt -diff -check=true -write=false .
terraform fmt -diff -check=true -write=false ./codelabs/simple
terraform fmt -diff -check=true -write=false ./examples/delete_default_gateway_routes
terraform fmt -diff -check=true -write=false ./examples/multi_vpc
terraform fmt -diff -check=true -write=false ./examples/secondary_ranges
terraform fmt -diff -check=true -write=false ./examples/simple_project
terraform fmt -diff -check=true -write=false ./examples/simple_project_with_regional_network
terraform fmt -diff -check=true -write=false ./examples/submodule_firewall
terraform fmt -diff -check=true -write=false ./examples/submodule_svpc_access
terraform fmt -diff -check=true -write=false ./modules/fabric-net-firewall
terraform fmt -diff -check=true -write=false ./modules/fabric-net-svpc-access
terraform fmt -diff -check=true -write=false ./test/fixtures/all_examples
terraform fmt -diff -check=true -write=false ./test/fixtures/delete_default_gateway_routes
terraform fmt -diff -check=true -write=false ./test/fixtures/multi_vpc
terraform fmt -diff -check=true -write=false ./test/fixtures/secondary_ranges
terraform fmt -diff -check=true -write=false ./test/fixtures/shared
terraform fmt -diff -check=true -write=false ./test/fixtures/simple_project
terraform fmt -diff -check=true -write=false ./test/fixtures/simple_project_with_regional_network
terraform fmt -diff -check=true -write=false ./test/fixtures/simulated_ci_environment
terraform fmt -diff -check=true -write=false ./test/fixtures/submodule_firewall
Running terraform validate
terraform_validate .
Success! The configuration is valid.

terraform_validate ./codelabs/simple
Success! The configuration is valid.

terraform_validate ./examples/delete_default_gateway_routes
Success! The configuration is valid.

terraform_validate ./examples/multi_vpc
Success! The configuration is valid.

terraform_validate ./examples/secondary_ranges
Success! The configuration is valid.

terraform_validate ./examples/simple_project
Success! The configuration is valid.

terraform_validate ./examples/simple_project_with_regional_network
Success! The configuration is valid.

terraform_validate ./examples/submodule_firewall
Success! The configuration is valid.

terraform_validate ./examples/submodule_svpc_access
Success! The configuration is valid.

terraform_validate ./modules/fabric-net-firewall
Success! The configuration is valid.

terraform_validate ./modules/fabric-net-svpc-access
Success! The configuration is valid.

terraform_validate ./test/fixtures/all_examples
Success! The configuration is valid.

terraform_validate ./test/fixtures/delete_default_gateway_routes
Success! The configuration is valid.

terraform_validate ./test/fixtures/multi_vpc
Success! The configuration is valid.

terraform_validate ./test/fixtures/secondary_ranges
Success! The configuration is valid.

terraform_validate ./test/fixtures/simple_project
Success! The configuration is valid.

terraform_validate ./test/fixtures/simple_project_with_regional_network
Success! The configuration is valid.

terraform_validate ./test/fixtures/simulated_ci_environment
Success! The configuration is valid.

terraform_validate ./test/fixtures/submodule_firewall
Success! The configuration is valid.
```

[terraform-provider-google]: https://github.com/terraform-providers/terraform-provider-google
