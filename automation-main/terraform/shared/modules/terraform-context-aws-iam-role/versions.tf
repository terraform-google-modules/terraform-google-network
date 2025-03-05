/*
  Description: Required Versions
  Comments:
    - validated with terraform 0.14.7.28
    - validated with aws 3.32.0
    - validated with null 3.1
*/

terraform {
  required_version = ">= 0.14.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.32.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.1"
    }
  }
}
