/*
  Description: Terraform Output
  Comments: N/A
*/


output "iam_user_svc_cloudwatch_agent" { value = {
  arn  = module.iamuser_svc_cloudwatch_agent.arn
  name = module.iamuser_svc_cloudwatch_agent.name
} }

output "route53_zone_external" { value = local.deploy_route53_external ? {
  id           = aws_route53_zone.external[0].zone_id
  fqdn         = aws_route53_zone.external[0].name
  name         = aws_route53_zone.external[0].name
  name_servers = aws_route53_zone.external[0].name_servers
  exists       = true
} : { exists = false } }

### SES
output "ses_domain_identity" {
  value = local.deploy_ses ? {
    arn = aws_ses_domain_identity.account[0].arn,
    txt = {
      name  = "_amazonses.${aws_ses_domain_identity.account[0].domain}"
      value = aws_ses_domain_identity.account[0].verification_token
    }
    # mx = {   # This has been commented out as environment specific data.
    #   name  = aws_ses_domain_identity.account[0].domain
    #   value = "10 inbound-smtp.us-east-1.amazonaws.com"
    # }
  } : null
}
output "iam_policy_svc_ses_relay" {
  value = local.deploy_ses ? {
    id   = aws_iam_policy.svc_ses_relay[0].id
    name = aws_iam_policy.svc_ses_relay[0].name
  } : null
}
output "iam_user_svc_ses_mail" {
  value = local.deploy_ses ? {
    arn  = module.iam_user_svc_ses_mail[0].arn
    name = module.iam_user_svc_ses_mail[0].name
  } : null
}
