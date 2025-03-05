/*
  Description: Handles creation of Amazon S3 File Gateway for Customer SFTP
  Comments:
    - TODO: Make a S3 File Gateway module and call that from this file instead
*/


locals {
  ### CIDR Locals
  customer_cidr_blocks = [local.customer_layer_00_outputs.infrastructure.vpc_customer.cidr_block]
  ### S3 File Gateway Locals
  sftp_s3fgw_s3_bucket_name = var.sftpgo_s3fgw_s3_bucket_arn_override != "" ? var.sftpgo_s3fgw_s3_bucket_arn_override : aws_s3_bucket.sftpgo.arn
}

##### Storage Gateway Security Group Creation
### Security Group
resource "aws_security_group" "sftp_s3fgw_sgw" {
  name        = "${local.layer_resource_prefix}-sgw"
  description = "Security group with custom ports open within VPC for client connectivity and communication with AWS for storage gateway usage."
  vpc_id      = local.customer_layer_00_outputs.infrastructure.vpc_customer.id
}
### Rules
resource "aws_security_group_rule" "http_sftp_s3fgw_sgw" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  description       = "HTTP required only for activation purposes. The port is closed after activation."
  cidr_blocks       = [local.management_layer_00_outputs.vpc_main01.cidr_block]
  security_group_id = aws_security_group.sftp_s3fgw_sgw.id
}
resource "aws_security_group_rule" "nfs_tcp_sftp_s3fgw_sgw" {
  type              = "ingress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  description       = "NFS-TCP"
  cidr_blocks       = local.customer_cidr_blocks
  security_group_id = aws_security_group.sftp_s3fgw_sgw.id
}
resource "aws_security_group_rule" "nfs_udp_sftp_s3fgw_sgw" {
  type              = "ingress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "udp"
  description       = "NFS-UDP"
  cidr_blocks       = local.customer_cidr_blocks
  security_group_id = aws_security_group.sftp_s3fgw_sgw.id
}
resource "aws_security_group_rule" "nfs_portmapper_tcp_sftp_s3fgw_sgw" {
  type              = "ingress"
  from_port         = 111
  to_port           = 111
  protocol          = "tcp"
  description       = "NFS-portmapper-TCP"
  cidr_blocks       = local.customer_cidr_blocks
  security_group_id = aws_security_group.sftp_s3fgw_sgw.id
}
resource "aws_security_group_rule" "nfs_portmap_udp_sftp_s3fgw_sgw" {
  type              = "ingress"
  from_port         = 111
  to_port           = 111
  protocol          = "udp"
  description       = "NFS-portmapper-UDP"
  cidr_blocks       = local.customer_cidr_blocks
  security_group_id = aws_security_group.sftp_s3fgw_sgw.id
}
resource "aws_security_group_rule" "nfs_v3_tcp_sftp_s3fgw_sgw" {
  type              = "ingress"
  from_port         = 20048
  to_port           = 20048
  protocol          = "tcp"
  description       = "NFSv3-TCP"
  cidr_blocks       = local.customer_cidr_blocks
  security_group_id = aws_security_group.sftp_s3fgw_sgw.id
}
resource "aws_security_group_rule" "nfs_v3_udp_sftp_s3fgw_sgw" {
  type              = "ingress"
  from_port         = 20048
  to_port           = 20048
  protocol          = "UDP"
  description       = "NFSv3-UDP"
  cidr_blocks       = local.customer_cidr_blocks
  security_group_id = aws_security_group.sftp_s3fgw_sgw.id
}
resource "aws_security_group_rule" "https_sftp_s3fgw_sgw" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  description       = "HTTPS"
  cidr_blocks       = local.customer_cidr_blocks
  security_group_id = aws_security_group.sftp_s3fgw_sgw.id
}
resource "aws_security_group_rule" "dns_tcp_sftp_s3fgw_sgw" {
  type              = "ingress"
  from_port         = 53
  to_port           = 53
  protocol          = "tcp"
  description       = "DNS-TCP"
  cidr_blocks       = local.customer_cidr_blocks
  security_group_id = aws_security_group.sftp_s3fgw_sgw.id
}
resource "aws_security_group_rule" "ntp_udp_sftp_s3fgw_sgw" {
  type              = "ingress"
  from_port         = 123
  to_port           = 123
  protocol          = "udp"
  description       = "NTP-UDP"
  cidr_blocks       = local.customer_cidr_blocks
  security_group_id = aws_security_group.sftp_s3fgw_sgw.id
}
resource "aws_security_group_rule" "smb_netbios_tcp_sftp_s3fgw_sgw" {
  type              = "ingress"
  from_port         = 139
  to_port           = 139
  protocol          = "tcp"
  description       = "SMB over NetBIOS - TCP"
  cidr_blocks       = local.customer_cidr_blocks
  security_group_id = aws_security_group.sftp_s3fgw_sgw.id
}
resource "aws_security_group_rule" "smb_netbios_udp_sftp_s3fgw_sgw" {
  type              = "ingress"
  from_port         = 139
  to_port           = 139
  protocol          = "udp"
  description       = "SMB over NetBIOS - UDP"
  cidr_blocks       = local.customer_cidr_blocks
  security_group_id = aws_security_group.sftp_s3fgw_sgw.id
}
resource "aws_security_group_rule" "smb_tcp_sftp_s3fgw_sgw" {
  type              = "ingress"
  from_port         = 445
  to_port           = 455
  protocol          = "tcp"
  description       = "SMB"
  cidr_blocks       = local.customer_cidr_blocks
  security_group_id = aws_security_group.sftp_s3fgw_sgw.id
}
resource "aws_security_group_rule" "egress_sftp_s3fgw_sgw" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  description       = "Storage Gateway egress traffic for activation"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sftp_s3fgw_sgw.id
}

##### Storge Gateway IAM Roles & Policies
### Storage Gateway trust policy
resource "aws_iam_policy" "s3_storage_gateway_assume_access_policy" {
  name        = "${local.layer_resource_prefix}-s3-storage-gateway-assume-access-policy"
  description = "Allows S3 Storage Gateway access to the S3 SFTP bucket for ${local.base_friendly_name}"
  policy = templatefile("../../../templates/iam/s3/generic-s3-storage-gateway-assume-access.json", {
    s3_bucket_arn = local.sftp_s3fgw_s3_bucket_name
  })
}
### Storage Gateway Role / Instance Profile
module "iam_role_sftp_s3fgw_sgw" {
  source               = "../../EXAMPLE_SOURCE/terraform/shared/modules/aws-iam-role"
  iam_role_name        = "${local.layer_resource_prefix}-s3fgw-sgw-nfs-access"
  iam_role_description = "Provides S3 access for ${local.base_friendly_name} storage gateway NFS file share"
  iam_policy_arn_list = [
    aws_iam_policy.s3_storage_gateway_assume_access_policy.arn,
  ]
  iam_instance_profile_name = "${local.layer_resource_prefix}-s3fgw-sgw-nfs-access"
  tag_managedby             = "ansible"
  build_user                = var.build_user
  assume_role_policy        = file("../../../templates/iam/trust/storage-gateway-role-trust-policy.json")
}

##### Storage Gateway EC2 Instance Creation
### Instance
module "sftp_s3fgw_sgw_instance" {
  source = "../../EXAMPLE_SOURCE/terraform/shared/modules/aws-instance"

  tag_name        = "${local.layer_resource_prefix}-s3fgw-sgw"
  tag_description = "Storage gateway instance for S3 File Gateway usage as part of the SFTP solution for ${local.base_friendly_name}"
  tag_productname = "sftp"

  context = local.base_context

  # Use default values unless specified otherwise
  search_ami_name            = "aws-storage-gateway-FILE_S3*"
  search_ami_owner_id        = "amazon"
  instance_type              = var.sftpgo_s3fgw_sgw_instance_type
  ec2_key                    = local.customer_layer_02_outputs.key_pair_name
  monitoring                 = true
  root_encrypted             = true
  root_delete_on_termination = true
  enable_state_recovery      = true
  security_group_ids         = [aws_security_group.sftp_s3fgw_sgw.id]

  subnet_id            = local.customer_layer_00_outputs.infrastructure.subnet_edge_1a.id # TODO: Evaluate this choice
  iam_instance_profile = module.iam_role_sftp_s3fgw_sgw.id
  aws_region           = var.aws_region

  route53_associate_private_ip_address = true
  route53_zoneid                       = local.customer_layer_00_outputs.infrastructure.route53_zone.id
  route53_associate_cname              = true
  route53_additional_cnames            = ["${local.layer_resource_prefix}-s3fgw-sgw"]

  # Additional volume to be used as the cache volume for storage gateway
  additional_volumes = {
    "sdb" = {
      size      = try(tonumber(var.sftpgo_s3fgw_cache_block_device["disk_size"]), 150)
      type      = try(var.sftpgo_s3fgw_cache_block_device["volume_type"], "gp3")
      encrypted = true
    }
  }
}

#### S3 File Gateway VPC Endpoint
### Security Group
resource "aws_security_group" "s3fgw_vpce" {
  name        = "${local.layer_resource_prefix}-s3fgw-vpce"
  description = "Security group with custom ports open Storage Gateway VPC Endpoint connectivity"
  vpc_id      = local.customer_layer_00_outputs.infrastructure.vpc_customer.id
}
### Rules
resource "aws_security_group_rule" "s3fgw_vpce_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  description       = "VPC Endpoint rule HTTPS"
  cidr_blocks       = ["${module.sftp_s3fgw_sgw_instance.private_ip}/32"]
  security_group_id = aws_security_group.s3fgw_vpce.id
}
resource "aws_security_group_rule" "s3fgw_vpce_dynamic" {
  type              = "ingress"
  from_port         = 1026
  to_port           = 1028
  protocol          = "tcp"
  description       = "VPC Endpoint rules"
  cidr_blocks       = ["${module.sftp_s3fgw_sgw_instance.private_ip}/32"]
  security_group_id = aws_security_group.s3fgw_vpce.id
}
resource "aws_security_group_rule" "s3fgw_vpce_1031" {
  type              = "ingress"
  from_port         = 1031
  to_port           = 1031
  protocol          = "tcp"
  description       = "VPC Endpoint rules"
  cidr_blocks       = ["${module.sftp_s3fgw_sgw_instance.private_ip}/32"]
  security_group_id = aws_security_group.s3fgw_vpce.id
}
resource "aws_security_group_rule" "s3fgw_vpce_2222" {
  type              = "ingress"
  from_port         = 2222
  to_port           = 2222
  protocol          = "tcp"
  description       = "VPC Endpoint rules"
  cidr_blocks       = ["${module.sftp_s3fgw_sgw_instance.private_ip}/32"]
  security_group_id = aws_security_group.s3fgw_vpce.id
}
### VPC Endpoint
resource "aws_vpc_endpoint" "s3fgw_vpce" {
  vpc_id            = local.customer_layer_00_outputs.infrastructure.vpc_customer.id
  service_name      = "com.amazonaws.${var.aws_region}.storagegateway"
  vpc_endpoint_type = "Interface"

  security_group_ids = [aws_security_group.s3fgw_vpce.id]

  subnet_ids = [ # TODO: What should these be?
    local.customer_layer_00_outputs.infrastructure.subnet_edge_1a.id,
    local.customer_layer_00_outputs.infrastructure.subnet_edge_1b.id,
    local.customer_layer_00_outputs.infrastructure.subnet_edge_1c.id
  ]

  private_dns_enabled = "true"

  tags = {
    Name = "${local.layer_resource_prefix}-s3fgw-vpce"
  }
}

##### S3 File Gateway (Storage Gateway)
### Storage Gateway
# NOTE: For private subnets & instances without a public IP, port 80 is used on the storage gateway for activation
#       Running this Terraform code will send a HTTP GET request on that port to retrieve the storage gateway activation token
#       Once activation is complete, the port on the instance itself (not the security group) will be closed automatically
resource "aws_storagegateway_gateway" "s3fgw_sgw" {
  depends_on = [module.sftp_s3fgw_sgw_instance] # NOTE: Helps prevent dependency errors during terraform destroy

  # TODO: Configure CloudWatch
  gateway_ip_address   = module.sftp_s3fgw_sgw_instance.private_ip
  gateway_name         = "${local.layer_resource_prefix}-s3fgw-sgw"
  gateway_timezone     = var.sftpgo_s3fgw_sgw_timezone
  gateway_type         = "FILE_S3"
  gateway_vpc_endpoint = aws_vpc_endpoint.s3fgw_vpce.dns_entry[0].dns_name

  lifecycle {
    ignore_changes = [
      tags,
      tags_all
    ]
  }
}
### Cache
data "aws_storagegateway_local_disk" "s3fgw_sgw" {
  gateway_arn = aws_storagegateway_gateway.s3fgw_sgw.arn
  disk_node   = "/dev/sdb" # Based on the 'additional_volumes' for the SGW instance
  disk_path   = "/dev/sdb" # Based on the 'additional_volumes' for the SGW instance
}
resource "aws_storagegateway_cache" "s3fgw_sgw" {
  disk_id     = data.aws_storagegateway_local_disk.s3fgw_sgw.disk_id
  gateway_arn = aws_storagegateway_gateway.s3fgw_sgw.arn

  lifecycle {
    ignore_changes = [
      disk_id
    ]
  }
}

##### NFS
data "aws_vpc_endpoint" "customer_s3_endpoint" {
  vpc_id = local.customer_layer_00_outputs.infrastructure.vpc_customer.id
  id     = local.customer_layer_00_outputs.infrastructure.vpc_customer.s3_endpoint_id
}

resource "aws_storagegateway_nfs_file_share" "s3fgw_sgw_nfs_share" {
  depends_on = [aws_storagegateway_gateway.s3fgw_sgw] # NOTE: Helps prevent dependency errors during terraform destroy

  # TODO: Add audit logs?
  file_share_name       = "${local.layer_resource_prefix}-sgw-share"
  client_list           = var.sftpgo_s3fgw_allowed_clients
  gateway_arn           = aws_storagegateway_gateway.s3fgw_sgw.arn
  location_arn          = local.sftp_s3fgw_s3_bucket_name
  role_arn              = module.iam_role_sftp_s3fgw_sgw.role_arn
  default_storage_class = "S3_STANDARD"
  kms_encrypted         = var.sftpgo_s3fgw_nfs_kms_key_arn == "" ? false : true
  kms_key_arn           = var.sftpgo_s3fgw_nfs_kms_key_arn

  squash = "AllSquash"
  nfs_file_share_defaults {
    directory_mode = "0776" # AWS Default: 0777
    file_mode      = "0666" # AWS Default: 0666
    group_id       = 65534  # AWS Default: 65534
    owner_id       = 65534  # AWS Default: 65534
  }

  # https://docs.aws.amazon.com/storagegateway/latest/APIReference/API_CacheAttributes.html#API_CacheAttributes_Contents
  cache_attributes {
    cache_stale_timeout_in_seconds = "300" # Valid Values: 0, 300 to 2,592,000 seconds (5 minutes to 30 days)
  }

  lifecycle {
    ignore_changes = [
      tags,
      tags_all
    ]
  }
}

##### Outputs
output "s3fgw_storage_gateway_instance" {
  value = module.sftp_s3fgw_sgw_instance
}
output "s3fgw_storage_gateway" {
  value     = aws_storagegateway_gateway.s3fgw_sgw
  sensitive = true
}
output "s3fgw_storage_gateway_name" {
  value = aws_storagegateway_gateway.s3fgw_sgw.gateway_name
}
output "s3fgw_sgw_nfs_share" {
  value = aws_storagegateway_nfs_file_share.s3fgw_sgw_nfs_share
}
