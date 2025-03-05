/*
  Description: Handles AWS Instances
  Comments:
*/


##### Instance Contexts
module "context_instance_rhel" {
  source        = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context       = module.base_layer_context.context
  custom_values = module.base_layer_context.custom_values
  additional_tags = {
    # PatchGroup = local.layer_01_outputs.ssm_management_rhel_general.patch_group
    Platform  = "unlicensed"
    ManagedBy = "ansible"
  }
}

##### instance_openvpn
module "instance_openvpn" {
  source = "../../EXAMPLE_SOURCE/terraform/shared/modules/aws-instance"
  ### MANDATORY values. These must be specified when calling module
  search_ami_name     = var.image_openvpn_name
  search_ami_owner_id = var.ami_owner_default
  ec2_key             = aws_key_pair.main01.key_name
  security_group_ids = [
    # local.edge_vpc_layer_00_outputs.security_group_main01_vpc.id,
    local.edge_vpc_layer_00_outputs.security_group_main01_all_egress.id,
    aws_security_group.main01_vpn_ingress.id
  ]
  subnet_id            = local.edge_vpc_layer_00_outputs.subnet_main01_infrastructure_1a.id
  iam_instance_profile = ""
  aws_region           = module.base_layer_context.region
  context              = module.context_instance_rhel.context
  tag_name             = "vpn"
  tag_description      = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} OpenVPN Server"
  tag_productname      = "openvpn"
  ### Optional values. Values specified below have defaults or will be ignored if not passed by calling module.
  instance_type         = "t3.small"
  enable_state_recovery = false
  monitoring            = false
  root_encrypted        = true
  # Networking Variables
  associate_elastic_ip_address = true
  # Route53 Variables
  route53_associate_private_ip_address = false
}
##### End instance_openvpn
