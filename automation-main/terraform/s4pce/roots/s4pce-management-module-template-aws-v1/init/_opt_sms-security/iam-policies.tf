/*
  Description: IAM Policies
  Comments: This is code from a specific deployment that is preserved for historical reasons.
*/

# ##### Policies
# resource "aws_iam_policy" "scs_multifactor_auth_policy" {
#   name        = "SCSIAMMultifactorAuthenticationOnlyAccessPolicy"
#   description = "Grants access only when mutlifactor-authentication has been configured."
#   policy = templatefile("../../../../templates/iam/mfa/iam-multifactor-authentication-policy.json", {
#     partition = module.base_context.partition
#   })
# }

# resource "aws_iam_policy" "ns2_reserved_instance_purchase_policy" {
#   name        = "SCSEC2ReservedInstancePurchasePolicy"
#   description = "Provides access to EC2 to purchase reserved instances."
#   policy = templatefile("../../../../templates/iam/ec2/ec2-reserved-instance-purchase-policy.json", {
#   })
# }

# output "iam_policy_ns2_mfa" { value = {
#   id   = aws_iam_policy.ns2_multifactor_auth_policy.id
#   name = aws_iam_policy.ns2_multifactor_auth_policy.name
# } }
# output "iam_policy_ns2_reserved_instance_purchase" { value = {
#   id   = aws_iam_policy.ns2_reserved_instance_purchase_policy.id
#   name = aws_iam_policy.ns2_reserved_instance_purchase_policy.name
# } }
