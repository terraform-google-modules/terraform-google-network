#!/bin/bash


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# shellcheck source=/dev/null
. "$SCRIPT_DIR"/source/common.sh

exit_error="0"

echo_with_timestamp "SECTION" "argocd apply job started..."
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
vaultTarget=${deployVaultPathOveride:-"global/argocd"}
vaultValuesJson=""
export SHOOT_NAMESPACE SHOOT_NAME envBaseDomain VAULT_ADDR vaultBasePath vaultTarget vaultValuesJson

echo_with_timestamp "SECTION" "Setting shoot kubeconfig..."
script_progress="kubeconfig_config_set"
export KUBECONFIG="${ROOT_DIR}/.secure_files/kuberobot.yaml"
create_temporary_kubeconfig "$SHOOT_NAMESPACE" "$SHOOT_NAME" "$ROOT_DIR"
export KUBECONFIG="${ROOT_DIR}/kubeconfig.yaml"

echo_with_timestamp "SECTION" "Generate argocd helm vaules.yaml..."
script_progress="argocd_values_gen"
# shellcheck disable=SC2154
generate_vault_token "$vault_role_id" "$vault_secret_id"
setVaultValues "$vaultBasePath" "$vaultTarget"
generate_argocd_creds "$vaultValuesJson"
argocdVltPluginVer=$(yq e '.argocdVltPluginVer' "${ROOT_DIR}/config/env-config.yaml")
argocdImageVersion=$(yq e '.argocdImageVersion' "${ROOT_DIR}/config/env-config.yaml")
export argocdVltPluginVer argocdImageVersion
pushd "${ROOT_DIR}/charts/cluster/argocd" || exit_on_error "Unable to change directory to ${ROOT_DIR}/charts/cluster/argocd"
vaultTemplatePath=${vaultBasePath/\/data/}
value_template_generate_vault "${ROOT_DIR}/config/env-config.yaml" "vault:///${vaultTemplatePath}/global/argocd"
# shellcheck disable=SC2154
# yq e ".argo-cd.configs.secret.argocdServerAdminPassword = \"$argocd_admin_password_encrypted\"" -i "${ROOT_DIR}/charts/cluster/argocd/values.yaml"
yq eval-all 'select(fileIndex == 0) * {"argo-cd": {"configs": select(fileIndex == 1)}}' -i "${ROOT_DIR}/charts/cluster/argocd/values.yaml" "${ROOT_DIR}/charts/cluster/argocd/plugins.yaml"

echo_with_timestamp "SECTION" "Deploy/Upgrade argocd helm chart..."
script_progress="deploy_helm_chart"
shootHelmChartName="argocd"
helmAction=""
export shootHelmChartName helmAction
manage_helm_chart "$shootHelmChartName" -n argocd -f ./values.yaml
popd || exit_on_error "Unable to change directory to previous directory"

# echo_with_timestamp "SECTION" "Generate argocd applicationset CRD..."
# script_progress="argocd_appset_crd_gen"
# pushd "${ROOT_DIR}/charts/cluster/applicationsets" || exit_on_error "Unable to change directory to ${ROOT_DIR}/charts/cluster/applicationsets"
# appsetTemplateFile="${ROOT_DIR}/charts/cluster/applicationsets/applicationset-template.yaml"
# value_template_generate "$appsetTemplateFile"
# kubectl -n argocd apply -f "${ROOT_DIR}/charts/cluster/applicationsets/applicationset.yaml" || exit_on_error "Unable to apply applicationset CRD"
# popd || exit_on_error "Unable to change directory to previous directory"

echo_with_timestamp "SECTION" "Generate and apply argocd vault secret..."
script_progress="generate_argocd_vault_secret"
create_argo_vault_secret "$vault_role_id" "$vault_secret_id" "$VAULT_ADDR" "$ROOT_DIR"
echo_with_timestamp "INFO" "Applying argocd vault secret..."
kubectl -n argocd apply -f "${ROOT_DIR}/argocd-vault-plugin-credentials.yaml" || exit_on_error "Unable to apply argocd vault secret"
echo_with_timestamp "INFO" "Cleanup argocd vault secret..."
rm -f "${ROOT_DIR}/argocd-vault-plugin-credentials.yaml"

revert_env_file "$envConfigFile"
script_progress="argocd ${helmAction} completed!"

clean_up "$script_progress" "$exit_error"
