/*
  Description: Required Versions
  Comments:

*/
terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.38"
    }
    time = {
      source = "hashicorp/time"
    }
  }
}
