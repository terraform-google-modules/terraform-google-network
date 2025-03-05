/*
  Description: Required Versions
  Comments:
    - validated with terraform 0.12.28
    - validated with aws 2.70.0
    - validated with terraform 0.13.0
    - validated with aws 3.2.0
*/

terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.70"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 2.1"
    }
  }
}
