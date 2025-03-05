/*
  Description: Required Terraform Versions
*/

terraform {
  required_version = ">= 0.14.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.32.0"
    }
  }
}
