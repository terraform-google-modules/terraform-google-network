# Shared VPC with service projects

This simple example configures a shared VPC, and grants access to it to service projects.

The VPC has two subnets with no secondary ranges, service projects are configured as follows:

- the first service project is granted VPC-level access
- the second service project is granted subnet-level access to the second subnet
- the third service project is granted subnet-level access to the first and second subnet

Subnet-level access in this example is only granted to the default GCE service accounts for illustrative purposes. More realistic examples should grant access to other service accounts (possibly including the GKE robot service accounts as per [documentation](https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-shared-vpc)), and project users/groups that need to use the Shared VPC from other projects (eg to create VMs).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| host\_project\_id | Id of the host project where the shared VPC will be created. | string | n/a | yes |
| network\_name | Name of the shared VPC. | string | `"test-svpc"` | no |
| service\_project\_id\_full\_access | Id of the service project that will get VPC-level access. | string | n/a | yes |
| service\_project\_number\_first\_subnet | Project number to derive service accounts with access to first subnet. | string | n/a | yes |
| service\_project\_number\_multi\_subnet | Project number to derive service accounts with access to first and second subnet. | string | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
