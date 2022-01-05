# Shared VPC network

This example:

* Enables Shared VPC on a host project

* Attaches a service project

* In the host project's shared subnet, creates the following service project
  resources:

  * Reserved internal IP address. The IP address can come from the range of
    available addresses in the shared subnet, or you can specify an address.
  * VM instance that uses the reserved IP address and has an interface in
    the shared subnetwork.
  * VM instance that uses an ephemeral IP address and has an interface in
    the shared subnetwork.
  * VM instance template that creates an interface in
    the shared subnetwork.
  * Forwarding rule in the shared VPC network and subnetwork, along with
    a backend service and a health check.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project | The host project ID | `any` | n/a | yes |
| service\_project | The service project ID | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ip\_address | The internal IP address |
| ip\_address\_name | The name of the internal IP |
| project | Host project ID |
| subnet | Name of the host subnet |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
