# terraform-hostname-endpoint-scrapping Example Root Module
This will deploy an example usage of the module to create the following:
* Text Document Output

## Dependencies
* See [tf-docs](./tf-docs.md) for terraform dependencies

## Testing Instructions
1. Clone terraform repository
2. Change working directory to the example-root
3. Initialize with testing Backend
4. Run Terraform, Create example bastions
5. Validate
6. Destroy Terraform, Delete example bastions

## Detailed Testing Steps
```bash
cd example-root
terraform init -backend-config=testing.backend.tfvars
terraform apply -var-file=testing.terraform.tfvars
terraform destroy -var-file=testing.terraform.tfvars
```
