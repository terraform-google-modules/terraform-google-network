/*
  Description: This shows how to use the aws-instance module with the null context module.
  Comments:
    - Each instance must be specified as seperate module calls in the root module
    - The first calling module demonstrates basic null context usage.
    - The second calling module demonstrates how null context can be combined with legacy tags.
    - Commented out blocks without cluttering line-by-line comments provided for convenience
*/

#####################
# Instance Examples #
#####################

##### The following Example shows how to use aws-instance with a null context module.
module "context_instance_example" {
  source        = "../../../modules/terraform-null-context/modules/legacy"
  context       = module.base_context.context
  custom_values = module.base_context.custom_values
  additional_tags = { # Except for `Name`. These tags WILL OVERWRITE anything specified with legacy tags
    Name         = "test"
    PatchGroup   = "My PatchGroup"
    MyCustomTag1 = "My Custom Tag 1"
    MyCustomTag2 = "My Custom Tag 2"
    Description  = "Example using Null-Context module"
    ProductName  = "Product"
  }
}
module "EXAMPLE_O3_WITH_NULL_CONTEXT" {
  source              = "../../../modules/aws-instance"
  search_ami_name     = "Golden-NS2-RHEL-7.6-Base-V*"
  search_ami_owner_id = "723712175675"
  ec2_key             = aws_key_pair.key_pair.key_name
  security_group_ids = [
    aws_default_security_group.test_vpc.id
  ]
  subnet_id            = aws_subnet.test_vpc.id
  iam_instance_profile = aws_iam_role.iam_role.name
  aws_region           = var.aws_region
  context              = module.context_instance_example.context # Tags are now derived from the context here.
  module_dependency    = join(",", [])
}

##### The following Example shows how to use aws-instance and legacy tags along with a more general null context module.
module "context_instance_generic" {
  source        = "../../../modules/terraform-null-context/modules/legacy"
  context       = module.base_context.context
  custom_values = module.base_context.custom_values
  additional_tags = {
    PatchGroup   = "My PatchGroup"
    MyCustomTag1 = "My Custom Tag 1"
    MyCustomTag2 = "My Custom Tag 2"
  }
}
module "EXAMPLE_O4_WITH_NULL_CONTEXT_AND_LEGACY_TAGS" {
  source              = "../../../modules/aws-instance"
  search_ami_name     = "Golden-NS2-RHEL-7.6-Base-V*"
  search_ami_owner_id = "723712175675"
  ec2_key             = aws_key_pair.key_pair.key_name
  security_group_ids = [
    aws_default_security_group.test_vpc.id
  ]
  subnet_id            = aws_subnet.test_vpc.id
  iam_instance_profile = aws_iam_role.iam_role.name
  aws_region           = var.aws_region
  context              = module.context_instance_generic.context      # Tags are now derived from the context here.
  tag_name             = "testing"                                    # This will overwrite the name provided from context
  tag_description      = "Example using Null-Context and legacy tags" # This legacy tag can be used in combination with context tags
  tag_productname      = "product"                                    # This legacy tag can be used in combination with context tags
  module_dependency    = join(",", [])                                # Used by root modules to create a dependency for order of operation purposes
}
