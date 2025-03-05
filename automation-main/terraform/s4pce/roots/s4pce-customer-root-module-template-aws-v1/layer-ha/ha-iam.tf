# /*
#   Description: add pacemaker(HA) templates to EC2 profile/role
#   Layer: 02
#   Comments: N/A
#   */


resource "aws_iam_policy" "pacemaker_dataprovider" {
  name        = "${module.base_layer_context.resource_prefix}-pacemaker-dataprovider-policy"
  description = "pacemaker-dataprovider-policy for${module.base_layer_context.customer}"
  policy = templatefile("${path.module}/templates/DataProvider.json", {
    s3_bucket_arn = local.layer_00_outputs.infrastructure.s3_backups.bucket_arn
  })
}

resource "aws_iam_policy" "pacemaker_overlayipagent" {
  name        = "${module.base_layer_context.resource_prefix}-pacemaker-overlayipagent-policy"
  description = "pacemaker-overlayipagent-policy for${module.base_layer_context.customer}"
  policy = templatefile("${path.module}/templates/OverlayIPAgent.json", {
    rt_arns = local.rt_arns
  })
}

resource "aws_iam_policy" "pacemaker_stonith" {
  name        = "${module.base_layer_context.resource_prefix}-pacemaker-stonith-policy"
  description = "pacemaker-stonith-policy for ${module.base_layer_context.customer}"
  policy = templatefile("${path.module}/templates/STONITH.json", {
    db_arns = local.instance_arn_list
  })
}

resource "aws_iam_role_policy_attachment" "pacemaker_dataprovider_attach" {
  role       = "${module.base_layer_context.resource_prefix}-default"
  policy_arn = aws_iam_policy.pacemaker_dataprovider.arn
}

resource "aws_iam_role_policy_attachment" "pacemaker_overlayipagent_attach" {
  role       = "${module.base_layer_context.resource_prefix}-default"
  policy_arn = aws_iam_policy.pacemaker_overlayipagent.arn
}

resource "aws_iam_role_policy_attachment" "pacemaker_stonith_attach" {
  role       = "${module.base_layer_context.resource_prefix}-default"
  policy_arn = aws_iam_policy.pacemaker_stonith.arn
}
