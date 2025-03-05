/*
  Description: Terraform variables
  Comments:
*/



### AWS Variables
variable "aws_region" {
  description = "AWS region"
}

variable "dns_external_fqdn" {
  description = "Sets the FQDN of the public hosted zone in Route 53 for the DNS Domain"
  type        = string
  default     = ""
}


### Amazon SES identity domain variables
variable "ses_identity_domain" {
  description = "Optional Domain name that SES will send outbound mail from if not created by dns_external_fqdn"
  type        = string
  default     = ""
}
variable "ses_notifications_recipient_filter" {
  description = "Domain name filter to enforce that SES must be sending an email to, e.g. must be sending notification emails to `sapns2.com` recipients"
}
variable "ses_notifications_sender_filter" {
  description = "Domain name filter to enforce that SES must be sending an email from, e.g. must be sending notification emails from 'sapns2.com'"
}
variable "ses_alerts_recipient_filter" {
  description = "Domain name filter to enforce that SES must be sending alert emails to, e.g. must be sending alert emails to `sapns2.com` recipients"
}
variable "ses_alerts_sender_filter" {
  description = "Domain name filter to enforce that SES must be sending alert emails to, e.g. must be sending alert emails from `sapns2.com` recipients"
}
