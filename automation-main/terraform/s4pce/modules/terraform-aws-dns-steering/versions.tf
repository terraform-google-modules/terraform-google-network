/*
  Description: Required Versions
*/

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.75.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.2"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.12.1"
    }
  }
}
