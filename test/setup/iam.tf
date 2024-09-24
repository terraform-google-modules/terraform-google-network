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

locals {
  int_required_roles = [
    "roles/compute.instanceAdmin",
    "roles/compute.networkAdmin",
    "roles/compute.securityAdmin",
    "roles/iam.serviceAccountUser",
    "roles/vpcaccess.admin",
    "roles/serviceusage.serviceUsageAdmin",
    "roles/dns.admin",
    "roles/resourcemanager.tagAdmin",
    "roles/iam.serviceAccountAdmin",
    "roles/compute.orgFirewallPolicyAdmin",
    "roles/networkconnectivity.hubAdmin",
  ]
}

resource "google_service_account" "int_test" {
  project      = module.project.project_id
  account_id   = "ci-network"
  display_name = "ci-network"
}

resource "google_project_iam_member" "int_test" {
  count = length(local.int_required_roles)

  project = module.project.project_id
  role    = local.int_required_roles[count.index]
  member  = "serviceAccount:${google_service_account.int_test.email}"
}

resource "google_service_account_key" "int_test" {
  service_account_id = google_service_account.int_test.id
}

# due to limitation we need to assign this role at org level otherwise TF throws an error. Issue is only happening when deployedusing APIs like in TF. Console works fine
# b/265054739

resource "google_organization_iam_member" "organization" {
  org_id = var.org_id
  role   = "roles/compute.orgFirewallPolicyAdmin"
  member = "serviceAccount:${google_service_account.int_test.email}"
}


# Roles needed on folders to create firewall policies
resource "google_folder_iam_member" "folder1" {
  for_each = toset(["roles/compute.orgSecurityResourceAdmin", ])
  folder   = google_folder.folder1.id
  role     = each.value
  member   = "serviceAccount:${google_service_account.int_test.email}"
}

# Roles needed on folders to create Attach firewall policies to the folders/org

resource "google_organization_iam_member" "org_permission" {
  org_id = var.org_id
  role   = "roles/compute.orgSecurityResourceAdmin"
  member = "serviceAccount:${google_service_account.int_test.email}"
}

resource "google_folder_iam_member" "folder2" {
  for_each = toset(["roles/compute.orgSecurityResourceAdmin", "roles/compute.orgFirewallPolicyUser"])
  folder   = google_folder.folder2.id
  role     = each.value
  member   = "serviceAccount:${google_service_account.int_test.email}"
}

resource "google_folder_iam_member" "folder3" {
  for_each = toset(["roles/compute.orgSecurityResourceAdmin", "roles/compute.orgFirewallPolicyUser"])
  folder   = google_folder.folder3.id
  role     = each.value
  member   = "serviceAccount:${google_service_account.int_test.email}"
}
