/*
  Description: Test the module
  Comments:
*/

##### Network Object
locals {
  tags = {}
  # tags = {
  #   # Typical tags applied by null-context
  #   Business                 = "test-business"
  #   Customer                 = "test-customer"
  #   Description              = "Test-Description"
  #   Environment              = "test-env"
  #   GeneratedBy              = "terraform"
  #   ManagedBy                = "terraform"
  #   Name                     = "test-module-azure-network"
  #   Organization             = "test-org"
  #   OrganizationFriendlyName = "Sovereign Cloud STE"
  #   Owner                    = "test-owner"
  #   SecurityBoundary         = "test"
  #   TerraformModule          = "azure-network"
  #   TerraformModuleVersion   = "1.0.0"
  # }
}

#NOTE: Subnets can be one IPv4 and one IPv6 CIDR
#NOTE: Azure only support /64 IPv6 Subnets

module "module_test" {
  source           = "../"
  region           = "usgovvirginia"
  build_user       = var.build_user
  tags             = local.tags
  vnet_cidr_blocks = ["172.16.0.0/16", "192.168.1.0/24", "10.0.0.0/8", "fd00:f635:734a::/48"]
  vnet_subnets = {
    zone_1  = { cidr = ["172.16.0.0/26"], zone = "1" }
    zone_e  = { cidr = ["10.0.0.0/24"], zone = "3" }
    zone_v6 = { cidr = ["192.168.1.0/24", "fd00:f635:734a:0001::/64"], zone = "1" }

    edge = { cidr = ["172.16.0.64/26"], zone = "nozone" } // One Edge subnet is required to be "nozone"
    #TODO look into why we do this.  Why is edge required? Is this an artifact from SMS?
  }
  ##### Optional parameters
  # use_custom_dhcpoptions_dns      = ["8.8.8.8", "8.8.4.4"] // default:[] Equivalent to changing dns inside of dhcp options. Defaults to using Azure provided DNS
  # deploy_nat_gateways             = true                   // (boolean) default:true Deploys Nat Gateways per zone
  # associates_private_route_tables = true                   // (boolean) default:true Associates each private (non-edge) subnet to a route table
  # deploy_private_route_tables     = true                   // (boolean) default:true Creates (private) route tables per zone
  # use_default_security_rules      = true                   // (boolean) default:true Use the default security group rules.  Allow all egress. Allow all intra-VPC
}
output "module_test" { value = module.module_test }
