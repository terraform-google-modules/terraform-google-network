/*
  Description: Handles AWS account IAM policies
  Comments:
    * ec2_ebs_policy
    * bastion_policy
    * acm_pca_policy
    * log_collection_aws_policy
    * s3_management_backup_readlist_policy
    * s3_management_backup_write_policy
    * ssm_s3_patching_policy
    * ssm_ami_creation_policy
    * iam_passrole_policy
    * sns_topic_policy
*/

##### Policies
resource "aws_iam_policy" "ec2_ebs_policy" {
  name        = "${module.base_layer_context.resource_prefix}-ec2-ebs-policy"
  description = "Allows for EBS volume creation and resizes"
  policy = templatefile("../templates/iam/ec2/generic-ec2-ebs-policy.json", {
  })
}

resource "aws_iam_policy" "bastion_policy" {
  name        = "${module.base_layer_context.resource_prefix}-bastion-policy"
  description = "Allows for EC2 and AMI interaction for Bastion hosts"
  policy = templatefile("../templates/iam/ec2/generic-ec2-bastion-policy.json", {
    partition  = module.base_layer_context.partition,
    aws_region = module.base_layer_context.region,
    account_id = data.aws_caller_identity.current.account_id
  })
}

resource "aws_iam_policy" "acm_pca_policy" {
  name        = "${module.base_layer_context.resource_prefix}-acm-private-ca-policy"
  description = "Allows certificate requests to be made programmatically from EC2 instances to AWS Certificate Manager's Private Certificate Authority"
  policy = templatefile("../templates/iam/ec2/generic-ec2-pca-acm-policy.json", {
    acm_pca_arn = [
      var.acm_pca_arn
    ]
  })
}

resource "aws_iam_policy" "log_collection_aws_policy" {
  name        = "${module.base_layer_context.resource_prefix}-aws-policy"
  description = "Allows access to AWS EC2 and Inspector data to support external log aggregation efforts"
  policy = templatefile("../templates/iam/splunk/generic-aws-read-policy.json", {
  })
}

resource "aws_iam_policy" "s3_management_backup_readlist_policy" {
  name        = "${module.base_layer_context.resource_prefix}-management-backup-s3-read-policy"
  description = "Allows reading the S3 management backup bucket"
  policy = templatefile("../templates/iam/s3/generic-s3-readonly-policy.json", {
    s3_bucket_arn = module.s3_management_backups.bucket_arn
  })
}

resource "aws_iam_policy" "s3_management_backup_write_policy" {
  name        = "${module.base_layer_context.resource_prefix}-management-backup-s3-write-policy"
  description = "Allows writing to the S3 management backup bucket"
  policy = templatefile("../templates/iam/s3/generic-s3-write-policy.json", {
    s3_bucket_arn = module.s3_management_backups.bucket_arn
  })
}

resource "aws_iam_policy" "ssm_s3_patching_policy" {
  name        = "${module.base_layer_context.resource_prefix}-ssm-s3-patching-policy"
  description = "Allows resources to access S3 bucket required for operation of SSM."
  policy = templatefile("../templates/iam/s3/generic-s3-ssm-policy.json", {
    s3_bucket_arn = module.s3_ssm_patching.bucket_arn
  })
}

resource "aws_iam_policy" "ssm_ami_creation_policy" {
  name        = "${module.base_layer_context.resource_prefix}-ssm-service-ami-creation-policy"
  description = "Allows AWS SSM permissions to create online AMI backups of EC2 instances."
  policy = templatefile("../templates/iam/ssm/generic-ssm-ec2-ami-policy.json", {
    partition = module.base_layer_context.partition
  })
}

resource "aws_iam_policy" "iam_passrole_policy" {
  name        = "${module.base_layer_context.resource_prefix}-iam-passrole-policy"
  description = "Allows passing an IAM role."
  policy = templatefile("../templates/iam/iam/generic-iam-passrole-policy.json", {
    iam_role_arn = [
      "arn:${module.base_layer_context.partition}:iam:::role/iam_role_bastion"
    ]
  })
}

resource "aws_iam_policy" "sns_topic_policy" {
  name        = "${module.base_layer_context.resource_prefix}-sns-topic-policy"
  description = "Allows creation of an SNS topic and publishing notifications."
  policy = templatefile("../templates/iam/sns/generic-sns-topic-policy.json", {
    sns_topic_arn = [
      aws_sns_topic.ami_restore.arn
    ]
  })
}
