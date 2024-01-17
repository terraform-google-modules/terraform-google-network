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

# Whenever a new major version of the network module is released, the
# version constraint below should be updated, e.g. to ~> 4.0.
#
# If that new version includes provider updates, validation of this
# example may fail until that is done.

# [START vpc_peering_create]
module "peering1" {
  source        = "terraform-google-modules/network/google//modules/network-peering"
  version       = "~> 9.0"
  local_network = var.local_network # Replace with self link to VPC network "foobar" in quotes
  peer_network  = var.peer_network  # Replace with self link to VPC network "other" in quotes
}
# [END vpc_peering_create]
