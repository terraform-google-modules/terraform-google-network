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
CMD="terraform state"

while (( "$#" )); do
  # shellcheck disable=SC2221,SC2222
  case "$1" in
    -d|--dry-run)
      DRY_RUN=true
      shift 1
      ;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done

eval set -- "$PARAMS"

if [ ! -e "$(command -v terraform)" ]; then
  echo "can not find terraform"
  exit 1
fi

if [[ "$MODULE_NAME" ]]; then
  NAME=$(${CMD} list | grep "${MODULE_NAME}".google_compute_network.network  | sed 's/.google_compute_network.network//')
  for x in $($CMD list | grep "${NAME}".google_compute_subnetwork.subnetwork); do
    ID=$(${CMD} show "$x" | grep id | grep -v ip_cidr_range | awk '{ print $3 }'| tr -d '"')
    if [[ $DRY_RUN ]]; then
      echo "${CMD} mv $x ${NAME}.google_compute_subnetwork.subnetwork[\\\"${ID}\\\"]"
    else
      ${CMD} mv "$x" "${NAME}".google_compute_subnetwork.subnetwork[\""${ID}"\"]
    fi
  done
else
  echo "MISSING MODULE_NAME: MODULE_NAME env var is required"
  exit 1
fi
