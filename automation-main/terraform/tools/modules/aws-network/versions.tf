/*
  Description: Required Versions
  Comments:
    - N/A
*/

terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.3"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.3"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9"
    }
  }
}
