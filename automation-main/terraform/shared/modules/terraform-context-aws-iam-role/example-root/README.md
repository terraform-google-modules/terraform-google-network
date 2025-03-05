terraform-context-aws-iam-role Example Root Module
==================================================

This is the root (aka orchestration, aka caller) module which terraform will be implemented from.  It is responsible for calling the terraform-context-aws-iam-role module and supplying the necessary variables through the 'terraform.tfvars' file to create iam role.

Dependencies
------------
* Terraform 0.14
* AWS privileges to create and manage IAM roles
* AWS S3 buckets to store state
* terraform-context-aws-iam-role module

Testing Instructions
====================
1. Clone ns2-terraform repository
2. Change working directory to the example-root
```
cd ns2-terraform/modules/terraform-context-aws-iam-role/example-root/
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

Instructions for module usage
=============================
1. Clone ns2-terraform repository
2. From your root module, source the the terraform-context-aws-iam-role module.
3. Supply the required providers, aws, from your root module.
3. Reference example-root/iam.tf for a list of required and optional variables.
4. Review Terraform plan
```
terraform plan
```

5. Apply Terraform changes and confirm with `yes`
 ```
 terraform apply
 ```
