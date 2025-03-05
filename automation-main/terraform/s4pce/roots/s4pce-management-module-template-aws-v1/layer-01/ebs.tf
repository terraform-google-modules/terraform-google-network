/*
  Description: Handles default AWS EBS settings
  Comment: AWS will create default keys upon page view in console.
*/


data "aws_kms_key" "account_default_ebs" {
  key_id = "alias/aws/ebs"
}

resource "aws_ebs_default_kms_key" "account" {
  key_arn = data.aws_kms_key.account_default_ebs.arn
}

resource "aws_ebs_encryption_by_default" "account" {
  depends_on = [aws_ebs_default_kms_key.account]

  enabled = true
}
