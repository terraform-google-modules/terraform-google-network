/*
  Description: Create IAM users, Attach policies, and add group membership; This will call the aws-iam-user module
  Comments:
    - All customizations should be made through the terraform.tfvars file.  See terraform.tfvars.template file for full details
*/

module "iam_testrole1" {
  source = "../../aws-iam-role" #This should point back to the original module.

  iam_role_name        = "testrole1"          # Name for the IAM Role
  iam_role_description = "this is test role1" # Description of the IAM Role
  iam_policy_arn_list = [                     # List of Policy ARNs to attach to the IAM Role
    "arn:aws-us-gov:iam::aws:policy/TranslateReadOnly"
  ]
  iam_instance_profile_name = "testrole1_profile" # Instance Profile to create and associate with the IAM Role
  tag_managedby             = "testing_Ansible"   # Who will manage the Role after provisioning

  build_user         = var.build_user                                                              # Employee ID of the Running Terraform
  assume_role_policy = file("${path.module}/../../templates/iam/trust/ec2-role-trust-policy.json") # Trust Policy attached to the role
  module_dependency  = join(",", [])
  # module_dependency = join(",",module.aws-iam-user.users)       # Example of how to make a dependency.  Module_dependecy should be passed a string
}

module "iam_testrole2" {
  source = "../../aws-iam-role" #This should point back to the original module.

  iam_role_name        = "testrole2"
  iam_role_description = "this is test role2"
  iam_policy_arn_list = [
    "arn:aws-us-gov:iam::aws:policy/TranslateReadOnly",
    "arn:aws-us-gov:iam::aws:policy/AmazonEC2ReadOnlyAccess"
  ]
  iam_instance_profile_name = ""
  tag_managedby             = "testing_Other"

  build_user         = var.build_user
  assume_role_policy = file("${path.module}/../../templates/iam/trust/ec2-role-trust-policy.json")
  module_dependency  = join(",", [])
  # module_dependency = join(",",module.aws-iam-user.users)       # Example of how to make a dependency.  Module_dependecy should be passed a string
}
