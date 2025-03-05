/*
  Description: Required Versions
  Comments:
    - N/A
*/
terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
    null = {
      source = "hashicorp/null"
    }
  }
}

provider "null" {
  version = "2.1.2"
}
