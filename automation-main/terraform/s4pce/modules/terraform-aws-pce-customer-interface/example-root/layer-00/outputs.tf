/*
  Description: Output variables of the terraform-aws-pce-customer-interface modules
  Comments: N/A
*/

output "test_efs" { value = {
  fsid       = aws_efs_file_system.test_service_vpc.id
  dns_name   = aws_efs_mount_target.test_service_vpc.dns_name
  arn        = aws_efs_mount_target.test_service_vpc.file_system_arn
  mount_id   = aws_efs_mount_target.test_service_vpc.id
  ip_address = aws_efs_mount_target.test_service_vpc.ip_address
} }
