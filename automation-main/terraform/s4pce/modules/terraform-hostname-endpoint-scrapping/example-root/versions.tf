/*
  Description: Required Terraform Versions
  Comments:
*/

terraform {
  required_version = "1.5.7"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.5.2"
    }
  }
}
