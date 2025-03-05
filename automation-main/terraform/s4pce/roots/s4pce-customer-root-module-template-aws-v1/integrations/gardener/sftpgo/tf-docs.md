# sftpgo

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.7 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | 2.4.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.49.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.5.2 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.3 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.49.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_role_sftp_s3fgw_sgw"></a> [iam\_role\_sftp\_s3fgw\_sgw](#module\_iam\_role\_sftp\_s3fgw\_sgw) | ../../EXAMPLE_SOURCE/terraform/shared/modules/aws-iam-role | n/a |
| <a name="module_sftp_s3fgw_sgw_instance"></a> [sftp\_s3fgw\_sgw\_instance](#module\_sftp\_s3fgw\_sgw\_instance) | ../../EXAMPLE_SOURCE/terraform/shared/modules/aws-instance | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.sftpgo_db](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/db_instance) | resource |
| [aws_iam_policy.s3_storage_gateway_assume_access_policy](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/iam_policy) | resource |
| [aws_s3_bucket.sftpgo](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.sftpgo](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_ownership_controls.sftpgo](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.sftpgo](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.sftpgo](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/s3_bucket_versioning) | resource |
| [aws_security_group.s3fgw_vpce](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group) | resource |
| [aws_security_group.sftp_s3fgw_sgw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group) | resource |
| [aws_security_group.sftpgo_db](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group) | resource |
| [aws_security_group_rule.dns_tcp_sftp_s3fgw_sgw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.egress_sftp_s3fgw_sgw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.http_sftp_s3fgw_sgw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.https_sftp_s3fgw_sgw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nfs_portmap_udp_sftp_s3fgw_sgw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nfs_portmapper_tcp_sftp_s3fgw_sgw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nfs_tcp_sftp_s3fgw_sgw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nfs_udp_sftp_s3fgw_sgw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nfs_v3_tcp_sftp_s3fgw_sgw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nfs_v3_udp_sftp_s3fgw_sgw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ntp_udp_sftp_s3fgw_sgw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.s3fgw_vpce_1031](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.s3fgw_vpce_2222](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.s3fgw_vpce_443](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.s3fgw_vpce_dynamic](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.sftpgo_db_allow_gardener_nodes](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.smb_netbios_tcp_sftp_s3fgw_sgw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.smb_netbios_udp_sftp_s3fgw_sgw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.smb_tcp_sftp_s3fgw_sgw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_storagegateway_cache.s3fgw_sgw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/storagegateway_cache) | resource |
| [aws_storagegateway_gateway.s3fgw_sgw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/storagegateway_gateway) | resource |
| [aws_storagegateway_nfs_file_share.s3fgw_sgw_nfs_share](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/storagegateway_nfs_file_share) | resource |
| [aws_vpc_endpoint.s3fgw_vpce](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc_endpoint) | resource |
| [random_id.snapshot](https://registry.terraform.io/providers/hashicorp/random/3.6.3/docs/resources/id) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/partition) | data source |
| [aws_storagegateway_local_disk.s3fgw_sgw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/storagegateway_local_disk) | data source |
| [aws_vpc_endpoint.customer_s3_endpoint](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/vpc_endpoint) | data source |
| [terraform_remote_state.customer_layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.customer_layer_02](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.management_layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.management_layer_01](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.shoot_layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_sftpgo_db_apply_immediately"></a> [sftpgo\_db\_apply\_immediately](#input\_sftpgo\_db\_apply\_immediately) | Specifies whether any database modifications are applied immediately, or during the next maintenance window. | `bool` | `false` | no |
| <a name="input_sftpgo_db_master_user_password"></a> [sftpgo\_db\_master\_user\_password](#input\_sftpgo\_db\_master\_user\_password) | The master user password for the SFTPGo database. [!] This is intended to be rotated by operators after initial setup | `string` | n/a | yes |
| <a name="input_sftpgo_db_master_username"></a> [sftpgo\_db\_master\_username](#input\_sftpgo\_db\_master\_username) | The master username for the SFTPGo database. | `string` | `"svc_aws_rds_postgres"` | no |
| <a name="input_sftpgo_s3fgw_allowed_clients"></a> [sftpgo\_s3fgw\_allowed\_clients](#input\_sftpgo\_s3fgw\_allowed\_clients) | Range of IPs allowed to access the SFTPGo S3 file gateway share | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_sftpgo_s3fgw_cache_block_device"></a> [sftpgo\_s3fgw\_cache\_block\_device](#input\_sftpgo\_s3fgw\_cache\_block\_device) | Customize details about the additional (cache) block device of the storage gateway instance | `map(any)` | <pre>{<br/>  "disk_size": 150,<br/>  "volume_type": "gp3"<br/>}</pre> | no |
| <a name="input_sftpgo_s3fgw_nfs_kms_key_arn"></a> [sftpgo\_s3fgw\_nfs\_kms\_key\_arn](#input\_sftpgo\_s3fgw\_nfs\_kms\_key\_arn) | KMS key arn to use for encrypthing the storage gateway NFS file share | `string` | `""` | no |
| <a name="input_sftpgo_s3fgw_s3_bucket_arn_override"></a> [sftpgo\_s3fgw\_s3\_bucket\_arn\_override](#input\_sftpgo\_s3fgw\_s3\_bucket\_arn\_override) | Optionally override the ARN of the S3 bucket to use for the SFTPGo storage gateway; it will be used instead of the bucket created in this integration | `string` | `""` | no |
| <a name="input_sftpgo_s3fgw_sgw_instance_type"></a> [sftpgo\_s3fgw\_sgw\_instance\_type](#input\_sftpgo\_s3fgw\_sgw\_instance\_type) | The EC2 instance type to use for the storage gateway instance | `string` | `"c6in.4xlarge"` | no |
| <a name="input_sftpgo_s3fgw_sgw_timezone"></a> [sftpgo\_s3fgw\_sgw\_timezone](#input\_sftpgo\_s3fgw\_sgw\_timezone) | Timezone for the storage gateway. Useful for scheduling snapshots, configuring maintenance schedules, etc. | `string` | `"GMT-5:00"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_s3_bucket_sftpgo"></a> [aws\_s3\_bucket\_sftpgo](#output\_aws\_s3\_bucket\_sftpgo) | #### Outputs |
| <a name="output_rds_instance_sftpgo_db"></a> [rds\_instance\_sftpgo\_db](#output\_rds\_instance\_sftpgo\_db) | #### Outputs |
| <a name="output_s3fgw_sgw_nfs_share"></a> [s3fgw\_sgw\_nfs\_share](#output\_s3fgw\_sgw\_nfs\_share) | n/a |
| <a name="output_s3fgw_storage_gateway"></a> [s3fgw\_storage\_gateway](#output\_s3fgw\_storage\_gateway) | n/a |
| <a name="output_s3fgw_storage_gateway_instance"></a> [s3fgw\_storage\_gateway\_instance](#output\_s3fgw\_storage\_gateway\_instance) | #### Outputs |
| <a name="output_s3fgw_storage_gateway_name"></a> [s3fgw\_storage\_gateway\_name](#output\_s3fgw\_storage\_gateway\_name) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
