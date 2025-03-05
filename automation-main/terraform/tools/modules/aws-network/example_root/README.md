# terraform-aws-network Example Root Module
This will deploy an example usage of the module to create the following:
* Deploy up to 5 cidr networks.
* Dynamically deploy subnets
* Optionally deploy gateways. One per AZ
* Optionally create and associate route tables. One per AZ
* Create basic ingress, egress security groups.
* Optionally create basic security rules
* Optionally associated dhcpoption

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
