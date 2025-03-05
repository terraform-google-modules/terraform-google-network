/*
  Description: Required Versions
*/

terraform {
  required_version = ">= 1.1.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.10.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.1.1"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.2"
    }
  }
}
