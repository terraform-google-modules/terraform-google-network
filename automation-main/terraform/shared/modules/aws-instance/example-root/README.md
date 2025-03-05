aws-instance Example Root Module
================================

This is the root (aka orchestration, aka caller) module which terraform will be implemented from. It will create a test environment and then create 2 instances. This module has both mandatory and optional options. Please refer to the main.tf/Instance Examples for a full description on how to module options.

Dependencies
------------

* Terraform 0.12
* AWS Administrator level privileges or privileges to manage VPC, EC2, EIPs and related services
* AWS S3 buckets to store the state file
* AWS DynamoDB for state file lock
* aws-instance Module

Testing Instructions
====================
1. Clone ns2-terraform repository
2. Change working directory to the example-root
```
cd ns2-terraform/modules/aws-instance/example-root/
```

3. Initialize with testing Backend
```
terraform init -backend-config=backend.tfvars.testing
```

4. Run Terraform, Create sample iam role
```
terraform apply -var-file=terraform.tfvars.testing
```

5. Validate
6. Destroy Terraform, Delete sample iam role
```
terraform destroy -var-file=terraform.tfvars.testing
```

Instructions
============
1. Clone ns2-terraform repository
2. Copy the example_root module to the appropriate place. Rename accordingling
```
cp -r ns2-terraform/modules/aws-instance/example_root ns2-terraform/environments/<ENVIRONMENT NAME>/aws-instance
```

3. In the root module folder, rename terraform.tfvars.template and backend.tfvars.template to terraform.tfvars and backend.tfvars
```
mv ns2-terraform/environments/<ENVIRONMENT NAME>/aws-instance/terraform.tfvars.template ns2-terraform/environments/<ENVIRONMENT NAME>/aws-instance/terraform.tfvars
mv ns2-terraform/environments/<ENVIRONMENT NAME>/aws-instance/backend.tfvars.template ns2-terraform/environments/<ENVIRONMENT NAME>/aws-instance/backend.tfvars
```
4. In the new folder:
   *  Open `dependencies.tf` and update the s3 bucket, dynamodb table, and key values to correct values.
   *  Open the `terraform.tfvars` file and update with correct values
   *  Open the `backend.tfvars` file and update with correct values
   *  Open the main.tf
      * Validate the relative paths of `source` points back to ns2-terraform/modules/aws-instance correctly.
      * Use the provided examples to setup the calling modules to start an instance.  Each uniquely configured type of instance must be called with it's own module.
5. Save locally and commit changes to git
6. ***Create merge request and receive approval before proceeding***
6. Navigate to the newly created root module directory
```
cd ns2-terraform/environments/<ENVIRONMENT NAME>/aws-instance
```

7. Initialize Terraform with specific backend location
```
terraform init -backend-config=backend.tfvars
```

8. Review Terraform plan
```
terraform plan
```

9. Apply Terraform changes and confirm with `yes`
 ```
 terraform apply
 ```
