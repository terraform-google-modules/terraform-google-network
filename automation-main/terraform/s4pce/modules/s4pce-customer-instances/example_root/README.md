# s4pce-customer-infrastructure Example Root Module

This will deploy an example usage of the module to create the following:

* Base Infrastructure for S4PCE
* IAM for S4PCE
* Instances for S4PCE

## Dependencies

* See [tf-docs](./tf-docs.md) for terraform dependencies

## Testing Instructions

1. Clone terraform repository
1. Change working directory to the example-root
1. Add a SSH public to `module-test.tf`
1. Initialize with testing Backend
1. Run targeted terraform to create the `aws_route53_zone`
1. Run Terraform, Create example bastions
1. Validate
1. Destroy Terraform, Delete example bastions

## Detailed Testing Steps

```bash
cd example-root

code --goto "module-test.tf:17"

terraform init -backend-config=testing.backend.tfvars
terraform apply -var-file=testing.terraform.tfvars -target aws_route53_zone.test
terraform apply -var-file=testing.terraform.tfvars
terraform destroy -var-file=testing.terraform.tfvars
```
