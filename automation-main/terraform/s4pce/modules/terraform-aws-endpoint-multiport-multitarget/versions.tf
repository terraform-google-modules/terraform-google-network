/*
  Description: Required Versions
  Comments:
*/

terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.70.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.2"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 2.1.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.12.1"
    }
  }
}
