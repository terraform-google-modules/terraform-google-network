/*
  Description: Creates Gardener-related IAM policies
  Comments:
    * gardener_shoot_worker_node_default_policy
    * gardener_shoot_worker_node_efs_access_policy
*/

##### Policies
resource "aws_iam_policy" "gardener_shoot_worker_node_default" {
  name        = "${local.base_resource_prefix}-gardener-shoot-worker-default-policy"
  description = "Default Gardener worker node policy with basic EC2 and ECR access"
  policy = templatefile("./templates/gardener-shoot-worker-default.json", {
  })
}

resource "aws_iam_policy" "gardener_shoot_worker_node_efs_access" {
  name        = "${local.base_resource_prefix}-gardener-shoot-worker-efs-access-policy"
  description = "Gardener worker node policy allowing access to EFS and EFS-related resources"
  policy = templatefile("./templates/gardener-shoot-worker-efs-access.json", {
  })
}
