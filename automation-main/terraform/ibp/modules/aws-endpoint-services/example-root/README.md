# aws-endpoint-services Example Root Module

This is the root (aka orchestration, aka caller) module which terraform will be implemented from.
It is responsible for calling the aws-endpoint-services module and supplying the necessary variables
through the 'terraform.tfvars' file to create and demonstrate an example implementation of the
privatelink endpoint services and endpoints.

This module is an implementation of the following AWS article.  Please see the article for more details:
  https://aws.amazon.com/blogs/networking-and-content-delivery/how-to-securely-publish-internet-applications-at-scale-using-application-load-balancer-and-aws-privatelink/

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
