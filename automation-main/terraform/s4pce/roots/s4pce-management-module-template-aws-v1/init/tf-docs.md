# init

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.49.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.3 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.49.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_context"></a> [base\_context](#module\_base\_context) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_aws_route53_zone_external"></a> [context\_aws\_route53\_zone\_external](#module\_context\_aws\_route53\_zone\_external) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_iam_user_svc_ses_mail"></a> [iam\_user\_svc\_ses\_mail](#module\_iam\_user\_svc\_ses\_mail) | EXAMPLE_SOURCE/terraform/shared/modules/aws-iam-user | n/a |
| <a name="module_iamuser_svc_cloudwatch_agent"></a> [iamuser\_svc\_cloudwatch\_agent](#module\_iamuser\_svc\_cloudwatch\_agent) | EXAMPLE_SOURCE/terraform/shared/modules/aws-iam-user | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.svc_ses_relay](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_policy) | resource |
| [aws_route53_record.ses_dkim_records](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route53_record) | resource |
| [aws_route53_record.ses_verification_records](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route53_record) | resource |
| [aws_route53_zone.external](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route53_zone) | resource |
| [aws_ses_domain_dkim.account](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/ses_domain_dkim) | resource |
| [aws_ses_domain_identity.account](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/ses_domain_identity) | resource |
| [aws_ses_domain_identity_verification.ses_account_verification](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/ses_domain_identity_verification) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_business"></a> [business](#input\_business) | Name of the line of business resources are being deployed for; will be used as part of naming prefix for all resources | `string` | n/a | yes |
| <a name="input_business_friendly_name"></a> [business\_friendly\_name](#input\_business\_friendly\_name) | Human readable friendly name of the line of business resources are being deployed for | `string` | n/a | yes |
| <a name="input_business_subsection"></a> [business\_subsection](#input\_business\_subsection) | Name of the line of business subsection | `string` | n/a | yes |
| <a name="input_customer"></a> [customer](#input\_customer) | Customer that uses the deployed system; e.g. `ns2`, `management`, `customer00006` | `string` | n/a | yes |
| <a name="input_dns_external_fqdn"></a> [dns\_external\_fqdn](#input\_dns\_external\_fqdn) | Sets the FQDN of the public hosted zone in Route 53 for the DNS Domain | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment classification being deployed into; e.g. `development`, `production` | `string` | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | Name of the organization work this work belongs to; will be used as part of naming prefix in special cases requiring globally unique resources to avoid clashing outside of the organization | `string` | n/a | yes |
| <a name="input_organization_friendly_name"></a> [organization\_friendly\_name](#input\_organization\_friendly\_name) | Human readable friendly name of the organization this work belongs to | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Email address directing communication to the party responsible for the system; e.g., `isso@sapns2.com`, `isse@sapsn2.com`, `dhibpops@sapns2.com` | `string` | n/a | yes |
| <a name="input_security_boundary"></a> [security\_boundary](#input\_security\_boundary) | Name of the security boundary being deployed into; will be used as part of naming prefix for all resources | `string` | n/a | yes |
| <a name="input_security_boundary_friendly_name"></a> [security\_boundary\_friendly\_name](#input\_security\_boundary\_friendly\_name) | Human readable friendly name of the security boundary being deployed into | `string` | n/a | yes |
| <a name="input_ses_alerts_recipient_filter"></a> [ses\_alerts\_recipient\_filter](#input\_ses\_alerts\_recipient\_filter) | Domain name filter to enforce that SES must be sending alert emails to, e.g. must be sending alert emails to `sapns2.com` recipients | `any` | n/a | yes |
| <a name="input_ses_alerts_sender_filter"></a> [ses\_alerts\_sender\_filter](#input\_ses\_alerts\_sender\_filter) | Domain name filter to enforce that SES must be sending alert emails to, e.g. must be sending alert emails from `sapns2.com` recipients | `any` | n/a | yes |
| <a name="input_ses_identity_domain"></a> [ses\_identity\_domain](#input\_ses\_identity\_domain) | Optional Domain name that SES will send outbound mail from if not created by dns\_external\_fqdn | `string` | `""` | no |
| <a name="input_ses_notifications_recipient_filter"></a> [ses\_notifications\_recipient\_filter](#input\_ses\_notifications\_recipient\_filter) | Domain name filter to enforce that SES must be sending an email to, e.g. must be sending notification emails to `sapns2.com` recipients | `any` | n/a | yes |
| <a name="input_ses_notifications_sender_filter"></a> [ses\_notifications\_sender\_filter](#input\_ses\_notifications\_sender\_filter) | Domain name filter to enforce that SES must be sending an email from, e.g. must be sending notification emails from 'sapns2.com' | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_policy_svc_ses_relay"></a> [iam\_policy\_svc\_ses\_relay](#output\_iam\_policy\_svc\_ses\_relay) | n/a |
| <a name="output_iam_user_svc_cloudwatch_agent"></a> [iam\_user\_svc\_cloudwatch\_agent](#output\_iam\_user\_svc\_cloudwatch\_agent) | n/a |
| <a name="output_iam_user_svc_ses_mail"></a> [iam\_user\_svc\_ses\_mail](#output\_iam\_user\_svc\_ses\_mail) | n/a |
| <a name="output_route53_zone_external"></a> [route53\_zone\_external](#output\_route53\_zone\_external) | n/a |
| <a name="output_ses_domain_identity"></a> [ses\_domain\_identity](#output\_ses\_domain\_identity) | ## SES |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
