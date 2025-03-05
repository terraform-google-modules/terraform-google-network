/*
  Description: Required Versions
  Comments:
    - N/A
*/

terraform {
  required_version = "1.5.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.49.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.2"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.3"
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
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
  }
}
