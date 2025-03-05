#!/bin/bash


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# shellcheck source=/dev/null
. "$SCRIPT_DIR"/source/common.sh

exit_error="0"

echo_with_timestamp "SECTION" "Shoot Apply Job Started..."
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

cd "${SCRIPT_DIR}/../" || exit_on_error "Unable to change directory to project root"
ROOT_DIR=$(pwd)
export SCRIPT_DIR ROOT_DIR script_progress exit_error

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
export os_name architecture

echo_with_timestamp "SECTION" "Downloading secure files..."
script_progress="secure_files_download"

chmod +x "${ROOT_DIR}/scripts/tools/download-secure-files-${os_name}-${architecture}"
cp "${ROOT_DIR}/scripts/tools/download-secure-files-${os_name}-${architecture}" "/usr/local/bin/download-secure-files"
download-secure-files

echo_with_timestamp "SECTION" "Setting admin kubeconfig..."
script_progress="kubeconfig_config_set"
export KUBECONFIG="${ROOT_DIR}/.secure_files/kuberobot.yaml"

echo_with_timestamp "SECTION" "Setting helm vars..."
script_progress="helm_var_set"
pushd "${ROOT_DIR}/config" || exit_on_error "Unable to change directory to ${ROOT_DIR}/config"
shootHelmChartName=$(yq e ".shootHelmChartName" ./env-config.yaml)
shootName=$(yq e ".shootName" ./env-config.yaml)
projectNameSpace=$(yq e ".contexts[].context.namespace" "${ROOT_DIR}/.secure_files/kuberobot.yaml")
projectName=${projectNameSpace/garden-/}
gardenerInfraSecretName=$(yq e ".gardenerInfraSecretName" ./env-config.yaml)
dnsSecretName=$(yq e ".dnsSecretName" ./env-config.yaml)
envBaseDomain=$(yq e ".envBaseDomain" ./env-config.yaml)
shootOwnerEmail=$(yq e ".shootOwnerEmail" ./env-config.yaml)
k8s_version=$(yq e ".k8s_version" ./env-config.yaml)
vpc_id=$(yq e ".vpc_id" ./env-config.yaml)
ubuntu_version=$(yq e ".ubuntu_version" ./env-config.yaml)
manualVpcCidr=$(yq e ".vpcConfig.zonenet" ./env-config.yaml)
vpc_cidr=$(yq e ".vpc_cidr" ./env-config.yaml)
export shootName projectName gardenerInfraSecretName dnsSecretName envBaseDomain shootOwnerEmail k8s_version vpc_id ubuntu_version manualVpcCidr vpc_cidr
popd || exit_on_error "Unable to change directory to previous directory"

echo_with_timestamp "SECTION" "Generate shoot values-overlay.yaml..."
script_progress="values_overlay_generate"
pushd "${ROOT_DIR}/charts/cluster/shoot" || exit_on_error "Unable to change directory to ${ROOT_DIR}/charts/cluster/shoot"
valueTemplateFile="${ROOT_DIR}/charts/cluster/shoot/values-overlay-template.yaml.tmpl"
valueFileRender="${ROOT_DIR}/charts/cluster/shoot/values-overlay.yaml"
if [ "$manualVpcCidr" != null ]; then
    echo "Manual VPC CIDR range is enabled, using the provided CIDR range"
else
    echo "Manual VPC CIDR range is disabled, calculating cidr ranges based on VPC CIDR range"
    extract_ip_cidr_val "$vpc_cidr"
fi
value_template_generate "${ROOT_DIR}/config/env-config.yaml" "$valueTemplateFile"
echo "The subnet CIDR values are:"
cat <<EOF
zonenet:
$(yq e ".provider.aws.zonenet" "$valueFileRender")
EOF

echo_with_timestamp "SECTION" "Deploy/Upgrade shoot helm chart..."
script_progress="deploy_helm_chart"
manage_helm_chart "$shootHelmChartName" -f ./values.yaml -f ./values-overlay.yaml
popd || exit_on_error "Unable to change directory to previous directory"

echo_with_timestamp "SECTION" "Wait for shoot to reconcile..."
script_progress="shoot_reconcile"
if waitingForReconcile "$shootName"; then
  echo_with_timestamp "INFO" "Shoot reconciled successfully"
else
  exit_on_error "Shoot failed to reconcile"
fi

revert_env_file "$envConfigFile"
script_progress="Shoot Apply Job Completed!"

clean_up "$script_progress" "$exit_error"
