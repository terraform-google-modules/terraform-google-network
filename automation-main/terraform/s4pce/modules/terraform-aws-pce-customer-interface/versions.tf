/*
  Description: Required Versions
  Comments:

*/

terraform {
  required_version = ">= 1.0.4"

  required_providers {
    archive = {
      source  = "hashicorp/archive"
      version = ">= 2.2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.1.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.7.2"
    }
  }
}
