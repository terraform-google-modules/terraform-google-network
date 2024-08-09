terraform {
  required_version = ">= 0.13.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.8, < 6"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 3.0, < 6"
    }
  }

  provider_meta "google-beta" {
    module_name = "blueprints/terraform/terraform-google-network:service-networking/v9.1.0"
  }
}
