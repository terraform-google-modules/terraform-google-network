/*
  Description: Terraform input variables
  Comments: N/A
*/

##### AWS Variables
aws_region = "EXAMPLE_STATE_REGION"

##### SNS Variables
aws_sns_topic                   = "EXAMPLE_SNS_TOPIC"
aws_topic_name                  = "EXAMPLE_TOPIC_NAME"
aws_sns_email_distribution_list = "EXAMPLE_DISTRIBUTION@SAP.COM"
aws_sns_ami_restore_email_list  = ["EXAMPLE_SNS_EMAIL"]

### PKI Variables
# SMS Intermediate CA
acm_pca_arn = "EXAMPLE_ACM_PCA_ARN"

##### Uncomment and populate these values before running terraform
// build_user = ""
