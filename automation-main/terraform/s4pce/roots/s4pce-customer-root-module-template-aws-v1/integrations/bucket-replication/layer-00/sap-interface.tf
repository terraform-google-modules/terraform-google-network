/*
  Description: Create the SAP Interface S3 Bucket and optional datasync.
  Comments:
    KMS generated here should be shared with the customer.
*/


module "context_kms_customer_interface" {
  source      = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.base_layer_context.context
  name        = "${module.base_layer_context.resource_prefix}-interface"
  description = "Key used to encrypt ${module.base_layer_context.customer} interface bucket"
}
resource "aws_kms_key" "customer_interface" {
  description             = module.context_kms_customer_interface.description
  deletion_window_in_days = 7
  tags                    = module.context_kms_customer_interface.tags
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Id" : "key-default-1",
      "Statement" : [
        {
          "Sid" : "Enable IAM User Permissions",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : [
              "arn:aws-us-gov:iam::${module.base_layer_context.account_id}:root",
              "arn:aws-us-gov:iam::${var.customer_account_id}:root"
            ]
          },
          "Action" : "kms:*",
          "Resource" : "*"
        }
      ]
    }
  )
}

module "customer_interface" {
  source                          = "../../EXAMPLE_SOURCE/terraform/s4pce/modules/terraform-aws-pce-customer-interface"
  context                         = module.base_layer_context.context
  interface_bucket_write_arns     = var.interface_bucket_write_arns
  bucket_name                     = "${module.base_layer_context.resource_prefix}-interface"
  shared_kms_key                  = var.shared_kms_key
  customer_account_id             = var.customer_account_id
  customer_bucket_names           = var.customer_bucket_names
  destination_efs_mount_target_id = local.layer_00_outputs.infrastructure.efs_usr_sap_trans.mount_targets["1a"].id
  ### Optional values
  # datasync_efs_subdirectory   = "/interface"
  # datasync_s3_subdirectory    = "/"
  # datasync_schedule_s3_to_efs = "rate(15 minutes)"
  # datasync_schedule_efs_to_s3 = "cron(15,45 * * * ? *)"
  # datasync_delete_s3_to_efs   = true
  # datasync_delete_efs_to_s3   = false
}
