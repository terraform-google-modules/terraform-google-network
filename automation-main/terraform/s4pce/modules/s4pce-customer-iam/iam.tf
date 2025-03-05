/*
  Description: Customer specific IAM resources; Creates iam policies, roles and users
  Comments:
    Policies
      s3_backups_readlist_policy
      s3_backups_write_policy
    Roles
      iam_role_customer_default
*/

##### Create S3 IAM Policies
resource "aws_iam_policy" "s3_backups_readlist_policy" {
  name        = "${module.base_layer_context.resource_prefix}-s3-backups-readlist-policy"
  description = "Allows reading the S3 backup bucket for ${module.base_layer_context.customer}"
  policy = templatefile("${var.ste_automation_path}/terraform/shared/modules/templates/iam/s3/generic-s3-readonly-policy.json", {
    s3_bucket_arn = var.s3_backups_bucket_arn
  })
}

resource "aws_iam_policy" "s3_backups_write_policy" {
  name        = "${module.base_layer_context.resource_prefix}-s3-backups-write-policy"
  description = "Allows writing to the S3 backup bucket for ${module.base_layer_context.customer}"
  policy = templatefile("${var.ste_automation_path}/terraform/shared/modules/templates/iam/s3/generic-s3-write-policy.json", {
    s3_bucket_arn = var.s3_backups_bucket_arn
  })
}


##### Create S3 IAM Roles
module "iam_role_customer_default" {
  source               = "../../../shared/modules/aws-iam-role"
  iam_role_name        = "${module.base_layer_context.resource_prefix}-default"
  iam_role_description = "Provides default access for ${module.base_layer_context.customer} instances"
  iam_policy_arn_list = concat([
    aws_iam_policy.s3_backups_readlist_policy.arn,
    aws_iam_policy.s3_backups_write_policy.arn,
    "arn:aws-us-gov:iam::aws:policy/CloudWatchAgentServerPolicy",
    "arn:aws-us-gov:iam::aws:policy/AmazonEC2ReadOnlyAccess",
    "arn:aws-us-gov:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ], var.iam_role_customer_default_additional_policy_arn)
  iam_instance_profile_name = "${module.base_layer_context.resource_prefix}-default"
  tag_managedby             = "ansible"
  build_user                = module.base_layer_context.build_user
  assume_role_policy        = file("${var.ste_automation_path}/terraform/shared/modules/templates/iam/trust/ec2-role-trust-policy.json")
}


output "iam_role_customer_default" { value = {
  id = module.iam_role_customer_default.id
} }
