/*
  Description: Required Terraform Versions
  Comments:
*/

terraform {
  required_version = "1.5.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.49.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.12.1"
    }
    tls = {
      # only needed for the testing process
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
  }
}
