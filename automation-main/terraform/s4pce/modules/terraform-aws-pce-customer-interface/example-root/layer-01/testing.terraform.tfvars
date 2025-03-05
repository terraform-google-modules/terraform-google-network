/*
  Description: Terraform variables for module run; The variables in this file are specifically for testing executions of the terraform module
  Comments:
    - Run the terraform module with this command: terraform apply -var-file=terraform.tfvars.testing
    - Destroy the terraform module with this command: terraform destroy -var-file=terraform.tfvars.testing
*/


### AWS Variables
aws_region = "us-gov-west-1"

### Uncomment and populate these values before running terraform
// build_user = ""

### Testing Variables
bucket = "ibp-development-terraform"
key    = "test-user/terraform-aws-pce-customer-interface/layer00.tfstate"
