aws-ssm-patch-group-rhel-security Example Root Module
=====================================================

This is the root (aka orchestration, aka caller) module which terraform will be implemented from.  It is responsible for calling the aws-ssm-patch-group-rhel-security module.  Unlike other template modules, additional values must be specified in the module call outside of the tfvars.

Dependencies
------------

* Terraform 0.12
* AWS Administrator level privileges or privileges to manage VPC, EC2, EIPs and related services
* AWS S3 buckets to store the state file
* AWS DynamoDB for state file lock
* aws-ssm-patch-group-rhel-security Module

Testing Instructions
====================
1. Clone ns2-terraform repository
2. Change working directory to the example-root
```
cd ns2-terraform/modules/aws-ssm-patch-group-rhel-security/example-root/
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
cp -r ns2-terraform/modules/aws-ssm-patch-group-rhel-security/example_root ns2-terraform/environments/<ENVIRONMENT NAME>
```

3. In the root module folder, copy terraform.tfvars.template and backend.tfvars.template to terraform.tfvars and backend.tfvars
```
cp ns2-terraform/environments/<ENVIRONMENT NAME>/terraform.tfvars.template ns2-terraform/environments/<ENVIRONMENT NAME>/terraform.tfvars
cp ns2-terraform/environments/<ENVIRONMENT NAME>/backend.tfvars.template ns2-terraform/environments/<ENVIRONMENT NAME>/backend.tfvars
```

4. Navigate to new folder
```
cd ns2-terraform/environments/<ENVIRONMENT NAME>
```

5. Open the `terraform.tfvars` file,
   * uncomment and provide the REQUIRED values.
   * As desired, uncomment and provide values for OPTIONAL values
6. Open the `backend.tfvars` file and update with correct values
7. Open the `main.tf`
   * Validate the relative paths of `source` points back to ns2-terraform/modules/aws-ssm-patch-group-rhel-all correctly.
   * Use the provided examples to setup the calling modules to create individual s3buckets.
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
