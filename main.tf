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

/******************************************
	VPC configuration
 *****************************************/
resource "google_compute_network" "network" {
  name                    = "${var.network_name}"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
  project                 = "${var.project_id}"
}

/******************************************
	Subnet configuration
 *****************************************/
resource "google_compute_subnetwork" "subnetwork" {
  count = "${length(var.subnets)}"

  name                     = "${lookup(var.subnets[count.index], "subnet_name")}"
  ip_cidr_range            = "${lookup(var.subnets[count.index], "subnet_ip")}"
  region                   = "${lookup(var.subnets[count.index], "subnet_region")}"
  private_ip_google_access = "${lookup(var.subnets[count.index], "subnet_private_access", "false")}"
  enable_flow_logs         = "${lookup(var.subnets[count.index], "subnet_flow_logs", "false")}"
  network                  = "${google_compute_network.network.name}"
  project                  = "${var.project_id}"

  secondary_ip_range = "${var.secondary_ranges[lookup(var.subnets[count.index], "subnet_name")]}"
}

/******************************************
	Shared VPC
 *****************************************/
resource "google_compute_shared_vpc_host_project" "shared_vpc_host" {
  count   = "${var.shared_vpc_host == "true" ? 1 : 0}"
  project = "${var.project_id}"
}
