aws-iam-group Example Root Module
============================

This is the root (aka orchestration, aka caller) module which terraform will be implemented from.  It is responsible for calling the aws-iam-group module and supplying the necessary variables through the 'terraform.tfvars' file to create iam groups.

Dependencies
------------

* Terraform 0.12
* AWS Administrator level privileges or privileges to manage VPC, EC2, EIPs and related services
* AWS S3 buckets to store state files
* aws-iam-group module


Testing Instructions
====================
1. Clone ns2-terraform repository
2. Change working directory to the example-root
```
cd ns2-terraform/modules/aws-iam-group/example-root/
```

3. Initialize with testing Backend
```
terraform init -backend-config=backend.tfvars.testing
```

4. Run Terraform, Create sample s3 bucket
```
terraform apply -var-file=terraform.tfvars.testing
```

5. Validate
6. Destroy Terraform, Delete sample s3 bucket
```
terraform destroy -var-file=terraform.tfvars.testing
```

Instructions
============
1. Clone ns2-terraform repository
2. Copy the example_root module to the appropriate place. Rename accordingly
```
cp -r ns2-terraform/modules/aws-iam-group/example_root ns2-terraform/environments/<ENVIRONMENT NAME>/aws-iam-group
```

3. In the root module folder, copy terraform.tfvars.template to terraform.tfvars and backend.tfvars.template to backend.tfvars
```
cp ns2-terraform/environments/<ENVIRONMENT NAME>/aws-iam-group/terraform.tfvars.template ns2-terraform/environments/<ENVIRONMENT NAME>/aws-iam-group/terraform.tfvars
cp ns2-terraform/environments/<ENVIRONMENT NAME>/aws-iam-group/backend.tfvars.template ns2-terraform/environments/<ENVIRONMENT NAME>/aws-iam-group/backend.tfvars
```

4. Navigate to new folder
```
cd ns2-terraform/environments/<ENVIRONMENT NAME>/aws-iam-group/
```

5. Open the `terraform.tfvars` file, uncomment and provide the correct values.
6. Open the `backend.tfvars` file and update with correct values
7. Open the `main.tf`
   * Validate the relative paths of `source` points back to ns2-terraform/modules/aws-iam-group correctly.
   * Use the provided examples to setup the calling modules to create individual iam groups.
8. Save locally and commit changes to git
9. ***Create merge request and receive approval before proceeding***
10. Initialize Terraform with specific backend location
```
terraform init -backend-config=backend.tfvars
```

11. Review Terraform plan
```
terraform plan
```

12. Apply Terraform changes and confirm with `yes`
```
terraform apply
```
