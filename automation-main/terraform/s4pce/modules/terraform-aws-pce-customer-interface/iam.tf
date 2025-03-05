/*
  Description: Handles IAM related resources.
  Layer: 00
*/

### S3 IAM Role
module "context_iam_role_interface_s3_replication" {
  source      = "../../../shared/modules/terraform-null-context/modules/legacy"
  context     = module.base_layer_context.context
  name        = "interface-s3-replication"
  description = "Provides AWS permissions to replicate interface S3 Buckets"
}

resource "aws_iam_role" "interface_s3_replication" {
  name        = module.context_iam_role_interface_s3_replication.name
  description = module.context_iam_role_interface_s3_replication.description
  tags        = module.context_iam_role_interface_s3_replication.tags
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Sid : ""
        Action : "sts:AssumeRole",
        Principal : {
          Service : [
            "s3.amazonaws.com",
            "lambda.amazonaws.com"
          ]
        },
        Effect : "Allow",
      },
      {
        Sid : "Datasync"
        Action : "sts:AssumeRole",
        Principal : {
          Service : "datasync.amazonaws.com"
        },
        Effect : "Allow",
        "Condition" : {
          "StringEquals" : {
            "aws:SourceAccount" : module.base_layer_context.account_id
          },
          "ArnLike" : {
            "aws:SourceArn" : "arn:${module.base_layer_context.partition}:datasync:${module.base_layer_context.region}:${module.base_layer_context.account_id}:*"
  } } }] })
}
### End S3 IAM Role

### S3 to S3 Replication Policies
resource "aws_iam_role_policy_attachment" "interface_s3_replication" {
  count      = length(var.customer_bucket_names) > 0 ? 1 : 0
  role       = aws_iam_role.interface_s3_replication.name
  policy_arn = aws_iam_policy.interface_s3_replication[0].arn
}
module "context_iam_interface_s3_replication" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = module.base_layer_context.context

  name        = "interface-s3-replication-policy"
  description = "Provides AWS permissions to replicate interface S3 Buckets"
}
resource "aws_iam_policy" "interface_s3_replication" {
  count       = length(var.customer_bucket_names) > 0 ? 1 : 0
  name        = module.context_iam_interface_s3_replication.name
  description = module.context_iam_interface_s3_replication.description
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = concat([for key in [var.shared_kms_key] : {
      "Sid" : "DestinationEncryptKeys",
      "Action" : [
        "kms:Encrypt"
      ],
      "Effect" : "Allow",
      "Resource" : [
        key,
      ]
      } if var.shared_kms_key != null],
      [
        {
          Sid    = "AllowListBucketandGetReplicationConfig"
          Effect = "Allow"
          Action = [
            "s3:ListBucket",
            "s3:GetReplicationConfiguration"
          ]
          Resource = aws_s3_bucket.customer_interface.arn
        },
        {
          Sid    = "AllowGetObjectInformation"
          Effect = "Allow"
          Action = [
            "s3:GetObjectVersionAcl",
            "s3:GetObjectVersionTagging",
            "s3:GetObjectVersionForReplication",
            "s3:GetObjectVersion",
            "s3:ObjectOwnerOverrideToBucketOwner",
            "s3:GetObject",
          ],
          Resource = "${aws_s3_bucket.customer_interface.arn}/*"
        },
        {
          Sid    = "AllowObjectReplicationToMirrorBucket"
          Effect = "Allow"
          Action = [
            "s3:ReplicateObject",
            "s3:ReplicateDelete",
            "s3:ReplicateTags",
            "s3:ObjectOwnerOverrideToBucketOwner"
          ],
          "Resource" = [
            for customer_bucket_name in var.customer_bucket_names : "arn:${module.base_layer_context.partition}:s3:::${customer_bucket_name}/*"
  ] }]) })
}
### End S3 to S3 Replication Policies


### Datasync Policies
resource "aws_iam_role_policy_attachment" "interface_datasync_s3" {
  role       = aws_iam_role.interface_s3_replication.name
  policy_arn = aws_iam_policy.interface_s3_datasync.arn
}
module "context_iam_interface_datasync_s3" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = module.base_layer_context.context

  name        = "interface-datasync-s3-policy"
  description = "Provides AWS permissions for datasync to access S3 Buckets"
}
resource "aws_iam_policy" "interface_s3_datasync" {
  name        = module.context_iam_interface_datasync_s3.name
  description = module.context_iam_interface_datasync_s3.description
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowListAndRead"
        Effect = "Allow"
        Action = [
          "s3:GetBucketLocation",
          "s3:ListBucket",
          "s3:ListBucketMultipartUploads"
        ]
        Resource = aws_s3_bucket.customer_interface.arn
      },
      {
        Sid    = "AllowObjectAccess"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListMultipartUploadParts",
          "s3:GetObjectTagging"
        ],
        Resource = "${aws_s3_bucket.customer_interface.arn}/*"
  }] })
}
resource "aws_iam_role_policy_attachment" "interface_datasync_lambda" {
  role       = aws_iam_role.interface_s3_replication.name
  policy_arn = aws_iam_policy.interface_datasync_lambda.arn
}
module "context_iam_interface_datasync_lambda" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = module.base_layer_context.context

  name        = "interface-datasync-lambda-policy"
  description = "Provides AWS permissions allowing datasync to run lambda"
}
resource "aws_iam_policy" "interface_datasync_lambda" {
  name        = module.context_iam_interface_datasync_lambda.name
  description = module.context_iam_interface_datasync_lambda.description
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "DescribeENI"
        Effect = "Allow"
        Action = [
          "ec2:DescribeNetworkInterfaces"
        ]
        Resource = "*"
      },
      {
        Sid    = "StartLambda"
        Effect = "Allow"
        Action = [
          "datasync:StartTaskExecution"
        ]
        Resource = [
          aws_datasync_task.customer_interface_to_efs.id,
          aws_datasync_task.customer_interface_to_s3.id
  ] }] })
}
### End Datasync Policies

### Service account
resource "aws_iam_policy" "service_account_write" {
  count       = var.use_service_account ? 1 : 0
  name        = "svc-${module.base_layer_context.customer}-interfaces-write"
  description = "Allows the ability for service account to upload to S3 bucket under the ${var.service_account_write_path} path."
  policy = templatefile("${path.module}/../../../shared/modules/templates/iam/s3/generic-s3-write-below-path-policy.json", {
    arn_list = [
      "${aws_s3_bucket.customer_interface.arn}${var.service_account_write_path}/*"
    ]
  })
}

resource "aws_iam_policy" "service_account_read" {
  count       = var.use_service_account ? 1 : 0
  name        = "svc-${module.base_layer_context.customer}-interfaces-read"
  description = "Allows the ability for service account to read S3 bucket objects under the ${var.service_account_read_path} path."
  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Sid : "AllowGetBucketLocation",
        Effect : "Allow",
        Action : [
          "s3:GetBucketLocation"
        ],
        "Resource" : aws_s3_bucket.customer_interface.arn
      },
      {
        Sid : "AllowListBucket",
        Effect : "Allow",
        Action : [
          "s3:ListBucket"
        ],
        Resource : [
          "${aws_s3_bucket.customer_interface.arn}"
        ]
      },
      {
        Sid : "AllowGetObject",
        Effect : "Allow",
        Action : [
          "s3:GetObject"
        ],
        Resource : [
          "${aws_s3_bucket.customer_interface.arn}/${var.service_account_read_path}"
        ]
      }
    ]
  })
}

module "context_svc_account" {
  count       = var.use_service_account ? 1 : 0
  source      = "../../../shared/modules/terraform-null-context/modules/legacy"
  context     = module.base_layer_context.context
  name        = "svc-${module.base_layer_context.customer}-interfaces"
  description = "Service account used by customer to upload objects to S3"
  flags       = { override_name = true }
}
resource "aws_iam_user" "svc_account" {
  count = var.use_service_account ? 1 : 0
  name  = module.context_svc_account[0].name
  tags  = module.context_svc_account[0].tags
}

resource "aws_iam_user_policy_attachment" "svc_account_read" {
  count      = var.use_service_account ? 1 : 0
  user       = aws_iam_user.svc_account[0].id
  policy_arn = aws_iam_policy.service_account_read[0].arn

  depends_on = [aws_iam_user.svc_account[0]]
}
resource "aws_iam_user_policy_attachment" "svc_account_write" {
  count      = var.use_service_account ? 1 : 0
  user       = aws_iam_user.svc_account[0].id
  policy_arn = aws_iam_policy.service_account_write[0].arn

  depends_on = [aws_iam_user.svc_account[0]]
}
