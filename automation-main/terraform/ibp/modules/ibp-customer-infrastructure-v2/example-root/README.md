# ibp-customer-infrastructure-v2 Example Root Module

This is the root (aka orchestration, aka caller) module which terraform will be implemented from.  It is responsible for calling the ibp-customer-infrastructure  module and supplying the necessary variables to deploy the AWS infrastructure for an IBP Customer

## Dependencies
* See [tf-docs](./tf-docs.md) for terraform dependencies

## Testing Instructions
1. Clone terraform repository
2. Change working directory to the example-root
3. Initialize with testing Backend
4. Run Terraform
5. Validate
6. Destroy Terraform

## Detailed Testing Steps
```bash
cd example-root
terraform init -backend-config=testing.backend.tfvars
terraform apply -var-file=testing.terraform.tfvars
terraform destroy -var-file=testing.terraform.tfvars
```
