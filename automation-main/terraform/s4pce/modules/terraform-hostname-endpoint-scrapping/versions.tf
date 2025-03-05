/*
  Description: required providers
*/
terraform {
  required_version = ">= 0.14.7"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">= 2.1"
    }
  }
}
