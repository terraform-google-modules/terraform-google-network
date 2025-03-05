# terraform-aws-dns-steering Example Root Module

This will deploy an example usage of the module to create the following:
* Deploy a top-level Route53 zone (public zone)
* Deploy a customer-specific Route53 zone (sub-zone from the lop-level)
* Deploy a "zone-cut" NS record in the top-level zone
* Deploy 1+ customer endpoint-specific DNS record

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
