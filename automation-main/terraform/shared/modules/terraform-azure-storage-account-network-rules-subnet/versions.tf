/*
  Description: Terraform versioning requirements
*/

terraform {
  required_version = ">= 0.13"
  required_providers {
    null = {
      source = "hashicorp/null"
    }
    external = {
      source = "hashicorp/external"
    }
  }
}
