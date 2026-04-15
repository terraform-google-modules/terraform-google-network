/**
 * Copyright 2026 Google LLC
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

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

module "test-vpc-private-access" {
  source       = "../../"
  project_id   = var.project_id
  network_name = "psa-vpc-${random_string.suffix.result}"
  routing_mode = "GLOBAL"

  # Enabling the Private Services Access connection
  enable_private_services_connection = true

  subnets = [
    {
      subnet_name   = "psa-subnet"
      subnet_ip     = "10.0.0.0/24"
      subnet_region = "us-central1"
    }
  ]
}
