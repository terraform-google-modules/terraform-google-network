#!/bin/bash
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


####################################################################
#   THIS SCRIPT EXPECTS VARIABLES TO BE SET IN YOUR ENVIORNMENT:   #
#   PROJECT_ID
#   CREDENTIALS_PATH
####################################################################

if [[ -z "$PROJECT_ID" || -z "$CREDENTIALS_PATH" ]]; then
    echo "Must provide PROJECT_ID and CREDENTIALS_PATH variables" 1>&2
    exit 1
fi

export CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE=$CREDENTIALS_PATH

# Cleans the workdir
function clean_workdir() {
  echo "Cleaning workdir"
  rm -f terraform.tfstate*
  rm -f .terraform
  rm -f main.tf
  rm -f outputs.tf
}

# Creates the main.tf file for Terraform
function create_main_tf_file() {
  echo "Creating main.tf file"
  touch main.tf
  eval "cat <<EOF
$(<templates/main.tf.tmpl)
EOF" | tee > main.tf
}

# Creates the outputs.tf file
function create_outputs_file() {
  echo "Creating outputs.tf file"
  touch outputs.tf
  eval "cat <<EOF
$(<templates/outputs.tf.tmpl)
EOF" | tee > outputs.tf
}

# Preparing environment
clean_workdir
create_main_tf_file
create_outputs_file

# Call to bats
echo "Test to execute: $(bats integration.bats -c)"
bats integration.bats

export CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE=""
unset CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE

# Clean the environment
clean_workdir
echo "Integration test finished"
