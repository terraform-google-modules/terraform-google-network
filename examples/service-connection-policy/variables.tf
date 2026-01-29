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

variable "project_id" {
  description = "Project ID."
  type        = string
}

variable "region" {
  description = "Region (e.g., us-central1)."
  type        = string
  default     = "us-central1"
}

variable "service_class" {
  description = "Service class for the managed service (example value shown in README)."
  type        = string
  default     = "gcp-memorystore-redis"
}
