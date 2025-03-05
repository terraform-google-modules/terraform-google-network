/*
  Description: Handles Gardener_shoot-related IAM roles
  Comments:
    * iam_role_gardener_shoot_worker_default
*/

###### Roles
module "iam_role_gardener_shoot_worker_default" {
  source               = "../../../EXAMPLE_SOURCE/terraform/shared/modules/aws-iam-role"
  iam_role_name        = "${local.base_resource_prefix}-gardener-shoot-worker-default"
  iam_role_description = "Default IAM Profile for Gardener_shoot Worker Nodes"
  iam_policy_arn_list = [
    "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonEC2ReadOnlyAccess",
    "arn:${data.aws_partition.current.partition}:iam::aws:policy/CloudWatchAgentServerPolicy",
    "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs",
    "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonSSMManagedInstanceCore",
    aws_iam_policy.gardener_shoot_worker_node_default.arn,
    aws_iam_policy.gardener_shoot_worker_node_efs_access.arn # NOTE: Experimental
  ]
  iam_instance_profile_name = "${local.base_resource_prefix}-gardener-shoot-worker-default"
  tag_managedby             = "terraform"
  build_user                = local.layer_tags.BuildUser
  assume_role_policy        = file("../../../../templates/iam/trust/ec2-role-trust-policy.json")
  module_dependency         = join(",", [])
}

##### Outputs
output "iam_role_gardener_shoot_worker_default" {
  value = module.iam_role_gardener_shoot_worker_default
}
