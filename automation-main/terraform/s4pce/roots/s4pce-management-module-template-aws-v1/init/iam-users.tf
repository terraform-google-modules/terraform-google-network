/*
  Description: IAM Users
  Comments:
*/

##### Users
module "iamuser_svc_cloudwatch_agent" {
  source     = "EXAMPLE_SOURCE/terraform/shared/modules/aws-iam-user"
  aws_region = module.base_layer_context.region
  build_user = module.base_layer_context.build_user
  aws-iam-user-object = {
    name = "EXAMPLE_TESTING_UNIQUE_svc-cloudwatch-agent"
    policy_list = [
      "arn:${module.base_layer_context.partition}:iam::aws:policy/CloudWatchAgentServerPolicy",
    ],
    group_list  = ["ServiceAccounts"],
    tag_company = "SCS"
  }
  module_dependency = join(",", [])
}

##### End Users
