# terraform-aws-pce-customer-interface Example Root Module

This module will
1. Setup a new S3 Bucket with potential replication with an external S3 Bucket
2. Create a datasync to push replication from the new S3 Bucket to the EFS every 15 minutes(default)

## Dependencies
* See layer-00 [tf-docs](./layer-00/tf-docs.md) for terraform dependencies
* See layer-01 [tf-docs](./layer-01/tf-docs.md) for terraform dependencies

## Testing Instructions
1. Clone terraform repository
2. Change working directory to the example-root
3. Initialize with testing Backend
4. Run Terraform
5. Validate
6. Destroy Terraform

## Detailed Testing Steps
```bash
cd ./layer-00
terraform init -backend-config=testing.backend.tfvars
terraform apply -var-file=testing.terraform.tfvars
cd ../layer-01
terraform init -backend-config=testing.backend.tfvars
terraform apply -var-file=testing.terraform.tfvars

cd ../layer-01
terraform destroy -var-file=testing.terraform.tfvars
cd ../layer-00
terraform destroy -var-file=testing.terraform.tfvars
```
