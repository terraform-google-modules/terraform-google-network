/*
  Description: Required Versions
  Comments: N/A
*/

terraform {
  required_version = ">= 0.14.7"

  required_providers {
    time = {
      source = "hashicorp/time"
    }
  }
}
