#!/usr/bin/env bats

# Copyright 2018 Google LLC
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

# #################################### #
#             Terraform tests          #
# #################################### #

@test "Ensure that Terraform configures the dirs and download the plugins" {

  run terraform init
  [ "$status" -eq 0 ]
}

@test "Ensure that Terraform updates the plugins" {
  run terraform get
  [ "$status" -eq 0 ]
}

@test "Terraform plan, ensure connection and creation of resources" {

  run terraform plan
  [ "$status" -eq 0 ]
  [[ "$output" =~ 7\ to\ add ]]
  [[ "$output" =~ 0\ to\ change ]]
  [[ "$output" =~ 0\ to\ destroy ]]
}

@test "Terraform apply" {

  run terraform apply -auto-approve
  [ "$status" -eq 0 ]
  [[ "$output" =~ 7\ added ]]
  [[ "$output" =~ 0\ changed ]]
  [[ "$output" =~ 0\ destroyed ]]
}

# #################################### #
#             gcloud tests             #
# #################################### #

@test "Test that the network was created with the correct settings" {

  NETWORK_NAME="$(terraform output network_name)"

  run gcloud --project=${PROJECT_ID} compute networks describe ${NETWORK_NAME} --format='get(autoCreateSubnetworks)'[no-pad]
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" = "False" ]]

  run gcloud --project=${PROJECT_ID} compute networks describe ${NETWORK_NAME} --format='get(routingConfig.routingMode)'[no-pad]
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" = "GLOBAL" ]]

}

@test "Test that the subnets were created with the correct settings" {

  NETWORK_NAME="$(terraform output network_name)"

  # test-network-01-subnet-01
  SUBNET_NAME="$(terraform output -json subnets_names | jq '.value[0]' -r)"
  SUBNET_REGION="$(terraform output -json subnets_regions | jq '.value[0]' -r)"
  SUBNET_IP="$(terraform output -json subnets_ips | jq '.value[0]' -r)"
  SUBNET_SECONDARY_RANGE_IP="$(terraform output -json subnets_secondary_ranges | jq '.value[0] | .[0].ip_cidr_range' -r)"
  SUBNET_SECONDARY_RANGE_NAME="$(terraform output -json subnets_secondary_ranges | jq '.value[0] | .[0].range_name' -r)"

  run gcloud --project=${PROJECT_ID} compute networks describe ${NETWORK_NAME} --format='get(subnetworks[0])'[no-pad]
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" = "https://www.googleapis.com/compute/v1/projects/${PROJECT_ID}/regions/${SUBNET_REGION}/subnetworks/${SUBNET_NAME}" ]]

  run gcloud --project=${PROJECT_ID} compute networks subnets describe ${SUBNET_NAME} --region=${SUBNET_REGION} --format='get(ipCidrRange)'[no-pad]
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" = "${SUBNET_IP}" ]]

  run gcloud --project=${PROJECT_ID} compute networks subnets describe ${SUBNET_NAME} --region=${SUBNET_REGION} --format='get(privateIpGoogleAccess)'[no-pad]
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" = "False" ]]

  run gcloud --project=${PROJECT_ID} compute networks subnets describe ${SUBNET_NAME} --region=${SUBNET_REGION} --format='get(secondaryIpRanges[0].ipCidrRange)'[no-pad]
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" = "${SUBNET_SECONDARY_RANGE_IP}" ]]

  run gcloud --project=${PROJECT_ID} compute networks subnets describe ${SUBNET_NAME} --region=${SUBNET_REGION} --format='get(secondaryIpRanges[0].rangeName)'[no-pad]
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" = "${SUBNET_SECONDARY_RANGE_NAME}" ]]

  # test-network-01-subnet-02
  SUBNET_NAME="$(terraform output -json subnets_names | jq '.value[1]' -r)"
  SUBNET_REGION="$(terraform output -json subnets_regions | jq '.value[1]' -r)"
  SUBNET_IP="$(terraform output -json subnets_ips | jq '.value[1]' -r)"
  SUBNET_SECONDARY_RANGE_IP="$(terraform output -json subnets_secondary_ranges | jq '.value[1] | .[0].ip_cidr_range' -r)"
  SUBNET_SECONDARY_RANGE_NAME="$(terraform output -json subnets_secondary_ranges | jq '.value[1] | .[0].range_name' -r)"

  run gcloud --project=${PROJECT_ID} compute networks describe ${NETWORK_NAME} --format='get(subnetworks[1])'[no-pad]
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" = "https://www.googleapis.com/compute/v1/projects/${PROJECT_ID}/regions/${SUBNET_REGION}/subnetworks/${SUBNET_NAME}" ]]

  run gcloud --project=${PROJECT_ID} compute networks subnets describe ${SUBNET_NAME} --region=${SUBNET_REGION} --format='get(ipCidrRange)'[no-pad]
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" = "${SUBNET_IP}" ]]

  run gcloud --project=${PROJECT_ID} compute networks subnets describe ${SUBNET_NAME} --region=${SUBNET_REGION} --format='get(privateIpGoogleAccess)'[no-pad]
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" = "False" ]]

 run gcloud --project=${PROJECT_ID} compute networks subnets describe ${SUBNET_NAME} --region=${SUBNET_REGION} --format='get(secondaryIpRanges[0].ipCidrRange)'[no-pad]
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" = "${SUBNET_SECONDARY_RANGE_IP}" ]]

  run gcloud --project=${PROJECT_ID} compute networks subnets describe ${SUBNET_NAME} --region=${SUBNET_REGION} --format='get(secondaryIpRanges[0].rangeName)'[no-pad]
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" = "${SUBNET_SECONDARY_RANGE_NAME}" ]]

  # test-network-01-subnet-03
  SUBNET_NAME="$(terraform output -json subnets_names | jq '.value[2]' -r)"
  SUBNET_REGION="$(terraform output -json subnets_regions | jq '.value[2]' -r)"
  SUBNET_IP="$(terraform output -json subnets_ips | jq '.value[2]' -r)"

  run gcloud --project=${PROJECT_ID} compute networks describe ${NETWORK_NAME} --format='get(subnetworks[2])'[no-pad]
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" = "https://www.googleapis.com/compute/v1/projects/${PROJECT_ID}/regions/${SUBNET_REGION}/subnetworks/${SUBNET_NAME}" ]]

  run gcloud --project=${PROJECT_ID} compute networks subnets describe ${SUBNET_NAME} --region=${SUBNET_REGION} --format='get(ipCidrRange)'[no-pad]
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" = "${SUBNET_IP}" ]]

  run gcloud --project=${PROJECT_ID} compute networks subnets describe ${SUBNET_NAME} --region=${SUBNET_REGION} --format='get(privateIpGoogleAccess)'[no-pad]
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" = "False" ]]

}

# #################################### #
#      Terraform destroy test          #
# #################################### #

@test "Terraform destroy" {
  run terraform destroy -force
  [ "$status" -eq 0 ]
  [[ "$output" =~ 7\ destroyed ]]
}
