/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

resource "random_string" "random_suffix" {
  length  = 4
  special = false
  lower   = true
  upper   = false
}

resource "google_folder" "folder1" {
  display_name        = "ci-network1-${random_string.random_suffix.result}"
  parent              = var.folder_id != null ? "folders/${var.folder_id}" : "organizations/${var.org_id}"
  deletion_protection = false
}

resource "google_folder" "folder2" {
  display_name        = "ci-network2-${random_string.random_suffix.result}"
  parent              = var.folder_id != null ? "folders/${var.folder_id}" : "organizations/${var.org_id}"
  deletion_protection = false
}

resource "google_folder" "folder3" {
  display_name        = "ci-network3-${random_string.random_suffix.result}"
  parent              = var.folder_id != null ? "folders/${var.folder_id}" : "organizations/${var.org_id}"
  deletion_protection = false
}

module "project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 18.0"

  name              = "ci-network"
  random_project_id = "true"
  org_id            = var.org_id
  folder_id         = google_folder.folder2.id
  billing_account   = var.billing_account
  deletion_policy   = "DELETE"

  activate_apis = [
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "serviceusage.googleapis.com",
    "vpcaccess.googleapis.com",
    "dns.googleapis.com",
    "networksecurity.googleapis.com",
    "networkconnectivity.googleapis.com",
    "iam.googleapis.com",
  ]
}
