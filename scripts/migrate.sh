#!/usr/bin/env bash
# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# shellcheck shell=bash
# Output Terraform Commands to migrate to new subnet config
set -e
set -o pipefail

if [[ "$MODULE_NAME" ]]; then
  NAME=$(terraform state list | grep "${MODULE_NAME}".google_compute_network.network  | sed 's/.google_compute_network.network//')
  for x in $(terraform state list | grep "${NAME}".google_compute_subnetwork.subnetwork); do
    ID=$(terraform state show "$x" | grep id | grep -v ip_cidr_range | awk '{ print $3 }'| tr -d '"')
    echo "terraform state mv $x ${NAME}.google_compute_subnetwork.subnetwork[\\\"${ID}\\\"]"
  done
else
  echo "MISSING MODULE_NAME: MODULE_NAME env var is required"
  exit 1
fi
