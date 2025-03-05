/*
  Description: Creates pre-requisite network
  Comments: Uses the generic aws-network module to create a testing network.
*/

locals {
  network = {
    primary = {
      cidr = "172.16.0.0/23"
      subnets = {
        zone_a = { cidr = "172.16.0.0/24", zone = "a" }
      }
      subnets_edge = {
        edge_a = { cidr = "172.16.1.0/24", zone = "a" }
    } }
  }

  tags = {}
  # tags = {
  #   # Typical tags applied by null-context
  #   Business                 = "test-business"
  #   Customer                 = "test-customer"
  #   Description              = "Test-Description"
  #   Environment              = "test-env"
  #   GeneratedBy              = "terraform"
  #   ManagedBy                = "terraform"
  #   Name                     = "test-module-aws-docker-bastions"
  #   Organization             = "test-org"
  #   OrganizationFriendlyName = "Sovereign Cloud STE"
  #   Owner                    = "test-owner"
  #   SecurityBoundary         = "test"
  #   TerraformModule          = "aws-docker-bastions"
  # }
}


module "network" {
  source     = "../../aws-network"
  aws_region = var.aws_region
  build_user = var.build_user
  tags       = local.tags
  network    = local.network
}

resource "random_id" "id" {
  byte_length = 8
  prefix      = "test-"
}
resource "tls_private_key" "test_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "key" {
  key_name   = random_id.id.hex
  public_key = tls_private_key.test_private_key.public_key_openssh
  tags       = local.tags
}
# output "module_test_network" { value = module.network }
output "zzz_test_private_key" {
  value     = tls_private_key.test_private_key.private_key_pem
  sensitive = true
}
output "zzz_message" {
  value = "To view private key, run `terraform output zzz_test_private_key`"
}
