The files in this templates folder are used with the terraform `copy` and `template` resources.

The current list of files are as follows:

| FileName                                                          | Comment |
| ------------------------------------------------------------------| ------- |
| iam/s3/generic-s3-backint-policy.json                             | Allows for Backint IAM policy for PCE HANA backup management
| iam/cloudwatch//generic-cloudwatch-policy.json                    | Allows for CloudWatch and Kinesis IAM policy management
| iam/ec2/generic-ec2-bastion-policy.json                           | Allows for EC2 interaction and AMI creation and tagging
| iam/ec2/generic-ec2-pca-acm-policy.json                           | Allows for ACM PCA management
| iam/ec2/generic-ec2-ebs-policy.json                               | Allows for EBS volume creation and resizes
| iam/ec2/generic-ec2-transit-gateway-policy.json                   | Allows write only creation of transit gateways, attachments, and route updates
| iam/s3/generic-s3-multibucket-fullaccess-policy.json              | Allows full read/write/delete access to a list of S3 buckets
| iam/s3/generic-s3-multibucket-readonly-policy.json                | Allows read only access to a list of S3 buckets
| iam/s3/generic-s3-pca-crl-policy.json                             | Permits necessary actions on the S3 bucket to allow ACM PCA to use it to store its Certificate Revocation List (CRL)
| iam/s3/generic-s3-readonly-policy.json                            | Allows read of the specified S3 Bucket
| iam/s3/generic-s3-write-policy.json                               | Allows write to a the specified S3 Bucket
| iam/s3/ibp-s3-readonly-policy.json                                | Used by resource aws_iam_policy to create access policies for IBP S3 buckets
| iam/s3/ibp-s3-write-policy.json                                   | Used by resource aws_iam_policy to create access policies for IBP S3 buckets
| iam/ses/generic-ses-identity-authorized-sending-policy.json       | Used by iam.tf to create IAM role for SES's resource policy.
| iam/ssm/generic-ssm-ec2-ami-policy.json                           | Used by SSM service to perform AMI backup creation and apply patches
| iam/trust/ec2-role-trust-policy.json                              | Used by module aws-iam-role to create trust policies
| iam/trust/cloudwatch-flowlogs-role-trust-policy.json              | Used by CloudWatch Logs to create trust policy for external log account and VPC Flow Logs
| iam/trust/log-collection-role-trust-pppolicy.json                 | Used by CloudTrail and Kinesis to create trust policy for external log account
| iam/trust/rds-role-trust-policy.json                              | Used by AWS RDS to allow trust for join to AWS DS
| iam/trust/aws-inspector-role-policy.json                          | Used by ibp-inspector-cloudwatch-events role to access Inspector service
| iam/trust/aws-inspector-trust-role-policy.json                    | Used by CloudWatch to run Inspector scans
| iam/workspaces/ibp-workspace-fullaccess-policy.json               | Used by Workspaces to allow full access to AWS resources
