#!/usr/bin/env bash
# shellcheck shell=bash
# Output Terraform Commands to migrate to new subnet config
set -e
set -o pipefail

if [[ "$MODULE_NAME" ]]; then
  NAME=$(terraform state list | grep ${MODULE_NAME}.google_compute_network.network  | sed 's/.google_compute_network.network//')
  for x in $(terraform state list | grep ${NAME}.google_compute_subnetwork.subnetwork); do
    ID=$(terraform state show $x | grep id | grep -v ip_cidr_range | awk '{ print $3 }'| tr -d '"')
    echo "terraform state mv $x ${NAME}.google_compute_subnetwork.subnetwork[\\\"${ID}\\\"]"
  done
else
  echo "MISSING MODULE_NAME: MODULE_NAME env var is required"
  exit 1
fi
