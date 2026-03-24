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

locals {
  hub_network_name   = "found-h-${var.random_string_for_testing}"
  spoke_network_name = "found-s-${var.random_string_for_testing}"
}

module "example" {
  source = "../../../../examples/foundation/hub_and_spoke"

  project_id_hub     = var.project_id
  network_name_hub   = local.hub_network_name
  project_id_spoke   = var.private_service_connect_producer_project_id
  network_name_spoke = local.spoke_network_name
}
