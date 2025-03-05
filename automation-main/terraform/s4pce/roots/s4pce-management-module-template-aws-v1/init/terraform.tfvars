/*
  Description: Terraform inputs
  Comments:
*/

### AWS Variables
aws_region = "EXAMPLE_STATE_REGION"

dns_external_fqdn = "" # External FQDN to be created

##### Identity domain and receipient Variables
ses_identity_domain = "" # SES Domain to use instead of external FQDN created above
### List of sender filters
ses_notifications_sender_filter = [
  "*@EXAMPLE_EXTERNAL_FQDN"
]
### List of domains for SES service user to send notifications emails (e.g. "*@customer-domain.com")
ses_notifications_recipient_filter = [
  "*"
]
### List of alerts sender filters
ses_alerts_sender_filter = [
  "alerts@*",
  "alerts*@EXAMPLE_EXTERNAL_FQDN"
]
### List of domains for SES service user to send alerts emails (e.g. "*@sap.com")
ses_alerts_recipient_filter = [
  "*@sap.com"
]

### Naming and Tagging Variables
organization                    = "EXAMPLE_ORGANIZATION"
organization_friendly_name      = "EXAMPLE_ORGANIZATION_FRIENDLY_NAME"
security_boundary               = "EXAMPLE_SECURITY_BOUNDARY"
security_boundary_friendly_name = "EXAMPLE_SECURITY_BOUNDARY_FRIENDLY_NAME"
business                        = "s4"
business_subsection             = "pce"
business_friendly_name          = "S4 Private Cloud Edition"
owner                           = "EXAMPLE_OWNER_EMAIL"
environment                     = "EXAMPLE_ENVIRONMENT"
customer                        = "EXAMPLE_TESTING_UNIQUE_management"

# ##### Uncomment and populate these values before running terraform
# // build_user = ""
