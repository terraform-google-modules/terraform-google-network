#!/bin/bash


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# shellcheck source=/dev/null
. "$SCRIPT_DIR"/source/common.sh

exit_error="0"

echo_with_timestamp "SECTION" "helm template generate job started..."
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
envBaseDomain=$(yq e '.envBaseDomain' "${ROOT_DIR}/config/env-config.yaml")
sftpgoRegistry=$(yq e '.sftpgoRegistry' "${ROOT_DIR}/config/env-config.yaml")
sftpgoImageVersion=$(yq e '.sftpgoImageVersion' "${ROOT_DIR}/config/env-config.yaml")
vpc_id=$(yq e '.vpc_id' "${ROOT_DIR}/config/env-config.yaml")
vpc_cidr=$(yq e '.vpc_cidr' "${ROOT_DIR}/config/env-config.yaml")
vaultBasePath=$(yq e '.vaultBasePath' "${ROOT_DIR}/config/env-config.yaml")
VAULT_ADDR=$(yq e '.vaultAddr' "${ROOT_DIR}/config/env-config.yaml")
vaultTarget=${deployVaultPathOveride:-"global/argocd"}
vaultValuesJson=""
install_vault_cli
export envBaseDomain sftpgoRegistry sftpgoImageVersion vpc_id vaultBasePath VAULT_ADDR vaultTarget vaultValuesJson os_name architecture

echo_with_timestamp "SECTION" "Downloading secure files..."
script_progress="secure_files_download"
chmod +x "${ROOT_DIR}/scripts/tools/download-secure-files-${os_name}-${architecture}"
cp "${ROOT_DIR}/scripts/tools/download-secure-files-${os_name}-${architecture}" "/usr/local/bin/download-secure-files"
download-secure-files

echo_with_timestamp "SECTION" "Setting shoot kubeconfig..."
script_progress="kubeconfig_config_set"
export KUBECONFIG="${ROOT_DIR}/.secure_files/kuberobot.yaml"
echo_with_timestamp "INFO" "KUBECONFIG set to ${KUBECONFIG}"

echo_with_timestamp "SECTION" "Setting aws creds..."
script_progress="aws_creds_set"
# shellcheck disable=SC2154
aws_cred_json=$(kubectl get secret "$gardenerInfraSecretName" -o json)
AWS_ACCESS_KEY_ID=$(echo "$aws_cred_json" | jq -r '.data.accessKeyID|@base64d')
AWS_SECRET_ACCESS_KEY=$(echo "$aws_cred_json" | jq -r '.data.secretAccessKey|@base64d')
# shellcheck disable=SC2154
AWS_DEFAULT_REGION="$region"
export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION
echo_with_timestamp "INFO" "AWS creds set."

echo_with_timestamp "SECTION" "Setting aws info..."
script_progress="aws_info_set"
calleridJson=$(aws sts get-caller-identity)
accountID=$(echo "$calleridJson" | jq -r .Account)
awsPartition=$(echo "$calleridJson" | jq -r '.Arn|split(":")[1]')
export accountID awsPartition
echo_with_timestamp "INFO" "AWS info set."

echo_with_timestamp "SECTION" "Generate value files for init charts..."
script_progress="init_values_gen"
# shellcheck disable=SC2154
generate_vault_token "$vault_role_id" "$vault_secret_id"
setVaultValues "$vaultBasePath" "$vaultTarget"
shootNamespace=$(yq e '.contexts[].context.namespace' "${ROOT_DIR}/.secure_files/kuberobot.yaml")
gardenerServerDomain=$(yq e '.clusters[].cluster.server' "${ROOT_DIR}/.secure_files/kuberobot.yaml")
projectName=${shootNamespace/garden-/}
gardenerBaseDomain=${gardenerServerDomain/https:\/\/api.public./}
repo_tech_user=$(echo "$vaultValuesJson" | jq -r '.REPO_TECH_USER')
repo_tech_pat=$(echo "$vaultValuesJson" | jq -r '.REPO_TECH_PAT')
export repo_tech_user repo_tech_pat projectName gardenerBaseDomain
pushd "${ROOT_DIR}/charts/init" || exit_on_error "Unable to change directory to ${ROOT_DIR}/charts/init"
# shellcheck disable=SC2119
bulk_value_template_generate "${ROOT_DIR}/config/env-config.yaml"
popd || exit_on_error "Unable to change directory to previous directory"

echo_with_timestamp "SECTION" "Generate value files for system charts..."
script_progress="system_values_gen"
# shellcheck disable=SC2154
generate_vault_token "$vault_role_id" "$vault_secret_id"
setVaultValues "$vaultBasePath" "$vaultTarget"
repo_tech_user=$(echo "$vaultValuesJson" | jq -r '.REPO_TECH_USER')
repo_tech_pat=$(echo "$vaultValuesJson" | jq -r '.REPO_TECH_PAT')
export repo_tech_user repo_tech_pat
pushd "${ROOT_DIR}/charts/system" || exit_on_error "Unable to change directory to ${ROOT_DIR}/charts/system"
# shellcheck disable=SC2119
bulk_value_template_generate "${ROOT_DIR}/config/env-config.yaml"
popd || exit_on_error "Unable to change directory to previous directory"

echo_with_timestamp "SECTION" "Generate value files for apps charts..."
script_progress="apps_values_gen"
pushd "${ROOT_DIR}/charts/apps" || exit_on_error "Unable to change directory to ${ROOT_DIR}/charts/apps"
shootVpcId=$(get_vpc_id "$vpc_id" "$projectName" "$shootName" "")
shootCidrBlock=$(get_vpc_cidr "$shootVpcId" "$vpc_cidr")
shootNodeSgId=$(get_sg_id "$shootVpcId" "$projectName" "$shootName" "")
shootRtbIds=$(get_rtb "$shootVpcId" "$projectName" "$shootName" "$region" "")
export shootVpcId shootCidrBlock shootNodeSgId shootRtbIds
# shellcheck disable=SC2119
bulk_value_template_generate "${ROOT_DIR}/config/env-config.yaml"
popd || exit_on_error "Unable to change directory to previous directory"

echo_with_timestamp "SECTION" "Generate deployment-config.yaml based on customer-config.yaml..."
script_progress="deploy_config_gen"
pushd "${ROOT_DIR}/config" || exit_on_error "Unable to change directory to ${ROOT_DIR}/config"
create_deploy_config "${ROOT_DIR}/config/customer-config.yaml" "${ROOT_DIR}/config/env-config.yaml" "${ROOT_DIR}/scripts/templates/deployment-config.yaml.tmpl" "${ROOT_DIR}/config/deployment-config.yaml"
popd || exit_on_error "Unable to change directory to previous directory"

echo_with_timestamp "SECTION" "Commit generated values back to git..."
script_progress="git_commit_values"
revert_env_file "$envConfigFile"

fileNames=("values.yaml" "deployment-config.yaml")
commit_changed_back "$CI_PROJECT_URL" "$repo_tech_user" "$repo_tech_pat" "${fileNames[@]}"

script_progress="update helm values.yaml files created!"

clean_up "$script_progress" "$exit_error"
