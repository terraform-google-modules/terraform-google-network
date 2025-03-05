/*
  Description: Handles AWS Simple Email Service (SES) configuration
  Comments: https://docs.aws.amazon.com/ses/latest/DeveloperGuide/verify-addresses-and-domains.html
*/


locals {
  deploy_ses = local.deploy_route53_external || var.ses_identity_domain != "" ? true : false
  ses_domain = coalesce(var.ses_identity_domain, local.deploy_route53_external ? aws_route53_zone.external[0].name : null, "none")
}


### SES
resource "aws_ses_domain_identity" "account" {
  count  = local.deploy_ses ? 1 : 0
  domain = local.ses_domain
}

resource "aws_ses_domain_dkim" "account" {
  count  = local.deploy_ses ? 1 : 0
  domain = aws_ses_domain_identity.account[0].domain
}

resource "aws_iam_policy" "svc_ses_relay" {
  count       = local.deploy_ses ? 1 : 0
  name        = "EXAMPLE_TESTING_UNIQUE_svc-ses-mail-relay"
  description = "Allows emails be sent out from a verified email domain and resticts sender and recipient address"
  policy = templatefile("../templates/iam/ses/generic-ses-identity-authorized-sending-policy.json", {
    ses_mail_domain_arn                 = aws_ses_domain_identity.account[0].arn
    ses_notifications_from_address_list = var.ses_notifications_sender_filter
    ses_notifications_recipients        = var.ses_notifications_recipient_filter
    ses_alerts_from_address_list        = var.ses_alerts_sender_filter
    ses_alerts_recipients               = var.ses_alerts_recipient_filter
  })
}

resource "aws_route53_record" "ses_verification_records" {
  count   = local.deploy_route53_external ? 1 : 0
  zone_id = aws_route53_zone.external[0].zone_id
  name    = "_amazonses.${aws_ses_domain_identity.account[0].id}"
  type    = "TXT"
  ttl     = "60"
  records = [aws_ses_domain_identity.account[0].verification_token]
}

resource "aws_ses_domain_identity_verification" "ses_account_verification" {
  count      = local.deploy_route53_external ? 1 : 0
  domain     = aws_ses_domain_identity.account[0].id
  depends_on = [aws_route53_record.ses_verification_records[0]]
}

resource "aws_route53_record" "ses_dkim_records" {
  count   = local.deploy_route53_external ? 3 : 0
  zone_id = aws_route53_zone.external[0].zone_id
  name    = "${element(aws_ses_domain_dkim.account[0].dkim_tokens, count.index)}._domainkey.${aws_route53_zone.external[0].name}"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.account[0].dkim_tokens, count.index)}.dkim.amazonses.com"]
}


# Service account for the USC SMS mail relay
module "iam_user_svc_ses_mail" {
  count      = local.deploy_ses ? 1 : 0
  source     = "EXAMPLE_SOURCE/terraform/shared/modules/aws-iam-user"
  aws_region = module.base_layer_context.region
  build_user = var.build_user
  aws-iam-user-object = {
    name = "svc-mail-${module.base_layer_context.resource_prefix}",
    policy_list = [
      aws_iam_policy.svc_ses_relay[0].arn
    ],
    group_list  = ["ServiceAccounts"],
    tag_company = "SCS"
  }
  module_dependency = join(",", [])
}
