/*
  Description: Required Versions
  Comments:
    - N/A
*/

terraform {
  required_version = ">= 1.0.4"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.1.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.7.0"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}
