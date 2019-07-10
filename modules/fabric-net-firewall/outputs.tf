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

output "internal_ranges" {
  description = "Internal ranges."

  value = {
    enabled = var.internal_ranges_enabled
    ranges  = var.internal_ranges_enabled ? join(",", var.internal_ranges) : ""
  }
}

output "admin_ranges" {
  description = "Admin ranges data."

  value = {
    enabled = var.admin_ranges_enabled
    ranges  = var.admin_ranges_enabled ? join(",", var.admin_ranges) : ""
  }
}

