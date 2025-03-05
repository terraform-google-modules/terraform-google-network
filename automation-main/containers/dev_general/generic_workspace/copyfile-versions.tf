/*
  Description: All Provider Versions in STE_AUTOMATION
  Comments: added the latest version found in comments
*/

terraform {
  required_providers {
    archive = {
      source  = "hashicorp/archive"
      version = "2.4.2" # v2.7.0
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.49.0" # v5.82.2
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.53.1" # v3.0.2
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.3.0" # v4.14.0
    }
    external = {
      source  = "hashicorp/external"
      version = "2.3.4" # v2.3.4
    }
    http = {
      source  = "hashicorp/http"
      version = "3.4.5" # v3.4.5
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.2" # v2.5.2
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.3" # v3.2.3
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3" # v3.6.3
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0" # v2.2.0
    }
    time = {
      source  = "hashicorp/time"
      version = "0.12.1" # v0.12.1
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5" # v4.0.6
    }
  }
}
