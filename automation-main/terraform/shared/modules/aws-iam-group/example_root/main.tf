/*
  Description: Terraform main file
  Comments:
    - All customizations should be made through the terraform.tfvars file.  See terraform.tfvars.template file for full details
*/

module "iam_testgroup1" {
  source            = "../../aws-iam-group" #This should point back to the original module.
  aws_region        = var.aws_region
  iam_group_object  = var.iam_group_object
  module_dependency = join(",", [])
  # module_dependency = join(",",module.aws-iam-group.groups)     # Example of how to make a dependency.  Module_dependecy should be passed a string
}
