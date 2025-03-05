/*
  Description: Create IAM users, Attach policies, and add group membership; This will call the aws-iam-user module
  Comments:
    - All customizations should be made through the terraform.tfvars file.  See terraform.tfvars.template file for full details
*/

module "iam_testuser1" {
  source = "../../aws-iam-user" #This should point back to the original module.

  aws_region          = var.aws_region
  build_user          = var.build_user
  aws-iam-user-object = var.aws-iam-user-object
  module_dependency   = join(",", [])
  # module_dependency = join(",",module.aws-iam-user.users)       # Example of how to make a dependency.  Module_dependecy should be passed a string
}

resource "aws_iam_group" "iam_group" {
  name = "Test-Group"
}
