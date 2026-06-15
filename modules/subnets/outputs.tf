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

output "subnets" {
value = {
    for k, v in google_compute_subnetwork.subnetwork : k => {
      allow_subnet_cidr_routes_overlap  = v.allow_subnet_cidr_routes_overlap
      creation_timestamp                = v.creation_timestamp
      deletion_policy                   = v.deletion_policy
      description                       = v.description
      external_ipv6_prefix              = v.external_ipv6_prefix
      gateway_address                   = v.gateway_address
      id                                = v.id
      internal_ipv6_prefix              = v.internal_ipv6_prefix
      ip_cidr_range                     = v.ip_cidr_range
      ip_collection                     = v.ip_collection
      ipv6_access_type                  = v.ipv6_access_type
      ipv6_cidr_range                   = v.ipv6_cidr_range
      ipv6_gce_endpoint                 = v.ipv6_gce_endpoint
      log_config                        = v.log_config
      name                              = v.name
      network                           = v.network
      private_ip_google_access          = v.private_ip_google_access
      private_ipv6_google_access        = v.private_ipv6_google_access
      project                           = v.project
      purpose                           = v.purpose
      region                            = v.region
      reserved_internal_range           = v.reserved_internal_range
      resolve_subnet_mask               = v.resolve_subnet_mask
      role                              = v.role
      secondary_ip_range                = v.secondary_ip_range
      self_link                         = v.self_link
      send_secondary_ip_range_if_empty  = v.send_secondary_ip_range_if_empty
      stack_type                        = v.stack_type
      state                             = v.state
      subnetwork_id                     = v.subnetwork_id
    }
  }
  description = "The created subnet resources"
}
