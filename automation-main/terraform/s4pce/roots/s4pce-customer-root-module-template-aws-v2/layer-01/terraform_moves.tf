

# IAM
moved {
  from = aws_iam_policy.s3_backups_readlist_policy
  to   = module.s4pce_customer_iam.aws_iam_policy.s3_backups_readlist_policy
}
moved {
  from = aws_iam_policy.s3_backups_write_policy
  to   = module.s4pce_customer_iam.aws_iam_policy.s3_backups_write_policy
}
moved {
  from = module.iam_role_customer_default
  to   = module.s4pce_customer_iam.module.iam_role_customer_default
}
