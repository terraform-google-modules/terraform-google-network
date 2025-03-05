/*
  Description: Backend settings required to setup IBP Customer VPC; Declaration of providers, local variables, and backend remote state locations
  Comments: The contents of this file should not be modified by Operators.
*/

##### AWS Account Information
data "aws_caller_identity" "current" {}

##### Module Dependency
resource "null_resource" "module_dependency" {
  triggers = {
    dependency = var.module_dependency
  }
}
