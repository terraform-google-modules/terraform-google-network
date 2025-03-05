#!/bin/bash

# not actively used. This is here incase harbor needs to be deployed in the future via cicd

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# shellcheck source=/dev/null
. "$SCRIPT_DIR"/source/common.sh

exit_error="0"

echo_with_timestamp "SECTION" "harbor apply job started..."
script_progress="pipeline_start"

cd "${SCRIPT_DIR}/../" || exit_on_error "Unable to change directory to project root"
ROOT_DIR=$(pwd)
export SCRIPT_DIR ROOT_DIR script_progress exit_error

echo_with_timestamp "SECTION" "Update env-config.yaml with version-manifest.yaml..."
envConfigFile="${ROOT_DIR}/config/env-config.yaml"
versionManifestFile="${ROOT_DIR}/config/version-manifest.yaml"
export envConfigFile versionManifestFile
create_updated_env_file "$envConfigFile" "$versionManifestFile"
echo_with_timestamp "INFO" "Updated env-config.yaml created."

echo_with_timestamp "SECTION" "Setting up environment variables..."
script_progress="env_var_set"
set_env_vars "$envConfigFile"
architecture=""
os_name=$(uname -s | tr "[:upper:]" "[:lower:]")
case $(uname -m) in
    x86_64) architecture="amd64" ;;
    aarch64) architecture="arm64" ;;
    arm64)  architecture="arm64" ;;
    *) exit_on_error "Unable to dtermine architecture" ;;
esac
install_vault_cli
export os_name architecture

echo_with_timestamp "SECTION" "Downloading secure files..."
script_progress="secure_files_download"
chmod +x "${ROOT_DIR}/scripts/tools/download-secure-files-${os_name}-${architecture}"
cp "${ROOT_DIR}/scripts/tools/download-secure-files-${os_name}-${architecture}" "/usr/local/bin/download-secure-files"
download-secure-files

echo_with_timestamp "SECTION" "Setting shoot vars..."
script_progress="shoot_var_set"
SHOOT_NAMESPACE=$(yq e '.contexts[].context.namespace' "${ROOT_DIR}/.secure_files/kuberobot.yaml")
SHOOT_NAME=$(yq e '.shootName' "${ROOT_DIR}/config/env-config.yaml")
envBaseDomain=$(yq e '.envBaseDomain' "${ROOT_DIR}/config/env-config.yaml")
vaultBasePath=$(yq e '.vaultBasePath' "${ROOT_DIR}/config/env-config.yaml")
VAULT_ADDR=$(yq e '.vaultAddr' "${ROOT_DIR}/config/env-config.yaml")
vaultTarget=${harborVaultPathOveride:-"global/harbor"}
vaultValuesJson=""
export SHOOT_NAMESPACE SHOOT_NAME envBaseDomain VAULT_ADDR vaultBasePath vaultTarget vaultValuesJson

echo_with_timestamp "SECTION" "Setting shoot kubeconfig..."
script_progress="kubeconfig_config_set"
export KUBECONFIG="${ROOT_DIR}/.secure_files/kuberobot.yaml"
create_temporary_kubeconfig "$SHOOT_NAMESPACE" "$SHOOT_NAME" "$ROOT_DIR"
export KUBECONFIG="${ROOT_DIR}/kubeconfig.yaml"

echo_with_timestamp "SECTION" "Generate harbor helm vaules.yaml..."
script_progress="harbor_values_gen"
# shellcheck disable=SC2154
generate_vault_token "$vault_role_id" "$vault_secret_id"
setVaultValues "$vaultBasePath" "$vaultTarget"
generate_harbor_creds "$vaultValuesJson"
pushd "${ROOT_DIR}/charts/cluster/harbor" || exit_on_error "Unable to change directory to ${ROOT_DIR}/charts/cluster/harbor"
vaultTemplatePath=${vaultBasePath/\/data/}
value_template_generate_vault "${ROOT_DIR}/config/env-config.yaml" "vault:///${vaultTemplatePath}/global/harbor"

echo_with_timestamp "SECTION" "Generate and apply harbor tech user secret..."
script_progress="generate_harbor_tech_secret"
# shellcheck disable=SC2154
create_harbor_tech_secret "$s3_access_key" "$s3_access_secret" "harbor"
echo_with_timestamp "INFO" "Applying harbor tech user secret..."
kubectl -n harbor apply -f "${ROOT_DIR}/harbor-tech-user.yaml" || exit_on_error "Unable to apply harbor tech user secret"
echo_with_timestamp "INFO" "Cleanup harbor tech user secret..."
rm -f "${ROOT_DIR}/harbor-tech-user.yaml"

echo_with_timestamp "SECTION" "Deploy/Upgrade harbor helm chart..."
script_progress="deploy_helm_chart"
shootHelmChartName="harbor"
helmAction=""
export shootHelmChartName helmAction
manage_helm_chart "$shootHelmChartName" -n harbor -f ./values.yaml
popd || exit_on_error "Unable to change directory to previous directory"

revert_env_file "$envConfigFile"
script_progress="harbor ${helmAction} completed!"

clean_up "$script_progress" "$exit_error"
