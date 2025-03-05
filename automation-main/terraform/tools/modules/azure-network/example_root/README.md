# azure-network Example Root Module
This will deploy an example usage of the module to create the following:

* Creates a Customer Resource Group
* Deploy 1 Virtual Network in the Resource Group
* Optional Change the DNS Servers
* Dynamically deploy subnets
* Automatically create storage service endpoint
* Optionally deploy zonal gateways. One per AZ and associated to non-edge subnets
* Optionally create route tables.  One per AZ, one for nozone edge
* Optionally associate route route tables
* Create basic ingress, egress security groups.
* Optionally create basic security rules
* Optionally associated dns (dhcpoption)
* Pass in a map variable to be used for tagging.

## Dependencies
* See [tf-docs](./tf-docs.md) for terraform dependencies

## Testing Instructions
1. Clone terraform repository
2. Change working directory to the example-root
3. Initialize with testing Backend
4. Run Terraform, Create example network load balancers, endpoint services, and endnpoints
5. Validate
6. Destroy Terraform, Delete example network load balancers, endpoint services, and endnpoints

## Detailed Testing Steps
```bash
cd example-root
terraform init -backend-config=testing.backend.tfvars
terraform apply -var-file=testing.terraform.tfvars
terraform destroy -var-file=testing.terraform.tfvars
```
