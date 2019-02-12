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

provider "google" {
  project = "${local.project_id}"
  region  = "${var.region}"
}

locals {
  project_id = "network-module"

  required_service_account_project_roles = [
    "roles/compute.networkAdmin",
    "roles/iam.serviceAccountUser",
  ]

  services = [
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
  ]
}

resource "google_project" "network" {
  name            = "${local.project_id}"
  project_id      = "${local.project_id}"
  folder_id       = "${var.folder_id}"
  billing_account = "${var.billing_account}"
}

resource "google_project_service" "network" {
  count              = "${length(local.services)}"
  project            = "${google_project.network.id}"
  service            = "${element(local.services, count.index)}"
  disable_on_destroy = "true"
}

resource "google_service_account" "network" {
  project      = "${google_project.network.id}"
  account_id   = "ci-network"
  display_name = "ci-network"
}

resource "google_project_iam_member" "network" {
  count   = "${length(local.required_service_account_project_roles)}"
  project = "${google_project.network.id}"
  role    = "${element(local.required_service_account_project_roles, count.index)}"
  member  = "serviceAccount:${google_service_account.network.email}"
}

resource "google_service_account_key" "network" {
  service_account_id = "${google_service_account.network.id}"
}
