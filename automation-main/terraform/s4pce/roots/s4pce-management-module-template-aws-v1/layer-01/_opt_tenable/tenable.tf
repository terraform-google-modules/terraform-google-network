/*
  Description: Certificates
  Comments: This is code from a specific deployment that is preserved for historical reasons.
*/

### Tenable
# resource "aws_iam_policy" "nessus_agent_install_policy" {
#   name        = "${module.base_layer_context.resource_prefix}-nessus-agent-install-policy"
#   description = "Allows the ability to read installation media from the binaries S3 bucket and ssm permissions to install nessus agent."
#   policy = templatefile("../templates/iam/ssm/generic-ssm-nessus-agent-install-policy.json", {
#     s3_bucket_arn     = "arn:aws-us-gov:s3:::ns2-usc-sms-binaries",
#     access_below_path = "media/tenable"
#   })
# }

# resource "aws_iam_policy" "tenable_s3_read" {
#   name        = "${module.base_layer_context.resource_prefix}-tenable-s3-read-policy"
#   description = "Allows Tenable read permissions to s3 bucket for storing backups."
#   policy = templatefile("../templates/iam/s3/generic-s3-readonly-policy.json", {
#     s3_bucket_arn = module.s3_tenable_backups.bucket_arn
#   })
# }
# resource "aws_iam_policy" "tenable_s3_write" {
#   name        = "${module.base_layer_context.resource_prefix}-tenable-s3-write-policy"
#   description = "Allows Tenable write permissions to s3 bucket for storing backups."
#   policy = templatefile("../templates/iam/s3/generic-s3-write-policy.json", {
#     s3_bucket_arn = module.s3_tenable_backups.bucket_arn
#   })
# }


# module "iam_role_tenable" {
#   source               = "EXAMPLE_SOURCE/terraform/shared/modules/aws-iam-role"
#   iam_role_name        = "${module.base_layer_context.resource_prefix}-tenable"
#   iam_role_description = "Provides IAM access for Tenable products."
#   iam_policy_arn_list = [
#     "arn:${module.base_layer_context.partition}:iam::aws:policy/AmazonEC2ReadOnlyAccess",
#     "arn:${module.base_layer_context.partition}:iam::aws:policy/CloudWatchAgentServerPolicy",
#     "arn:${module.base_layer_context.partition}:iam::aws:policy/AmazonS3ReadOnlyAccess",
#     "arn:${module.base_layer_context.partition}:iam::aws:policy/AmazonSSMManagedInstanceCore",
#     aws_iam_policy.nessus_agent_install_policy.arn,
#     aws_iam_policy.tenable_s3_read.arn,
#     aws_iam_policy.tenable_s3_write.arn,
#     aws_iam_policy.acm_pca_policy.arn
#   ]
#   iam_instance_profile_name = "${module.base_layer_context.resource_prefix}-tenable"
#   tag_managedby             = "terraform"
#   build_user                = var.build_user
#   assume_role_policy        = file("../templates/iam/trust/ec2-role-trust-policy.json")
#   module_dependency         = join(",", [])
# }


##### Tenable
# module "context_s3_tenable_backups" {
#   source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
#   context     = module.context_s3_base.context
#   name        = "EXAMPLE_TESTING_UNIQUE_tenable-backups"
#   description = "Tenable backup data"
# }

# module "s3_tenable_backups" {
#   source     = "EXAMPLE_SOURCE/terraform/shared/modules/aws-s3bucket" # This should point back to the original module.
#   aws_region = module.base_layer_context.region
#   build_user = module.context_s3_tenable_backups.build_user
#   s3_bucket_map = {
#     name                    = module.context_s3_tenable_backups.name
#     versioning              = "Enabled"
#     restrict_public_buckets = true                                          # (true|false) AWS Public policy restrictions
#     ignore_public_acls      = true                                          # (true|false) AWS Public policy restrictions
#     block_public_acls       = true                                          # (true|false) AWS Public policy restrictions
#     block_public_policy     = true                                          # (true|false) AWS Public policy restrictions
#     tag_name                = module.context_s3_tenable_backups.name        # AWS Tag Name to apply.  If not specified, it will be the same as the name.
#     tag_managedby           = module.context_s3_tenable_backups.managed_by  # Technology that will be managing the bucket
#     tag_environment         = module.context_s3_tenable_backups.environment # (staging|production|management) Related plane
#     tag_business            = module.context_s3_tenable_backups.business
#     tag_customer            = module.context_s3_tenable_backups.customer
#     tag_description         = module.context_s3_tenable_backups.description
#     tag_owner               = module.context_s3_tenable_backups.owner
#   }
#   bucket_policy     = "none"
#   module_dependency = join(",", []) # Use this to make the module depend on an external factor
# }
### End Tenable
# output "s3_tenable_backups" { value = {
#   arn  = module.s3_tenable_backups.bucket_arn
#   name = module.s3_tenable_backups.bucket_names
# } }
