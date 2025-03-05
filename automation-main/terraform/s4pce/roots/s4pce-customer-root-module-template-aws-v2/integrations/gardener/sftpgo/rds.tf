/*
  Description: Handles creation of the RDS instance used by SFTPGo for this customer
  Comments:
   - Deploys an RDS instance to a subnet group in the Gardener Shoot VPC, where SFTPGo will be running on a Gardener shoot cluster
   - The details of this RDS instance are used for the deployment of the SFTPGo application
*/

##### RDS Security Group - SFTPGo DB
resource "aws_security_group" "sftpgo_db" {
  name        = "${local.layer_resource_prefix}-db"
  description = "Security group for the SFTPGo database for ${local.layer_resource_prefix}"
  vpc_id      = local.shoot_layer_00_outputs.vpc_shoot.id

  tags = {
    Name = "${local.layer_resource_prefix}-db"
  }
}

resource "aws_security_group_rule" "sftpgo_db_allow_gardener_nodes" {
  security_group_id = aws_security_group.sftpgo_db.id
  type              = "ingress"
  protocol          = "all"
  from_port         = 0
  to_port           = 5432
  cidr_blocks       = [local.shoot_layer_00_outputs.vpc_shoot.cidr_block]
  # TODO: Add IPV6 support
  description = "Allow PostgreSQL traffic from instances (cluster worker nodes) in the Management/Gardener Shoot VPC"
}

##### RDS Instance - SFTPGo DB
# NOTE the use of the keepers should be ok here. But we need to take a look at larger overall code.
resource "random_id" "snapshot" {
  keepers = {
    prefix = "${local.layer_resource_prefix}-db"
  }

  prefix      = "${local.layer_resource_prefix}-db-"
  byte_length = 4
}

resource "aws_db_instance" "sftpgo_db" {
  depends_on = [aws_security_group.sftpgo_db]

  identifier                      = "${local.layer_resource_prefix}-db"
  instance_class                  = "db.t3.medium" # TODO: Evaluate this
  allocated_storage               = 20
  max_allocated_storage           = 100
  storage_type                    = "gp3"
  engine                          = "postgres"
  engine_version                  = "16.2"
  allow_major_version_upgrade     = false
  auto_minor_version_upgrade      = true
  apply_immediately               = var.sftpgo_db_apply_immediately # NOTE: Set to 'true' --> useful for testing, disruptive for production
  username                        = var.sftpgo_db_master_username
  password                        = var.sftpgo_db_master_user_password
  vpc_security_group_ids          = [aws_security_group.sftpgo_db.id]
  db_subnet_group_name            = local.shoot_layer_00_outputs.subnet_group_rds_sftpgo.id
  multi_az                        = true
  deletion_protection             = true
  skip_final_snapshot             = false # TODO: Evaluate these later
  storage_encrypted               = true
  delete_automated_backups        = true
  copy_tags_to_snapshot           = true
  final_snapshot_identifier       = "${random_id.snapshot.hex}-final-snapshot"
  port                            = 5432
  backup_retention_period         = 35
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  # network_type              = "DUAL" # TODO: Add IPv6 support

  lifecycle {
    ignore_changes = [
      username,
      password,
      engine_version,
    ]
  }
}

##### Outputs
output "rds_instance_sftpgo_db" {
  value     = aws_db_instance.sftpgo_db
  sensitive = true
}
