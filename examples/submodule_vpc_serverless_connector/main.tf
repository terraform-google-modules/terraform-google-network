/**
 * Copyright 2021 Google LLC
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
  version = "~> 3.62"
}

provider "google-beta" {
  version = "~> 3.62"
}

module "serverless-connector" {
  source     = "../../modules/vpc-serverless-connector-beta"
  project_id = var.project_id
  vpc_connectors = [{
    name            = "central-serverless"
    region          = "us-central1"
    subnet_name     = var.subnet_name
    host_project_id = var.host_project_id
    machine_type    = "e2-standard-4"
    min_instances   = 2
    max_instances   = 7
  }]
}
