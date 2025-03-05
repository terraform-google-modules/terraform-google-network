#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# shellcheck source=/dev/null
. "$SCRIPT_DIR"/source/common.sh

exit_error="0"

echo_with_timestamp "SECTION" "Rook-Ceph cluster configuration job started..."
script_progress="pipeline_start"

cd "${SCRIPT_DIR}/../" || exit_on_error "Unable to change directory to project root"
ROOT_DIR=$(pwd)
export SCRIPT_DIR ROOT_DIR script_progress exit_error

fs_size_requests_file="/tmp/fs-size-requests"

echo_with_timestamp "SECTION" "Deriving the total customer cephfs storage size needs..."
script_progress="calculate_fs_size_requests"
calculate_fs_size_requests "${ROOT_DIR}/config/customer-config.yaml" $fs_size_requests_file || exit_on_error "Unable to derive the total customer cephfs storage size needs."
echo_with_timestamp "INFO" "Total customer cephfs storage size needs derived."

echo_with_timestamp "SECTION" "Checking and updateing cluster OSD volume sizes..."
script_progress="check_and_update_fs_size"
check_and_update_fs_size ${ROOT_DIR}/charts/system/rook/values.yaml $fs_size_requests_file || exit_on_error "Unable to check and update cluster OSD volume sizes."
echo_with_timestamp "INFO" "Ceph-cluster OSD volume sizes checked and updated."

echo_with_timestamp "SECTION" "Update env-config.yaml with version-manifest.yaml..."
envConfigFile="${ROOT_DIR}/config/env-config.yaml"
versionManifestFile="${ROOT_DIR}/config/version-manifest.yaml"
export envConfigFile versionManifestFile
create_updated_env_file "$envConfigFile" "$versionManifestFile"
echo_with_timestamp "INFO" "Updated env-config.yaml created."

echo_with_timestamp "SECTION" "Setting up environment variables..."
script_progress="env_var_set"
set_env_vars "$envConfigFile"
envBaseDomain=$(yq e '.envBaseDomain' "${ROOT_DIR}/config/env-config.yaml")
vaultBasePath=$(yq e '.vaultBasePath' "${ROOT_DIR}/config/env-config.yaml")
VAULT_ADDR=$(yq e '.vaultAddr' "${ROOT_DIR}/config/env-config.yaml")
vaultTarget=${deployVaultPathOveride:-"global/argocd"}
vaultValuesJson=""
install_vault_cli
export envBaseDomain vaultBasePath VAULT_ADDR vaultTarget vaultValuesJson

echo_with_timestamp "SECTION" "Fetch credentials for git commit..."
script_progress="fetch_git_credentials"
# shellcheck disable=SC2154
generate_vault_token "$vault_role_id" "$vault_secret_id"
setVaultValues "$vaultBasePath" "$vaultTarget"
repo_tech_user=$(echo "$vaultValuesJson" | jq -r '.REPO_TECH_USER')
repo_tech_pat=$(echo "$vaultValuesJson" | jq -r '.REPO_TECH_PAT')
export repo_tech_user repo_tech_pat
# shellcheck disable=SC2119

echo_with_timestamp "SECTION" "Commit the updated ceph-cluster OSD volume sizes..."
script_progress="commit_osd_volume_sizes"
fileNames=("charts/system/rook/values.yaml")
commit_changed_back "$CI_PROJECT_URL" "$repo_tech_user" "$repo_tech_pat" "${fileNames[@]}"

script_progress="updated rook helm values.yaml files!"

clean_up "$script_progress" "$exit_error"
