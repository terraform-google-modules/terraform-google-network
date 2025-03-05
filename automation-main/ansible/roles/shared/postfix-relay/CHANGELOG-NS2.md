# Latest Version
2.9-000034

# Version History
## Version 2.9-000034 (2022-06-14) (i561481)
### Enhancement - Convert role functionality to solely local mail forwarding
* Removed OpenDKIM Configuration
* Removed SES Relay Configuration
* Removed Sender rules and Recipient restrictions
* Removed casefolding
* Removed mailing lists
* Removed custom HELO/EHLO name option
* Moved vars files to Postfix role
* Removed templates that are no longer needed
* Updated README to reflect changes

## Version 2.9-000033 (2022-05-02) (c5279079)
### Enhancement - Remove HCM variables file
* added new mailing list: dl_cam_mp@sapns2.com

## Version 2.9-000032 (2022-04-08) (c5309377)
### Enhancement - Remove HCM variables file
* HCM CRE variable file removed
* HCM QA variable file removed

## Version 2.9-000031 (2022-03-01) (c5309377)
### Enhancement - Remove USC SMS variables file
* USC SMS variables file removed

## Version 2.9-000030 (2022-01-28) (i558332)
### Enhancement - coreservices vars file removed
* coreservices vars file removed

## Version 2.9-000029 (2021-12-07) (i513825)
### Enhancement - USC S4 PCE Postfix vars file
* Check in vars file for the USC S4 PCE Postfix deployment

## Version 2.9-000028 (2021-10-29) (i516349)
### Enhancement - Update email distribution list membership
* adds the cld-vulnerability@sapns2.com email distribution list

## Version 2.9-000027 (2021-10-18) (i511522)
### Bugfix - Correct CRE-SMS victorops filter
* Change *@victorops.com to *@alert.victorops.com

## Version 2.9-000026 (2021-10-13) (c5309377)
### Bugfix - DKIM service may not exist
* Update the logic to ignore the error if the service does not exist and thus can't be stopped

## Version 2.9-000025 (2021-10-13) (i511522)
### Bugfix - Undo slack domain removal
* Added slack domain back to CRE-SMS notifications recipients

## Version 2.9-000024 (2021-10-12) (i511522)
### Enhancement - Replace Slack rule with VictorOps
* Replaced Slack domain with VictorOps domain for pipeline notifications

## Version 2.9-000023 (2021-10-01) (c5309377)
### Enhancement - Add DKIM signing capabilities
* Adds new DKIM signing capabilities to the Postfix relay role that allow it sign messages
* Adds new ability to masquerade the envelope sender
* Adds new ability to configure the HELO/EHLO hostname used in the SMTP conversation

## Version 2.9-000022 (2021-09-07) (c5309377)
### Enhancement - Add support for mailing lists
* Adds support for defining mailing lists for distribution to multiple people

### Enhancement - Improved casefolding for IAM SES policies
* Replaced the previous more complicated solution with a simple casefold enabling flag that lowercases all email addresses completely.

## Version 2.9-000021 (2021-08-12) (i513825)
### Enhancement - Added vars files for CRE/QA HCM Postfix deployments
* Added vars files for CRE/QA HCM Postfix deployments

### Enhancement - Added package installs molecule test
* Added molecule test that verifies the `postfix` package installation

## Version 2.9-000020 (2021-08-11) (i548369)
### Bugfix - Permanently disable firewalld
* Adds task to permanently disable firewalld

## Version 2.9-000019 (2021-07-27) (i513825)
### Enhancement - Added USC SMS Postfix-Relay vars file
* Added configuration vars file for USC SMS Postfix-Relay deployment

## Version 2.9-000018 (2021-07-07) (c5309377)
### Bugfix - Allow IPv6 access to relay in CORE
* Adds IPv6 to the relay networks which are allowed to relay through our Postfix instance

## Version 2.9-000017 (2021-06-24) (i511522)
### Enhancement - Allow S4 relay to send externally
* Allow S4 mail relay to send non-alert emails to external domains

## Version 2.9-000016 (2021-05-18) (c5309377)
### Enhancement - Allow configuration of the SES Configuration Set
* Allow the configuration of a header that is prepended to all outgoing email sent through SES to include the ConfigurationSet to be used

## Version 2.9-000015 (2021-04-26) (i511522)
### Bugfix - Add canonical rules to ibp-cre vars
* Added canonical sender and recipent rules to ibp-cre vars file

### Bugfix - Changed ibp-cre alerts recipient filter to sapns2.com
* Changed ibp-cre alerts recipient filter to *@sapns2.com instead of alerts@*

## Version 2.9-000014 (2021-04-12) (c5309377)
### Bugfix - Point at .internal for vault
* AUS should point at .internal for vault

## Version 2.9-000013 (2021-03-10) (i511522)
### Enhancement - Core variables file
* Added variables file for core postfix configuration

## Version 2.9-000012 (2021-03-14) (c5309377)
### Enhancement - SMS AUS may email to Slack
* Allow SMS AUS to email to Slack for notifications

## Version 2.9-000011 (2021-02-05) (c5309377)
### Enhancement - Allow creation of canonical maps to lowercase local-part/domain
* Adds two new variables and the appropriate role configuration to lowercase the case sensitive parts as required by SES's IAM policies
* Added rules for SMS AUS, SMS CRE, S4PCE

## Version 2.9-000010 (2021-02-01) (i511522)
### Enhancement - Added new domain to alerts recipient filter
* Added new domain to alerts recipient filter
* Removed unused domains

## Version 2.9-000009 (2021-01-19) (i511522)
### Enhancement - Added SAP application access for S4/IBP-Dev
* Added `*@sapns2.us` and `*@SAPNS2.US` to from address list for S4PCE and IBP-Dev

## Version 2.9-000008 (2021-01-14) (i511522)
### Enhancement - Added s4-pce-cre vars file
* Added s4-pce-cre vars file

## Version 2.9-000007 (2020-12-31) (c5304116)
### Enhancement - Allow SMTP relay to Slack channels on SAP org only
* Notifications need to be sent to a common medium where multiple teams are able to effectively monitor alerting e.g., SCP PREPROD

## Version 2.9-000006 (2020-12-26) (c5309377)
### Enhancement -  Allow limits on MAIL FROM/RCPT TO address pairs
* This allows us to model similar limitations in SES IAM policies to limit what users are allowed to email to what destinations

## Version 2.9-000005 (2020-12-17) (c5309377)
### Bugfix - Enable listening on all interfaces
* Update the postfix main.cf to set it to listen on all interfaces

### Enhancement - Disable TLSv1.0 and below
* Disables TLSv1.0 and below even on the SMTPD side and sets supported ciphers to high to allow for opportunistic encryption within the environment

## Version 2.9-000004 (2020-11-23) (i511522)
### Enhancement - IBP Dev and FedCiv vars files
* Added vars files for IBP Dev, CRE, and IBP Fedciv configuration

## Version 2.9-000003 (2020-11-24) (c5309377)
### Feature - Added updated variables for SMS CRE
* Added updated variables for SMS CRE

## Version 2.9-000002 (2020-11-21) (c5309377)
### Feature - Automatically create SES password from access secret/region
* No longer does this need to be generated beforehand, it now does it for you!

## Version 2.9-000001 (2020-10-08) (c5309377)
### Initial Version - Add new postfix-relay role
* Add a new postfix-relay role that can use another SMTP server as the relay
  host for all outgoing mail.
