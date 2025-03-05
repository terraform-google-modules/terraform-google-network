/*
  Description: Handles AWS Instances
  Comments:
    * instance_openvpn_mfa
    * instance_bastion
    * instance_hana_cockpit
    * instance_solman_abap
    * instance_solman_java
    * instance_solman_hana
    * instance_ses_postfix_host
    * instance_proxy
*/

##### Instance Contexts
module "context_instance_rhel" {
  source        = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context       = module.base_layer_context.context
  custom_values = module.base_layer_context.custom_values
  additional_tags = {
    PatchGroup = local.layer_01_outputs.ssm_management_rhel_general.patch_group
    Platform   = "unlicensed"
    ManagedBy  = "ansible"
  }
}
module "context_instance_windows" {
  source        = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context       = module.base_layer_context.context
  custom_values = module.base_layer_context.custom_values
  additional_tags = {
    "PatchGroup"     = local.layer_01_outputs.ssm_management_windows_general.patch_group
    Platform         = "licensed"
    ManagedBy        = "powershell"
    ProductVendor    = "windows"
    ProductComponent = "admanagement"
  }
}
module "context_instance_ubuntu" {
  source        = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context       = module.base_layer_context.context
  custom_values = module.base_layer_context.custom_values
  additional_tags = {
    PatchGroup = local.layer_01_outputs.ssm_management_ubuntu_general.patch_group
    Platform   = "unlicensed"
    ManagedBy  = "ansible"
  }
}

##### instance_openvpn_mfa
module "instance_openvpn_mfa" {
  source = "EXAMPLE_SOURCE/terraform/shared/modules/aws-instance"
  ### MANDATORY values. These must be specified when calling module
  search_ami_name     = var.image_metadata.openvpn_image
  search_ami_owner_id = var.image_owner_default
  ec2_key             = aws_key_pair.main01.key_name
  security_group_ids = [
    local.layer_00_outputs.security_group_main01_vpc.id,
    local.layer_00_outputs.security_group_main01_all_egress.id,
    local.layer_00_outputs.security_group_main01_access_edge.id
  ]
  subnet_id            = local.layer_00_outputs.subnet_main01_edge_1a.id
  iam_instance_profile = local.layer_01_outputs.iam_role_default.instance_profile_name
  aws_region           = module.base_layer_context.region
  context              = module.context_instance_ubuntu.context
  tag_name             = "vpn"
  tag_description      = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} OpenVPN MFA Server"
  tag_productname      = "openvpn"
  module_dependency    = join(",", [])
  ### Optional values. Values specified below have defaults or will be ignored if not passed by calling module.
  instance_type         = "t3.small"
  enable_state_recovery = true
  monitoring            = true
  root_encrypted        = true
  # Networking Variables
  associate_elastic_ip_address = true
  # Route53 Variables
  route53_associate_private_ip_address = true
  route53_zoneid                       = local.layer_00_outputs.route53_zone_main01.id
  route53_ttl                          = "300"
  route53_associate_cname              = false
  route53_additional_cnames = [
    "openvpn"
  ]
}
##### End instance_openvpn_mfa

### instance_bastion
module "instance_bastion" {
  source = "EXAMPLE_SOURCE/terraform/shared/modules/aws-instance"
  ### MANDATORY values. These must be specified when calling module
  search_ami_name     = var.image_metadata.base_image
  search_ami_owner_id = var.image_owner_default
  ec2_key             = aws_key_pair.main01.key_name
  security_group_ids = [
    local.layer_00_outputs.security_group_main01_vpc.id,
    local.layer_00_outputs.security_group_main01_all_egress.id
  ]
  subnet_id            = local.layer_00_outputs.subnet_main01_infrastructure_1a.id
  iam_instance_profile = local.layer_01_outputs.iam_role_bastion.instance_profile_name
  aws_region           = module.base_layer_context.region
  context              = module.context_instance_rhel.context
  tag_name             = "bastion"
  tag_description      = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Bastion Server"
  tag_productname      = "bastion"
  module_dependency    = join(",", [])
  ### Optional values. Values specified below have defaults or will be ignored if not passed by calling module.
  instance_type         = "t3.medium"
  enable_state_recovery = true
  monitoring            = true
  # Root Volume Variables
  root_encrypted = true
  # Route53 Variables
  route53_associate_private_ip_address = true
  route53_zoneid                       = local.layer_00_outputs.route53_zone_main01.id
  route53_ttl                          = "300"
  route53_associate_cname              = false
  route53_additional_cnames = [
    "bastion"
  ]
}
##### End instance_bastion

##### instance_hana_cockpit
module "instance_hana_cockpit" {
  source                     = "EXAMPLE_SOURCE/terraform/shared/modules/aws-instance"
  search_ami_name            = var.image_metadata.database_image
  search_ami_owner_id        = var.image_owner_default
  instance_type              = "r5.2xlarge"
  ec2_key                    = aws_key_pair.main01.key_name
  monitoring                 = true
  root_encrypted             = true
  root_delete_on_termination = false
  enable_state_recovery      = true
  security_group_ids = [
    local.layer_00_outputs.security_group_main01_vpc.id,
    local.layer_00_outputs.security_group_main01_all_egress.id
  ]
  subnet_id                            = local.layer_00_outputs.subnet_main01_infrastructure_1a.id
  iam_instance_profile                 = local.layer_01_outputs.iam_role_default.instance_profile_name
  aws_region                           = module.base_layer_context.region
  context                              = module.context_instance_rhel.context
  tag_name                             = "hana"
  tag_description                      = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Hana Cockpit"
  tag_productname                      = "hana"
  route53_associate_private_ip_address = true
  route53_zoneid                       = local.layer_00_outputs.route53_zone_main01.id
  route53_ttl                          = "300"
  route53_associate_cname              = false
  route53_additional_cnames = [
    "hanacockpit",
    "mgtdbt03",
  ]
  module_dependency = join(",", [])
}
##### End instance_hana_cockpit

##### instance_solman_abap
module "instance_solman_abap" {
  source                     = "EXAMPLE_SOURCE/terraform/shared/modules/aws-instance"
  search_ami_name            = var.image_metadata.application_image
  search_ami_owner_id        = var.image_owner_default
  instance_type              = "r5.2xlarge"
  ec2_key                    = aws_key_pair.main01.key_name
  monitoring                 = true
  root_encrypted             = true
  root_delete_on_termination = false
  enable_state_recovery      = true
  security_group_ids = [
    local.layer_00_outputs.security_group_main01_vpc.id,
    local.layer_00_outputs.security_group_main01_all_egress.id
  ]
  subnet_id                            = local.layer_00_outputs.subnet_main01_infrastructure_1a.id
  iam_instance_profile                 = local.layer_01_outputs.iam_role_default.instance_profile_name
  aws_region                           = module.base_layer_context.region
  context                              = module.context_instance_rhel.context
  tag_name                             = "abap"
  tag_description                      = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Solman ABAP"
  tag_productname                      = "solman"
  route53_associate_private_ip_address = true
  route53_zoneid                       = local.layer_00_outputs.route53_zone_main01.id
  route53_ttl                          = "300"
  route53_associate_cname              = false
  route53_additional_cnames = [
    "solman-abap",
    "mgtapp01t00",
  ]
  module_dependency = join(",", [])
}
##### End instance_solman_abap

##### instance_solman_java
module "instance_solman_java" {
  source                     = "EXAMPLE_SOURCE/terraform/shared/modules/aws-instance"
  search_ami_name            = var.image_metadata.application_image
  search_ami_owner_id        = var.image_owner_default
  instance_type              = "r5.2xlarge"
  ec2_key                    = aws_key_pair.main01.key_name
  monitoring                 = true
  root_encrypted             = true
  root_delete_on_termination = false
  enable_state_recovery      = true
  security_group_ids = [
    local.layer_00_outputs.security_group_main01_vpc.id,
    local.layer_00_outputs.security_group_main01_all_egress.id
  ]
  subnet_id                            = local.layer_00_outputs.subnet_main01_infrastructure_1a.id
  iam_instance_profile                 = local.layer_01_outputs.iam_role_default.instance_profile_name
  aws_region                           = module.base_layer_context.region
  context                              = module.context_instance_rhel.context
  tag_name                             = "java"
  tag_description                      = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Solman Java"
  tag_productname                      = "solman"
  route53_associate_private_ip_address = true
  route53_zoneid                       = local.layer_00_outputs.route53_zone_main01.id
  route53_ttl                          = "300"
  route53_associate_cname              = false
  route53_additional_cnames = [
    "solman-java",
    "mgtapp01t02",
  ]
  module_dependency = join(",", [])
}
##### End instance_solman_java

##### instance_solman_hana
module "instance_solman_hana" {
  source                     = "EXAMPLE_SOURCE/terraform/shared/modules/aws-instance"
  search_ami_name            = var.image_metadata.database_image
  search_ami_owner_id        = var.image_owner_default
  instance_type              = "r5.8xlarge"
  ec2_key                    = aws_key_pair.main01.key_name
  monitoring                 = true
  root_encrypted             = true
  root_delete_on_termination = false
  enable_state_recovery      = true
  security_group_ids = [
    local.layer_00_outputs.security_group_main01_vpc.id,
    local.layer_00_outputs.security_group_main01_all_egress.id
  ]
  subnet_id                            = local.layer_00_outputs.subnet_main01_infrastructure_1a.id
  iam_instance_profile                 = local.layer_01_outputs.iam_role_default.instance_profile_name
  aws_region                           = module.base_layer_context.region
  context                              = module.context_instance_rhel.context
  tag_name                             = "hana"
  tag_description                      = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Solman HANA"
  tag_productname                      = "solman"
  route53_associate_private_ip_address = true
  route53_zoneid                       = local.layer_00_outputs.route53_zone_main01.id
  route53_ttl                          = "300"
  route53_associate_cname              = false
  route53_additional_cnames = [
    "solman-hana",
    "mgtdbt01",
  ]
  module_dependency = join(",", [])
}
##### End instance_solman_hana

### instance_ses_postfix_host
module "instance_ses_postfix_host" {
  source = "EXAMPLE_SOURCE/terraform/shared/modules/aws-instance"
  ### MANDATORY values. These must be specified when calling module
  search_ami_name     = var.image_metadata.base_image
  search_ami_owner_id = var.image_owner_default
  ec2_key             = aws_key_pair.main01.key_name
  security_group_ids = [
    local.layer_00_outputs.security_group_main01_vpc.id,
    local.layer_00_outputs.security_group_main01_relay.id,
    local.layer_00_outputs.security_group_main01_all_egress.id
  ]
  subnet_id            = local.layer_00_outputs.subnet_main01_infrastructure_1a.id
  iam_instance_profile = local.layer_01_outputs.iam_role_default.instance_profile_name
  aws_region           = module.base_layer_context.region
  context              = module.context_instance_rhel.context
  tag_name             = "mail"
  tag_description      = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} SES PostFix Relay"
  tag_productname      = "postfix"
  module_dependency    = join(",", [])
  ### Optional values. Values specified below have defaults or will be ignored if not passed by calling module.
  instance_type         = "t3.small"
  enable_state_recovery = true
  monitoring            = true
  # Root Volume Variables
  root_size      = "100"
  root_encrypted = true
  # Route53 Variables
  route53_associate_private_ip_address = true
  route53_zoneid                       = local.layer_00_outputs.route53_zone_main01.id
  route53_ttl                          = "300"
  route53_associate_cname              = false
  route53_additional_cnames = [
    "mail"
  ]
}
### End instance_ses_postfix_host

### instance_proxy
module "instance_nginx_proxy" {
  source = "EXAMPLE_SOURCE/terraform/shared/modules/aws-instance"
  ### MANDATORY values. These must be specified when calling module
  search_ami_name     = var.image_metadata.base_image
  search_ami_owner_id = var.image_owner_default
  ec2_key             = aws_key_pair.main01.key_name
  security_group_ids = [
    local.layer_00_outputs.security_group_main01_vpc.id,
    local.layer_00_outputs.security_group_main01_all_egress.id
  ]
  subnet_id            = local.layer_00_outputs.subnet_main01_infrastructure_1a.id
  iam_instance_profile = local.layer_01_outputs.iam_role_default.instance_profile_name
  aws_region           = module.base_layer_context.region
  context              = module.context_instance_rhel.context
  tag_name             = "proxy"
  tag_description      = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Proxy Server"
  tag_productname      = "proxy"
  module_dependency    = join(",", [])
  ### Optional values. Values specified below have defaults or will be ignored if not passed by calling module.
  instance_type         = "t3.medium"
  enable_state_recovery = true
  monitoring            = true
  # Root Volume Variables
  root_encrypted = true
  # Route53 Variables
  route53_associate_private_ip_address = true
  route53_zoneid                       = local.layer_00_outputs.route53_zone_main01.id
  route53_ttl                          = "300"
  route53_associate_cname              = false
  route53_additional_cnames = [
    "proxy"
  ]
}
