/*
  Description: Customer specific IAM resources; Creates iam policies, roles and users
  Comments:
    TODO: need to refactor this into an IBP S3 module.
    Policies
      ibp_s3_backups_readlist_policy
      ibp_s3_binaries_readlist_policy
      ibp_s3_backups_write_policy
    Roles
      iam_role_customer_default
      iam_role_customer_ibpapp
      iam_role_customer_database
*/

##### Create S3 IAM Policies
resource "aws_iam_policy" "ibp_s3_backups_readlist_policy" {
  name        = "${module.base_layer_context.resource_prefix}-s3-backups-readlist-policy"
  description = "Allows reading the S3 backup bucket for ${module.base_layer_context.customer}"
  policy = templatefile("../templates/iam/s3/generic-s3-readonly-policy.json", {
    s3_bucket_arn = local.layer_00_outputs.infrastructure.s3_bucket_backups_arn
  })
}

resource "aws_iam_policy" "ibp_s3_binaries_readlist_policy" {
  name        = "${module.base_layer_context.resource_prefix}-s3-binaries-read-policy"
  description = "Allows reading the S3 binaries bucket for ${module.base_layer_context.customer}"
  policy = templatefile("../templates/iam/s3/generic-s3-readonly-policy.json", {
    s3_bucket_arn = local.layer_00_outputs.infrastructure.s3_bucket_binaries_arn
  })
}

resource "aws_iam_policy" "ibp_s3_backups_write_policy" {
  name        = "${module.base_layer_context.resource_prefix}-s3-backups-write-policy"
  description = "Allows writing to the S3 backup bucket for ${module.base_layer_context.customer}"
  policy = templatefile("../templates/iam/s3/generic-s3-write-policy.json", {
    s3_bucket_arn = local.layer_00_outputs.infrastructure.s3_bucket_backups_arn
  })
}


##### Create S3 IAM Roles
module "iam_role_customer_default" {
  source               = "EXAMPLE_SOURCE/terraform/shared/modules/aws-iam-role"
  iam_role_name        = "${module.base_layer_context.resource_prefix}-default"
  iam_role_description = "Provides default access for ${module.base_layer_context.customer} instances"
  iam_policy_arn_list = [
    aws_iam_policy.ibp_s3_backups_readlist_policy.arn,
    aws_iam_policy.ibp_s3_binaries_readlist_policy.arn,
    local.management_layer_01_outputs.iam_policy_ibp_artifacts_read_arn,
    local.management_layer_01_outputs.iam_policy_cpids_artifacts_read_arn,
    "arn:${module.base_layer_context.partition}:iam::aws:policy/CloudWatchAgentServerPolicy",
    "arn:${module.base_layer_context.partition}:iam::aws:policy/AmazonEC2ReadOnlyAccess",
    local.management_layer_01_outputs.iam_policy_ec2_ebs_arn,
    "arn:${module.base_layer_context.partition}:iam::aws:policy/AmazonSSMManagedInstanceCore",
    local.management_layer_01_outputs.iam_policy_ssm_s3_patching_arn
  ]
  iam_instance_profile_name = "${module.base_layer_context.resource_prefix}-default"
  tag_managedby             = "ansible"
  build_user                = module.base_layer_context.build_user
  assume_role_policy        = file("../templates/iam/trust/ec2-role-trust-policy.json")
}

module "iam_role_customer_ibpapp" {
  source               = "EXAMPLE_SOURCE/terraform/shared/modules/aws-iam-role"
  iam_role_name        = "${module.base_layer_context.resource_prefix}-ibp-app"
  iam_role_description = "In addition to default permissions. Also allows interaction with Private Certificate Authority for ${module.base_layer_context.customer} instances"
  iam_policy_arn_list = [
    aws_iam_policy.ibp_s3_backups_readlist_policy.arn,
    aws_iam_policy.ibp_s3_binaries_readlist_policy.arn,
    local.management_layer_01_outputs.iam_policy_ibp_artifacts_read_arn,
    local.management_layer_01_outputs.iam_policy_cpids_artifacts_read_arn,
    "arn:${module.base_layer_context.partition}:iam::aws:policy/CloudWatchAgentServerPolicy",
    "arn:${module.base_layer_context.partition}:iam::aws:policy/AmazonEC2ReadOnlyAccess",
    local.management_layer_01_outputs.iam_policy_acm_pca_arn,
    local.management_layer_01_outputs.iam_policy_ec2_ebs_arn,
    "arn:${module.base_layer_context.partition}:iam::aws:policy/AmazonSSMManagedInstanceCore",
    local.management_layer_01_outputs.iam_policy_ssm_s3_patching_arn
  ]
  iam_instance_profile_name = "${module.base_layer_context.resource_prefix}-ibp-app"
  tag_managedby             = "ansible"
  build_user                = module.base_layer_context.build_user
  assume_role_policy        = file("../templates/iam/trust/ec2-role-trust-policy.json")
}

module "iam_role_customer_database" {
  source               = "EXAMPLE_SOURCE/terraform/shared/modules/aws-iam-role"
  iam_role_name        = "${module.base_layer_context.resource_prefix}-ibp-hana"
  iam_role_description = "In addition to default permissions. Also allows writing to the ${module.base_layer_context.customer} s3 backup bucket as well as interact with the Private Certificate Authority"
  iam_policy_arn_list = [
    aws_iam_policy.ibp_s3_backups_readlist_policy.arn,
    aws_iam_policy.ibp_s3_binaries_readlist_policy.arn,
    aws_iam_policy.ibp_s3_backups_write_policy.arn,
    local.management_layer_01_outputs.iam_policy_ibp_artifacts_read_arn,
    "arn:${module.base_layer_context.partition}:iam::aws:policy/CloudWatchAgentServerPolicy",
    "arn:${module.base_layer_context.partition}:iam::aws:policy/AmazonEC2ReadOnlyAccess",
    local.management_layer_01_outputs.iam_policy_acm_pca_arn,
    local.management_layer_01_outputs.iam_policy_ec2_ebs_arn,
    "arn:${module.base_layer_context.partition}:iam::aws:policy/AmazonSSMManagedInstanceCore",
    local.management_layer_01_outputs.iam_policy_ssm_s3_patching_arn
  ]
  iam_instance_profile_name = "${module.base_layer_context.resource_prefix}-ibp-hana"
  tag_managedby             = "ansible"
  build_user                = module.base_layer_context.build_user
  assume_role_policy        = file("../templates/iam/trust/ec2-role-trust-policy.json")
}
