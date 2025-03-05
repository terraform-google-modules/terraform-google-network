#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# shellcheck source=/dev/null
. "$SCRIPT_DIR"/source/common.sh

exit_error="0"

echo_with_timestamp "SECTION" "AWS IRSA config template generate job started..."
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
# install_vault_cli
export os_name architecture

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
tags="Key=gardener-shoot,Value=${shootName} Key=provisioning-method,Value=gitlabCI Key=role-creation-time,Value=$(date -Is -u)"
export accountID awsPartition tags
echo_with_timestamp "INFO" "AWS info set."

echo_with_timestamp "SECTION" "Setting up IRSA..."
echo_with_timestamp "INFO" "Configure OIDC provider..."
script_progress="oidc_provider_config"
OIDC_CLIENT_ID="sts.amazonaws.com"
shootNamespace=$(yq e '.contexts[].context.namespace' "${ROOT_DIR}/.secure_files/kuberobot.yaml")
echo_with_timestamp "INFO" "Set CA thumbprint..."
ca_thumbprint=$(kubectl get secret "${shootName}.ca-cluster" -o go-template='{{ index .data "ca.crt" | base64decode }}' | openssl x509 -fingerprint -noout | sed 's|.*=||' | tr -d ':')
export shootNamespace ca_thumbprint OIDC_CLIENT_ID
echo_with_timestamp "INFO" "Create shoot kubeconfig..."
create_temporary_kubeconfig "$shootNamespace" "$shootName" "$ROOT_DIR"
export KUBECONFIG="${ROOT_DIR}/kubeconfig.yaml"
echo_with_timestamp "INFO" "Apply CRB for IRSA..."
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: system:service-account-issuer-discovery
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: system:service-account-issuer-discovery
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: Group
  name: system:unauthenticated
EOF
echo_with_timestamp "INFO" "Set oidc issuer..."
api_server_url=$(yq -o=json "$KUBECONFIG" | jq -r '. as $root | $root."current-context" as $ctx | $root.contexts[] | select(.name==$ctx).context.cluster as $cluster | $root.clusters[] | select(.name==$cluster).cluster.server')
issuer_url=$(kubectl get --raw "$api_server_url/.well-known/openid-configuration" | jq -r .issuer)
issuer_domain=${issuer_url/https:\/\//}
echo_with_timestamp "INFO" "Set Issuer thumbprint..."
issuer_thumbprint=$(openssl s_client -showcerts "$issuer_domain:443" < /dev/null 2> /dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' | openssl x509 -fingerprint -noout | sed 's|.*=||' | tr -d ':')
export issuer_thumbprint issuer_domain issuer_url
echo_with_timestamp "INFO" "Check if OIDC Provider already exists..."
provider_arn=$(aws iam list-open-id-connect-providers | jq -r --arg domain "$issuer_domain" '[.OpenIDConnectProviderList[].Arn | select(endswith("/" + $domain))] | first | select(.)')
export provider_arn
echo_with_timestamp "INFO" "Create/Update OIDC Provider..."
# shellcheck disable=SC2086
create_update_cluster_oidc "$provider_arn" "$ca_thumbprint" "$issuer_thumbprint" "$issuer_url" "$OIDC_CLIENT_ID" "$tags"

echo_with_timestamp "SECTION" "Configure Roles for Service Accounts..."
rolesDir="${SCRIPT_DIR}/templates/aws_roles"
projectName=${shootNamespace/garden-/}
export allRolesJson rolesDir projectName
# aws iam list-roles > "${SCRIPT_DIR}/templates/allRoles.json"
configure_irsa_roles "$rolesDir" "$projectName" "$shootName" "$accountID" "$awsPartition" "$issuer_domain" "$OIDC_CLIENT_ID"
revert_env_file "$envConfigFile"

echo_with_timestamp "SECTION" "AWS IRSA Setup Complete..."
script_progress="AWS IRSA Setup Complete!"

clean_up "$script_progress" "$exit_error"