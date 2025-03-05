/*
  Description: Creates pre-requisite network
  Comments: Uses the generic aws-network module to create a testing network.
*/

locals {
  network = {
    primary = {
      cidr = "172.16.0.0/22"
      subnets = {
        zone_a = { cidr = "172.16.0.0/24", zone = "a" }
        zone_b = { cidr = "172.16.1.0/24", zone = "b" }
      }
      subnets_edge = {
        edge_a = { cidr = "172.16.2.0/24", zone = "a" }
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

resource "random_id" "test_env" {
  byte_length = 8
  prefix      = "test-"
}

# Null Context Required because of module aws-instance
data "aws_caller_identity" "test_env" {}
data "aws_partition" "test_env" {}
module "context" {
  source            = "../../../../shared/modules/terraform-null-context"
  account_id        = data.aws_caller_identity.test_env.account_id
  build_user        = var.build_user
  business          = "test"
  customer          = "test"
  environment       = "test-env"
  organization      = "test-org"
  owner             = "test-owner"
  partition         = data.aws_partition.test_env.partition
  region            = var.aws_region
  security_boundary = "test"
  # environment_values = {
  #   tags = [
  #     {
  #       name     = "BusinessSubsection"
  #       value    = "business_subsection"
  #       required = false
  #     }
  #   ]
  #   locals = null
  #   kv = {
  #     organization_friendly_name      = var.organization_friendly_name
  #     security_boundary_friendly_name = var.security_boundary_friendly_name
  #     business_friendly_name          = var.business_friendly_name
  #     business_subsection             = var.business_subsection
  #     prefix_friendly_name            = "${var.security_boundary_friendly_name} ${var.business_friendly_name} ${var.customer}"
  #   }
  # }
}

module "network" {
  source     = "../../../../tools/modules/aws-network"
  aws_region = var.aws_region
  build_user = var.build_user
  tags       = local.tags
  network    = local.network
}


data "aws_iam_policy_document" "test_env" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
  }
}
resource "aws_iam_role" "test_env" {
  name               = random_id.test_env.hex
  description        = "aws-qtm test"
  assume_role_policy = data.aws_iam_policy_document.test_env.json
}
resource "aws_iam_instance_profile" "test_env" {
  name = random_id.test_env.hex
  role = aws_iam_role.test_env.name
}

resource "aws_acm_certificate" "test_env" {
  domain_name               = "test.test"
  certificate_authority_arn = "arn:aws-us-gov:acm-pca:us-gov-west-1:677692745833:certificate-authority/0c1d10fe-f275-40a4-ac93-5bc82afdb2b8"
}

resource "tls_private_key" "test_env" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "test_env" {
  key_name   = random_id.test_env.hex
  public_key = tls_private_key.test_env.public_key_openssh
  tags       = local.tags
}
# output "module_test_network" { value = module.network }
output "zzz_test_private_key" {
  value     = tls_private_key.test_env.private_key_pem
  sensitive = true
}
output "zzz_message" {
  value = "To view private key, run `terraform output zzz_test_private_key`"
}
