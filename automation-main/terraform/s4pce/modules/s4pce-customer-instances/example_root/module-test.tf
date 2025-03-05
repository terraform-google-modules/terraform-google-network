/*
  Description: Test the module
  Comments:
*/

##### Instances
module "s4pce_customer_instances" {
  source  = "../"
  context = module.base_context.context

  # Network
  vpc_id  = module.s4pce_customer_infrastructure.vpc_customer.id
  subnets = module.s4pce_customer_infrastructure.subnets
  network = module.s4pce_customer_infrastructure.network

  # Instance Variables
  image_database_name    = "Golden-SCS-RHEL-8.6-HANA-V*"
  image_application_name = "Golden-SCS-RHEL-8.6-SAPAPP-V*"
  ssh_main01_public_key  = ""
  ssh_keypair_name       = null # Optional. Define is specific name is desired rather than default name from context
  ami_owner_default      = "156506675147"
  rhel_patch_group       = module.ssm_management_rhel_general.patch_group
  windows_patch_group    = module.ssm_management_windows_general.patch_group
  ubuntu_patch_group     = module.ssm_management_ubuntu_general.patch_group
  instance_security_groups_list = [
    module.s4pce_customer_infrastructure.security_group_vpc.id,
    module.s4pce_customer_infrastructure.security_group_all_egress.id,
    module.s4pce_customer_infrastructure.security_group_customer_access_management.id,
  ]
  instance_route53_zone_id = aws_route53_zone.test.id
  instance_iam_role        = module.s4pce_customer_iam.iam_role_customer_default.id

  instance_list = {
    testdbhp4 = {
      sid                  = "HP4"
      name                 = "DB"
      productname          = "S4Hana"
      productgroup         = "Enterprise Management"
      tag_productcomponent = "testing"
      landscape            = "Production"
      instance_type        = "t3a.micro"
      # cnames               = ["testdbhp4"]
    }
  }

  ha_instances = [] # Optional. Use if HA deployment

  # SAP Router
  saprouter_ingress_cidr = [] # Optional. Use if saprouter is deployed

  depends_on = [module.s4pce_customer_infrastructure, module.s4pce_customer_iam]
}

output "s4pce_customer_instances" { value = module.s4pce_customer_instances }