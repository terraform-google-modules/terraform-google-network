/**
 * Copyright 2019 Google LLC
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
  version = "~> 3.3.0"
}

provider "null" {
  version = "~> 2.1"
}

module "vpc" {
  source       = "../../"
  project_id   = var.project_id
  network_name = var.network_name

  subnets = [{
    subnet_name   = "${var.network_name}-subnet-01"
    subnet_ip     = "10.10.10.0/24"
    subnet_region = "us-west1"
  }]

  firewall_rules = [{
    name      = "allow-ssh-ingress"
    direction = "INGRESS"
    ranges    = ["0.0.0.0/0"]
    allow = [{
      protocol = "tcp"
      ports    = ["22"]
    }]
    log_config = {
      metadata = "INCLUDE_METADATA"
    }
  }]
}
