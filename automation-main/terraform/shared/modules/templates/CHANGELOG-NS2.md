# Latest Version
0.12-000057

# Version History
## Version 0.12-000057 (2023-11-21) (i535751)
### Enhancement - Created generic-s3-backint-policy.json in templates/iam/s3
* Created `generic-s3-backint-policy.json` in `templates/iam/s3/generic-s3-backint-policy.json`
* Required for new S4PCE backup method using backint

## Version 0.12-000056 (2023-03-08) (c5357274)
### Enhancement - Addded "ecr:PutImageScanningConfiguration" to gardener-ecr-read-write-policy
* Updated `templates/ecr/gardener-ecr-read-write-policy.json`

## Version 0.12-000055 (2022-08-12) (c5283389)
### Enhancement - Add/update Security Agent SSM templates
* Added `templates/ssm/generic-mcafee-agent-install.json`
  * copied from CRE-SMS
* Added `templates/ssm/generic-trend-agent-install.json`
  * copied from CRE-SMS
* Updated `templates/ssm/generic-nessus-agent-install.json`
  * removed description text specifically referencing CRE
* Updated `templates/ssm/generic-nessus-agent-registration.json`
  * removed description text specifically referencing CRE

## Version 0.12-000054 (2022-07-05) (c5343286)
### Enhancement - Add retry to container image mirroring step functions steps
* Updated `templates/step_function/container_image_mirroring.json`

## Version 0.12-000053 (2022-06-23) (c5343286)
### Enhancement - Container image mirroring step function template
* Added `templates/step_function/container_image_mirroring.json` for container image mirroring step function

## Version 0.12-000052 (2022-06-22) (c5337390)
### Enhancement - Added RDS policy for RDS to join to AD
* Added `templates/trust/rds-service-trust-policy.json` for RDS policy for RDS to join to AD

## Version 0.12-000051 (2022-05-19) (i869415)
### Enhancement - Added ECR list policy
* Added `templates/iam/ecr/generic-ecr-list-iam-policy.json` for ECR read-only access that prevents pulling of container images.

## Version 0.12-000050 (2022-04-29) (i511522)
### Enhancement - Added S3 policies for bucket replication
* Added `templates/trust/aws-s3-service-trust-policy.json` for s3 replication roles trust policy
* Added `templates/iam/s3/generic-s3-replication-policy.json` for replications role permissions

## Version 0.12-000049 (2021-08-19) (i868402)
### Enhancement - Update policies
* Update Bastion policy to use partition variable.
* Update ssm ami policy to use partition variable

## Version 0.12-000048 (2021-08-16) (i869415)
### Bugfix - Fixed S3 generic write below path policy template
* Fixed the `templates/iam/s3/generic-s3-write-below-path-policy.json` policy template to correctly interpolate list variable.

## Version 0.12-000047 (2021-08-13) (c5283389)
### Enhancment - Addded S3 generic write below path policy template
* Added `templates/iam/s3/generic-s3-write-below-path-policy.json` to allow S3 write access below a specific path.

## Version 0.12-000046 (2021-07-26) (i514383)
### Enhancment - Addded SNS generic policy
* Added `templates/iam/sns/generic-sns-topic-policy.json` so that bastion hosts can have permissions to create and publish sns topics.

## Version 0.12-000045 (2021-07-14) (i869415)
### Enhancment - Added ecr:DescribeRepositories to ECR sharing policy
* Added the 'ecr:DescribeRepositories' IAM permission to the ECR sharing policy so that users can list ECR repos.

## Version 0.12-000044 (2021-07-12) (i514383)
### Enhancment - Added IAM generic passrole policy
* Added IAM generic passrole policy for passing roles.

## Version 0.12-000043 (2021-07-08) (c5309336)
### Enhancement - Add new policy for SmartStore
* Added new policy template for S3 access for Splunk SmartStore.

## Version 0.12-000042 (2021-05-14) (i869415)
### Enhancment - Added ECR sharing repository policies
* Added ECR repository policies for sharing repositories to other AWS accounts.

## Version 0.12-000041 (2021-04-19) (i511522)
### Enhancment - Added generic-access-key-management.json
* Added generic-access-key-mangement.json for allowing user to manage own access keys

## Version 0.12-000040 (2021-03-30) (i869415)
### Enhancment - Added generic-s3-ses-write-policy.json
* Added generic-s3-ses-write-policy.json for granting SES permission to write emails to an S3 bucket.

## Version 0.12-000039 (2021-03-02) (i869415)
### Enhancment - Moved image creation policies into their module
* Moved the following policies into the 'aws-image-creation' module.
  * 'generic-ec2-image-creation-policy.json'
  * 'generic-ec2-vmimport-policy.json'
  * 'ec2-vmimport-role-trust-policy.json'

## Version 0.12-000038 (2021-02-24) (i511522)
### Enhancment - Nessus agent install policy
* Added policy template for nessus agent install permissions

## Version 0.12-000037 (2021-02-23) (i511522)
### Enhancement - Added cloudwatch:DeleteAlarms to bastion policy
* Added cloudwatch:DeleteAlarms to bastion policy to allow weekly cron alarm cleanup

## Version 0.12-000036 (2021-02-10) (i869415)
### Enhancement - Fixed general image creation policy
* Fixed the RunInstances permissions in the generic image creation IAM policy.
* ec2/generic-ec2-image-creation-policy.json

## Version 0.12-000035 (2021-02-11) (c5283389)
### Enhancement - Addition of nessus agent registration ssm doc template
* Added generic ssm doc for nessus agent registration
* ssm/generic-nessus-agent-registration.json

## Version 0.12-000034 (2021-02-02) (i869415)
### Enhancement - Added vmimport IAM role policies
* Added generic vmimport IAM policy.
* Added generic image creation IAM policy.
* Added vmimport IAM role trust policy.
* ec2/generic-ec2-vmimport-policy.json
* ec2/generic-ec2-image-creation-policy.json
* trust/ec2-vmimport-role-trust-policy.json

## Version 0.12-000033 (2021-01-27) (i511522)
### Enhancement - Addition of nessus agent install ssm doc template
* Added generic ssm doc for nessus agent install
* ssm/generic-nessus-agent-install.json

## Version 0.12-000032 (2020-11-02) (i868402)
### Enhancement - Additional Bastion Policies
* Additional Bastion policies required for cloudwatch alarms
* SNS Subscribe
* SNS Unsubscribe

## Version 0.12-000031 (2020-10-30) (i513825)
### Bugfix - S3 readonly prefix template
* Fix pathing contained within `generic-s3-readonly-prefix-policy.json` template to ensure proper read/list permissions below specified path

## Version 0.12-000030 (2020-10-23) (c5295459)
### Enhancement - Allow instances to leverage AWS Backup
* iam/ec2/ec2-windows-backup-policy.json
* iam/trust/ec2-backup-role-trust-policy.json

## Version 0.12-000029 (2020-10-22) (i868402)
### Enhancement - Allow bastion to Tag and migrate instances
* iam/ec2/generic-ec2-bastion-policy.json
* Granted additional privileges to perform Tagging
* Granted additional privileges to perform SnapshotMigration

## Version 0.12-000028 (2020-10-22) (i511522)
### Enhancement - Added kms encrypted bucket read only polciy
* Added kms encrypted bucket readonly policy

## Version 0.12-000027 (2020-10-21) (i511522)
### Enhancement - Added concourse worker policy template
* Allows concourse workers to create cloudwatch alarms

## Version 0.12-000026 (2020-10-12) (i868402)
### Enhancement - Allow bastion to create cloudwatch alarms
* iam/ec2/generic-ec2-bastion-policy.json
* Granted additional privileges to create cloudwatch alarms

## Version 0.12-000025 (2020-09-25) (i516349)
### Bugfix - Added additional permissions to reserved instance policy
* iam/ec2/ec2-reserved-instance-purchase-policy.json
* Granted additional privileges to adjust reserved instances rather than just purchasing

## Version 0.12-000024 (2020-08-23) (i868402)
### Bugfix - fixed multiarn policy json encoding
* Leveraged Terraform's `jsonencode()` function to encode the passed list of ARNs to json in templates/iam/ec2/generic-ec2-pca-acm-policy.json
  * Allows multiple PCA ARNs to be passed to the policy.

## Version 0.12-000023 (2020-07-23) (i513825)
### Bugfix - fixed mult-ibucket policy json encoding
* Leveraged Terraform's `jsonencode()` function to encode the passed list of bucket ARNs to json
    * This alleviates the need to default always append the Admin user to get around the trailing comma problem

## Version 0.12-000022 (2020-07-17) (i513825)
### Feature - added multi-bucket s3 bucket policies
* Added fullaccess multibucket s3 bucket policy `generic-s3-multibucket-fullaccess-policy` that accepts a list of S3 buckets to permit full access to
* Added readonly multibucket s3 bucket policy `generic-s3-multibucket-readonly-policy` that accepts a list of S3 buckets to permit readonly access to

## Version 0.12-000021 (2020-07-06) (i513825)
### Feature - added S3 PCA CRL bucket policy template
* Added `generic-s3-pca-crl-policy.json` policy template to setup a S3 bucket to be used my ACM PCA to store its Certificate Revocation List (CRL)

## Version 0.12-000020 (2020-06-15) (i513825)
### Feature - Adding templates
* iam/ssm/generic-ssm-ec2-ami-policy.json - Used by SSM service to perform AMI backup creation and apply patches
* iam/trust/ssm-role-trust-policy.json - Used by SSM automation to assume necessary IAM roles

## Version 0.12-000019 (2020-06-15) (i513825)
### Bugfix - SES policy
* Bugfix interpolated variable names in `generic-ses-identity-authorized-sending-policy`
* Policy version changed to `2012-10-17`
* Removed principle from policy

## Version 0.12-000018 (2020-06-15) (i513825)
### Feature - Adding SES policy for sending out emails
* Adding generic-ses-identity-authorized-sending-policy to templated policies under SES

## Version 0.12-000017 (i514383)
### Feature - Adding and Updating SIDs
* Adding SIDs to templated policies where none existed before
* Editing existing SIDs for clarity and consistency

## Version 0.12-000016 (i513825)
### Enhancement - Updating KMS SID
* Policy updated to include default `sid`

## Version 0.12-000015 (i516349)
### Enhancement - Updating Log Collection template
* Policy updated to allow CMDB searches to pull network information

## Version 0.12-000014 (c5235437)
### Enhancement - New Workspaces template
* iam/workspaces/ibp-workspace-fullaccess-policy.json
* Policy to allow Workspaces full access to AWS resources

## Version 0.12-000013 (i513825)
### Enhancement - New SSM template
* iam/s3/generic-s3-ssm-policy.json
* Allows SSM agent to write to specific S3 bucket storing SSM patch logs

## Version 0.12-000012 (c5295459)
### Enhancement - Update bastion template
* iam/ec2/generic-ec2-bastion-policy.json

## Version 0.12-000011 (c5295459)
### Enhancement - New bastion host template
* iam/ec2/generic-ec2-bastion-policy.json
* Allows for local execution for start/stop of EC2 instances and AMI tagging and creation

## Version 0.12-000010 (i868402)
### Enhancement - New Transit Gateway template
* iam/ec2/generic-ec2-transit-gateway-policy.json
* Allows for service account to create transit gateways, attachments and update routes

## Version 0.12-000009 (i516349)
### Enhancement - New Log Collection template for Splunk
* iam/splunk/generic-aws-readonly-policy.json
* Allows for splunk to ingest aws data for ec2 and inspector data

## Version 0.12-000008 (c5295459)
### Enhancement - Updated Log Collection templates
* iam/cloudwatch/generic-cloudwatch-policy.json
* AWS requires Kinesis:ListStreams, Kinesis:ListShards, Kinesis:DescribeLimits, and Kinesis:ListStreamConsumers be open to all resources as opposed to specific Kinesis ARN. Manually tested and validated working for external Splunk integration via Kinesis stream.

## Version 0.12-000007 (c5295459)
### Enhancement - Updated ACM/PCA template
* iam/ec2/generic-ec2-pca-acm-policy.json

## Version 0.12-000006 (c5295459)
### Enhancement - Updated ACM/PCA template
* iam/ec2/generic-ec2-pca-acm-policy.json

## Version 0.12-000005 (c5295459)
### Enhancement - New Log Collection templates
* iam/trust/cloudwatch-flowlogs-role-trust-policy.json
* iam/trust/log-collection-role-trust-policy.json

### Enhancement - New policy
* iam/cloudwatch/generic-cloudwatch-policy.json

## Version 0.12-000004 (c5295459)
### Enhancement - New ACM/PCA template
* iam/ec2/generic-ec2-pca-acm-policy.json

## Version 0.12-000003 (i868402)
### Enhancement - New ebs and s3 templates
* iam/ec2/generic-ec2-ebs-policy.json
* iam/s3/generic-s3-write-policy.json

## Version 0.12-000002 (i868402)
### Enhancement - New s3 template
* iam/s3/generic-s3-readonly-policy.json

## Version 0.12-000001 (i868402)
### Initial version established with the following features
* iam/s3/ibp-s3-readonly-policy.json
* iam/s3/ibp-s3-write-policy.json
* iam/trust/ec2-role-trust-policy.json
