/*
  Description: Required Versions
  Comments:
    - validated with terraform 0.13.2
    - validated with aws 3.3.0
*/

terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.24"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}
