# aws-endpoint-services-multiport Example Root Module

This will deploy an example usage of the module to create the following:
* Endpoint Private Link Service and Endpoint (Instance) with multiple ports
* Endpoint Private Link Service and Endpoint (Private IP) with multiple ports


This module is an implementation of the following AWS article.  Please see the article for more details:
  https://aws.amazon.com/blogs/networking-and-content-delivery/how-to-securely-publish-internet-applications-at-scale-using-application-load-balancer-and-aws-privatelink/

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
