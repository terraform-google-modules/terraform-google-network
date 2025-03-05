/*
  Description: Required Versions
*/

terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.75.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.3"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.12.1"
    }
  }
}
