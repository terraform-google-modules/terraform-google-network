# Google Cloud Shared VPC Access Configuration

This module allows configuring service project access to a Shared VPC, created with the top-level network module. Two configuration modes for each service project are supported:

- VPC access, where service projects are granted IAM roles at the host project level, and can use any of the VPC subnets
- subnetwork access, where service projects are granted IAM roles at the subnet level, and can then only use specific subnets

Full details on service project configuration can be found in the Google Cloud documentation on [provisioning Shared VPC](https://cloud.google.com/vpc/docs/provisioning-shared-vpc), and on [setting up clusters with Shared VPC](https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-shared-vpc).

The resources created/managed by this module are:

- one `google_compute_shared_vpc_service_project` resource for each project where full VPC access is needed
- one `google_compute_subnetwork_iam_binding` for each subnetwork where individual subnetwork access is needed

## Usage

Basic usage of this module is as follows:

```hcl
module "net-shared-vpc-access" {
  source              = "terraform-google-modules/terraform-google-network/google//modules/fabric-net-svpc-access"
  host_project_id     = "my-host-project-id"
  service_project_num = 1
  service_project_ids = ["my-service-project-id"]
  host_subnets        = ["my-subnet-1", "my-subnet-2"]
  host_subnet_regions = ["europe-west1", "europe-west1]
  host_subnet_users   = [
    "serviceAccount:${module.project-foo.gce_service_account}",
    "serviceAccount:${module.project-spam.gce_service_account},group:spam@example.org"
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| host\_project\_id | Project id of the shared VPC host project. | string | n/a | yes |
| host\_subnet\_regions | List of subnet regions, one per subnet. | list | `<list>` | no |
| host\_subnet\_users | Map of comma-delimited IAM-style members, one per subnet. | map | `<map>` | no |
| host\_subnets | List of subnet names on which to grant access. | list | `<list>` | no |
| service\_project\_ids | Ids of the service projects that will be granted access to all subnetworks. | list | n/a | yes |
| service\_project\_num | Number of service projects that will be granted access to all subnetworks. | string | `"0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| service\_projects | Project ids of the services with access to all subnets. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
