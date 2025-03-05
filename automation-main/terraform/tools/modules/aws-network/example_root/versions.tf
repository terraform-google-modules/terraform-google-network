/*
  Description: Required Terraform Versions
  Comments:
*/

terraform {
  required_version = "1.5.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.49.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.3"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.12.1"
    }
  }
}


# provider_installation {
#   dev_overrides {
#     "registry.terraform.io/hashicorp/example" = "/home/(your user)/customised-providers/terraform-provider-example"
#   }
# }


# provider_installation {
#   filesystem_mirror {
#     path    = "/tmp/terraform"
#     include = ["*/*"]
#   }
#   direct {
#     exclude = ["*/*"]
#   }
# }

# provider_installation {
#   dev_overrides {
#     "hashicorp/aws" = "/tmp/terraform/registry.terraform.io/hashicorp/aws"
#   }
# }
