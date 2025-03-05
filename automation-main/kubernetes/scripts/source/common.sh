#!/bin/bash

echo_with_timestamp() {
    local msg_type=$1 # e.g., INFO, SECTION, ERROR
    local message=$2
    local timestamp
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    local color_reset="\e[0m"
    local purple="\e[35m"
    local orange="\e[33m"
    local color

    # Choose color based on message type
    case "$msg_type" in
    INFO)
        color="\e[36m" # Blue
        echo -e "${color}[${timestamp}] ${msg_type}: ${message}${color_reset}"
        ;;
    SECTION)
        color="\e[32m"
        echo -e "${color}==============================================================================================================${color_reset}"
        echo -e "${color}[${timestamp}] ${message}${color_reset}"
        echo -e "${color}==============================================================================================================${color_reset}"
        ;;
    ERROR)
        # Simulate flashing by alternating colors
        for i in {1..5}; do
            color=$([ $((i % 2)) == 0 ] && echo "$orange" || echo "$purple")
            echo -ne "${color}[${timestamp}] (╯°□°)╯︵ ┻━┻ ${msg_type}: ${message}\r"
            sleep 0.2 # Adjust sleep time to control flash speed
        done
        echo -e "${color_reset}" # Reset to default color after flashing
        ;;
    *)
        echo -e "[${timestamp}] ${msg_type}: ${message}"
        ;;
    esac
}

# Function to exit on error with a message
exit_on_error() {
    local errorMsg exit_error
    exit_error="1"
    errorMsg=${1:-"Pipeline has experienced an error."}
    echo_with_timestamp "SECTION" "Pipeline failed at $script_progress."
    echo_with_timestamp "ERROR" "$errorMsg"
    echo "FAIL" > "${ROOT_DIR}/.${CI_JOB_NAME}.status"
    clean_up "$script_progress" "$exit_error"
}

clean_up() {
    local script_progress exit_code
    script_progress=$1
    exit_code=$2

    if [ "$exit_code" != "1" ]; then
      echo_with_timestamp "SECTION" "Pipeline completed successfully."
      echo "SUCCESS" > "${ROOT_DIR}/.${CI_JOB_NAME}.status"
    fi

    echo_with_timestamp "INFO" "Cleaning up..."

    if [ -d .secure_files ]; then
      echo_with_timestamp "INFO" "Removing .secure_files directory"
      rm -rf .secure_files || echo_with_timestamp "ERROR" "Unable to remove .secure_files directory"
    fi

    if [ -d target-repo ]; then
      echo_with_timestamp "INFO" "Removing target-repo directory"
      rm -rf target-repo || echo_with_timestamp "ERROR" "Unable to remove target-repo directory"
    fi
        
    exit "$exit_code"
}

download_secure_file_binary() {
    local arch os_name bin_filename download_url
    arch=$1
    os_name=$(uname -s | tr "[:upper:]" "[:lower:]")
    bin_filename="download-secure-files-${os_name}-${arch}"
    script_progress="${arch}_download"
    export script_progress

    download_url="https://gitlab.com/gitlab-org/incubation-engineering/mobile-devops/download-secure-files/-/releases/permalink/latest/downloads/${bin_filename}"

    echo_with_timestamp "INFO" "Downloading ${bin_filename}..."
    curl -sS -k -L -H "Accept: application/octet-stream" "$download_url" -o "scripts/tools/${bin_filename}" || exit_on_error "Unable to download ${bin_filename} binary"
    echo_with_timestamp "INFO" "Downloaded ${bin_filename} binary for ${os_name} ${arch}"
}

check_for_secure_store() {
    local git_pat secure_store_api secure_file_name
    git_pat=$1
    secure_store_api=$2
    secure_file_name=$3
    
    secure_store_id=$(curl -s -X GET -H "PRIVATE-TOKEN: $git_pat" "$secure_store_api" | jq --arg name "$secure_file_name" '.[] | select(.name == $name) | .id')

    if [ -z "$secure_store_id" ]; then
      echo_with_timestamp "INFO" "${secure_file_name} not found in project secure store. Creating now..."

      curl -s -X POST -H "PRIVATE-TOKEN: $git_pat" "$secure_store_api" --form "name=${secure_file_name}" --form "file=@${ROOT_DIR}/lib/cpi-secure-file.yaml"  || exit_on_error "Unable to create secure file in project secure store"
    else
      echo_with_timestamp "INFO" "${secure_file_name} found in project secure store."

      checksum1=$(curl -s -X GET -H "PRIVATE-TOKEN: $git_pat" "${secure_store_api}/${secure_store_id}" | jq -r ".checksum" )
      checksum2=$(sha256sum "${ROOT_DIR}/lib/${secure_file_name}" | awk '{print $1}')

      if [ "$checksum1" != "$checksum2" ]; then
        echo_with_timestamp "INFO" "Checksums do not match. Updating secure file in project secure store."
        curl -s -X DELETE -H "PRIVATE-TOKEN: $git_pat" "${secure_store_api}/${secure_store_id}" || exit_on_error "Unable to delete existing secure file in project secure store"
        curl -s -X POST -H "PRIVATE-TOKEN: $git_pat" "$secure_store_api" --form "name=${secure_file_name}" --form "file=@${ROOT_DIR}/lib/cpi-secure-file.yaml" | jq || exit_on_error "Unable to create secure file in project secure store"
      else
        echo_with_timestamp "INFO" "Checksums match. Secure file in project secure store is up to date."
      fi
    fi
}

helm_repo_index() {
    # TODO: handle setting the URL dynamically
    # i.e. "helm repo index ${ROOT_DIR}/public/charts --url https://raw.githubusercontent.com/username/repo/master/public/charts"
    local repo_dir
    repo_dir=$1/public/charts

    echo_with_timestamp "INFO" "Creating Helm repository index..."
    helm repo index "$repo_dir" || exit_on_error "Unable to create Helm repository index"
    echo_with_timestamp "INFO" "Helm repository index created successfully."
}

# Function to check if a Helm release is installed and perform upgrade or install
manage_helm_chart() {
  local release_name namespace chart_path values_files
  release_name="$1"
  shift
  namespace=""  # Default to an empty string
  chart_path="./"  # Fixed chart path
  values_files=()

  # Parse additional arguments for namespace and values files
  while [[ $# -gt 0 ]]; do
    case $1 in
      -n|--namespace)
        namespace="$2"
        shift 2
        ;;
      -f|--values)
        values_files+=("$2")
        shift 2
        ;;
      *)
        echo "Unknown argument: $1"
        return 1
        ;;
    esac
  done

  # Prepare the values files arguments
  local values_args=()
  for file in "${values_files[@]}"; do
    values_args+=("-f" "$file")
  done

  # Check if the Helm release exists
  if [[ -n "$namespace" ]]; then
    helm status "$release_name" -n "$namespace" > /dev/null 2>&1
  else
    helm status "$release_name" > /dev/null 2>&1
  fi

  # shellcheck disable=SC2181
  if [[ $? -eq 0 ]]; then
    echo "Helm release '$release_name' exists. Performing upgrade."
    helmAction=upgrade
    if [[ -n "$namespace" ]]; then
      helm upgrade "$release_name" "$chart_path" -n "$namespace" "${values_args[@]}" --create-namespace || exit_on_error "Unable to upgrade Helm chart"
    else
      helm upgrade "$release_name" "$chart_path" "${values_args[@]}" --create-namespace || exit_on_error "Unable to upgrade Helm chart"
    fi
  else
    echo "Helm release '$release_name' does not exist. Performing install."
    helmAction=install
    if [[ -n "$namespace" ]]; then
      if kubectl get namespace "$namespace" >/dev/null 2>&1; then
        echo "Namespace '$namespace' already exists."
      else
        echo "Namespace '$namespace' does not exist. Creating..."
        kubectl create namespace "$namespace" || exit_on_error "Unable to create namespace"
      fi
      helm install "$release_name" "$chart_path" -n "$namespace" "${values_args[@]}" --create-namespace || exit_on_error "Unable to install Helm chart"
    else
      helm install "$release_name" "$chart_path" "${values_args[@]}" || exit_on_error "Unable to install Helm chart"
    fi
  fi
  export helmAction
# Example call to the function with release name, optional namespace, and values files
# manage_helm_chart helmChartName -n custom-namespace -f ./values1.yaml -f ./values2.yaml
# manage_helm_chart helmChartName -f ./values1.yaml -f ./values2.yaml
}

waitingForReconcile(){
 # wait for it to be configured - around 30 minutes
  local shootName
  shootName=$1
  
  echo "Waiting for the shoot reconcile to finish..."
  for ((i = 0; i < 45; ++i)); do
    # Start with shorter sleep, in order to continue quickly in quick reconcile
    if (( i < 4 )); then
      sleepPeriod=5
    else 
      sleepPeriod=20
    fi
    sleep $sleepPeriod
    status=$(kubectl get shoot "$shootName" -o json | jq '.status')
    echo "$status" | jq '.lastOperation' >state.json
    # print current status
    jq -r '" \(.progress)% \(.description)"' state.json
    if [ "$(jq -r '.state' state.json)" == "Succeeded" ]; then
      echo "cluster reconciled successfully"
      return 0
    fi
  done
}

create_temporary_kubeconfig() {
  local SHOOT_NAMESPACE SHOOT_NAME EXPIRATION_SECONDS TARGET_DIR
  SHOOT_NAMESPACE=$1
  SHOOT_NAME=$2
  TARGET_DIR=$3
  EXPIRATION_SECONDS=${4:-600}

  if [[ ! $SHOOT_NAMESPACE =~ ^garden- ]]; then
    SHOOT_NAMESPACE="garden-$SHOOT_NAMESPACE"
  fi

  kubectl create \
    -f <(printf '{"spec":{"expirationSeconds":%d}}' "$EXPIRATION_SECONDS") \
    --raw /apis/core.gardener.cloud/v1beta1/namespaces/"${SHOOT_NAMESPACE}"/shoots/"${SHOOT_NAME}"/adminkubeconfig | \
    jq -r ".status.kubeconfig" | \
    base64 -d > "${TARGET_DIR}/kubeconfig.yaml"
}

check_previous_job_status(){
  local jobArtifactFile
  jobArtifactFile=$1
  dependencyJob=$2
  curl --location  --header "PRIVATE-TOKEN: ${PIPELINE_PAT}" --output ".${dependencyJob}.status" "https://gitlab.core.sapns2.us/api/v4/projects/${CI_PROJECT_ID}/jobs/artifacts/main/raw/.${dependencyJob}.status?job=${dependencyJob}" || exit_on_error "Unable to download ${dependencyJob} status artifact"
  ls -l "$jobArtifactFile"
  cat "$jobArtifactFile"
  dependencyJobStatus=$(cat "$jobArtifactFile")
  export dependencyJobStatus
  
  if [ "$dependencyJobStatus" != "FAIL" ]; then
    echo_with_timestamp "INFO" "Previous job completed successfully."
  else
    exit_on_error "Required Previous job failed. Exiting..."
  fi
}

install_aws_cli() {
  echo_with_timestamp "INFO" "Checking AWS CLI..."
  if command -v aws &>/dev/null
  then
    echo_with_timestamp "INFO" "AWS CLI is already installed ."
    return
  else
    echo_with_timestamp "AWS" "Vault CLI is not installed. Installing..."
  fi

  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip > /dev/null || exit_on_error "Unable to unzip awscliv2.zip"
  ./aws/install || exit_on_error "Unable to install awscli"
  rm awscliv2.zip
  aws --version || exit_on_error "Failed to run awscli"
}


install_vault_cli() {
  local VLT_VERSION
  echo_with_timestamp "INFO" "Checking Vault CLI..."
  if command -v vault &>/dev/null; then
    installed_version=$(vault --version | awk '{print $2}')
    if [[ "$installed_version" == "$REQUIRED_VAULT_VERSION" ]]; then
      echo_with_timestamp "INFO" "Vault CLI is already installed and at the required version."
      return
    else
      echo_with_timestamp "INFO" "Vault CLI is installed but not at the required version. Installing..."
    fi
  else
    echo_with_timestamp "INFO" "Vault CLI is not installed. Installing..."
  fi

  VLT_VERSION=$(curl -s https://releases.hashicorp.com/vault/index.json \
    | jq -r '.versions | keys | .[]' \
    | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' \
    | sort -V \
    | tail -n 1)

  curl -O "https://releases.hashicorp.com/vault/${VLT_VERSION}/vault_${VLT_VERSION}_linux_amd64.zip"
  unzip -o "vault_${VLT_VERSION}_linux_amd64.zip"
  mv -f vault /usr/local/bin/
  rm "vault_${VLT_VERSION}_linux_amd64.zip"
  vault --version
}

generate_vault_token() {
  local vault_role_id vault_secret_id
  vault_role_id=$1
  vault_secret_id=$2
  echo_with_timestamp "INFO" "Generating Vault token..."
  VAULT_TOKEN=$(vault write auth/approle/login role_id="$vault_role_id" secret_id="$vault_secret_id" -format=yaml | yq e '.auth.client_token')
  VAULT_ROLE_ID="$vault_role_id"
  VAULT_SECRET_ID="$vault_secret_id"
  export VAULT_TOKEN VAULT_ROLE_ID VAULT_SECRET_ID
  echo_with_timestamp "INFO" "Vault token generated successfully."
}

setVaultValues() {
  local vaultBasePath vaultTarget
  vaultBasePath=$1
  vaultTarget=$2
  echo_with_timestamp "INFO" "Setting Vault values..."
  vaultValuesJson=$(vault read -format=json "${vaultBasePath}/${vaultTarget}" | jq -r '.data.data')
  echo_with_timestamp "INFO" "Vault values set successfully."
  export vaultValuesJson
}

awsEnvCredentials() {
  local vaultBasePath vaultTarget
  vaultBasePath=$1
  vaultTarget='global/aws'
  awsCredsFile="/tmp/aws-creds.json"
  echo_with_timestamp "INFO" "Setting AWS credentials..."
  awsCredsContent=$(vault read -format=json "${vaultBasePath}/${vaultTarget}" | jq -r '.data.data')
  printf "${awsCredsContent}" > ${awsCredsFile}
  AWS_ACCESS_KEY_ID=$(grep aws_access_key_id ${awsCredsFile} | awk -F'=' '{print $2}')
  AWS_SECRET_ACCESS_KEY=$(grep aws_secret_access_key ${awsCredsFile} | awk -F'=' '{print $2}')
  rm ${awsCredsFile}
  echo_with_timestamp "INFO" "AWS credentials set successfully."
  export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
  echo "testing"
  env | grep AWS_ACCESS_KEY_ID
  aws s3 ls
}

vaultWriteSecretFile() {
  local vaultBasePath vaultTarget secretFile
  vaultBasePath=$1
  vaultTarget=$2
  secretKey=$3
  secretFile=$4
  echo_with_timestamp "INFO" "Writing secret to Vault..."
  vault write "${vaultBasePath}/${vaultTarget}" "${secretKey}=@${secretFile}" || exit_on_error "Unable to write secret to Vault"
  echo_with_timestamp "INFO" "Secret written to Vault successfully."
}

generate_harbor_creds() {
  local vaultValuesJson argocd_admin_password
  vaultValuesJson=$1
  echo_with_timestamp "INFO" "Set Harbor creds..."
  harborAdminPassword=$(echo "$vaultValuesJson" | jq -r '.HARBOR_ADMIN_PASS')
  redisPassword=$(echo "$vaultValuesJson" | jq -r '.REDIS_PASS')
  pgHost=$(echo "$vaultValuesJson" | jq -r '.PG_HOST')
  pgUser=$(echo "$vaultValuesJson" | jq -r '.PG_ADMIN')
  pgPassword=$(echo "$vaultValuesJson" | jq -r '.PG_PASS')
  pgDatabase=$(echo "$vaultValuesJson" | jq -r '.PG_DBNAME')
  s3_access_key=$(echo "$vaultValuesJson" | jq -r '.REGISTRY_STORAGE_S3_ACCESSKEY')
  s3_access_secret=$(echo "$vaultValuesJson" | jq -r '.REGISTRY_STORAGE_S3_SECRETKEY')
  export harborAdminPassword redisPassword pgHost pgUser pgPassword pgDatabase s3_access_key s3_access_secret
}

generate_argocd_creds() {
  local vaultValuesJson argocd_admin_password
  vaultValuesJson=$1
  echo_with_timestamp "INFO" "Generating Argocd encrypted password..."
  argocd_admin_password=$(echo "$vaultValuesJson" | jq -r '.ARGOCD_ADMIN_PASS')
  # shellcheck disable=SC2016
  argocd_admin_password_encrypted=$(htpasswd -nbBC 10 "" "$argocd_admin_password" | tr -d ':\n' | sed 's/$2y/$2a/')
  echo_with_timestamp "INFO" "Argocd encrypted password generated successfully."
  echo_with_timestamp "INFO" "Set Argocd creds..."
  argocd_admin_username=$(echo "$vaultValuesJson" | jq -r '.ARGOCD_ADMIN')
  argocd_tech_user=$(echo "$vaultValuesJson" | jq -r '.REPO_TECH_USER')
  argocd_tech_pat=$(echo "$vaultValuesJson" | jq -r '.REPO_TECH_PAT')
  export argocd_admin_username argocd_admin_password_encrypted argocd_tech_user argocd_tech_pat
}

# # shellcheck disable=SC2120
# value_template_generate() {
#   local defaultValueTemplateFile templateFile
#   defaultValueTemplateFile=$(pwd)/values-template.yaml
#   templateFileOverride=$1
#   templateFile=${templateFileOverride:-$defaultValueTemplateFile}
#   valuesFile="${templateFile/-template/}"
#   envsubst < "$templateFile" > "$valuesFile"
# }

# shellcheck disable=SC2120
value_template_generate() {
  local defaultValueTemplateFile templateFile envConfig
  defaultValueTemplateFile=$(pwd)/values-template.yaml.tmpl
  envConfig=$1
  templateFileOverride=$2
  templateFile=${templateFileOverride:-$defaultValueTemplateFile}
  valuesFile="${templateFile/-template/}"
  valuesFile="${valuesFile/.tmpl/}"
  gomplate -d envConfig="$envConfig" -f "$templateFile" --missing-key="zero" --experimental > "$valuesFile"
}

# shellcheck disable=SC2120
value_template_generate_vault() {
  local defaultValueTemplateFile templateFile vaultPath envConfig
  defaultValueTemplateFile=$(pwd)/values-template.yaml.tmpl
  envConfig=$1
  vaultPath=$2
  templateFileOverride=$3
  templateFile=${templateFileOverride:-$defaultValueTemplateFile}
  valuesFile="${templateFile/-template/}"
  valuesFile="${valuesFile/.tmpl/}"
  gomplate -d vault="$vaultPath" -d envConfig="$envConfig" -f "$templateFile" --missing-key="zero" --experimental > "$valuesFile"
}

# bulk_value_template_generate() {
#   local valueTempDirTarget findTarget
#   valueTempDirTargets=()
#   findTarget="${1:-values-template.yaml.tmpl}"
#   mapfile -t valueTempDirTargets < <(find "$(pwd)" -name "${findTarget}")
#   for valueTempDirTarget in "${valueTempDirTargets[@]}"; do
#     helmChartDir=${valueTempDirTarget/${findTarget}/}
#     cd "$helmChartDir" || exit
#     value_template_generate
#   done 
# }

bulk_value_template_generate() {
  local valueTempDirTarget findTarget envConfig
  valueTempDirTargets=()
  envConfig=$1
  findTarget="${2:-values-template.yaml.tmpl}"
  mapfile -t valueTempDirTargets < <(find "$(pwd)" -name "${findTarget}")
  for valueTempDirTarget in "${valueTempDirTargets[@]}"; do
    helmChartDir=${valueTempDirTarget/${findTarget}/}
    cd "$helmChartDir" || exit
    value_template_generate "$envConfig" "$findTarget"
  done 
}

create_updated_env_file() {
  local envFile verFile
  envFile=$1
  verFile=$2
  
  cat "$envFile" > "${envFile/.yaml/-bu.yaml}"
  echo "" >> "$envFile"
  cat "$verFile" >> "$envFile"
}

revert_env_file() {
  local envFile envFileBu
  envFile=$1
  envFileBu="${envFile/.yaml/-bu.yaml}"
  mv "$envFileBu" "$envFile"
  rm -f "$envFileBu"
}

commit_changed_back(){
  local CI_PROJECT_URL repo_tech_user repo_tech_pat fileNames
  CI_PROJECT_URL=$1
  repo_tech_user=$2
  repo_tech_pat=$3
  shift 3
  fileNames=("$@")

  git status --porcelain
  if [[ -n $(git status --porcelain) ]]; then
    echo "There are changes to commit."
    for name in "${fileNames[@]}"; do
      echo $name
      git status --porcelain | grep "$name" | while read -r line; do
        file_path=$(echo "$line" | awk '{print $2}')
        git add "$file_path" || exit_on_error "Unable to add $file_path to git"
      done
    done
    git status
    if [[ -n $(git status --porcelain --untracked-files=no | grep -Ev " M" | awk '{print $2}') ]]; then
      git commit -m "Generated values for helm charts" || exit_on_error "Unable to commit changes to git"
      git push "https://$repo_tech_user:$repo_tech_pat@${CI_PROJECT_URL/https:\/\//}.git" main || exit_on_error "Unable to push changes to git"
    else
      echo "No specified files have changes to commit."
    fi
  else
    echo "No changes to commit."
  fi
}

set_env_vars() {
  local envFile
  envFile=$1
  
  # shellcheck disable=SC2046
  eval $(yq e '. | to_entries | .[] | "export \(.key)=\"\(.value)\""' "${envFile}")
  echo_with_timestamp "INFO" "Environment variables set successfully."
}

create_argo_vault_secret() {
  local vault_role_id vault_secret_id VAULT_ADDR ROOT_DIR
  vault_role_id=$1
  vault_secret_id=$2
  VAULT_ADDR=$3
  ROOT_DIR=$4

  cat <<EOF > "${ROOT_DIR}/argocd-vault-plugin-credentials.yaml"
---
apiVersion: v1
kind: Secret
metadata:
  name: argocd-vault-plugin-credentials
  namespace: argocd
stringData:
  AVP_TYPE: vault
  AVP_AUTH_TYPE: approle
  AVP_KV_VERSION: "2"
  AVP_ROLE_ID: ${vault_role_id}
  AVP_SECRET_ID: ${vault_secret_id}
  VAULT_ADDR: ${VAULT_ADDR}
type: Opaque
EOF

}

create_harbor_tech_secret() {
  local s3_access_key s3_access_secret namespace
  s3_access_key=$1
  s3_access_secret=$2
  namespace=$3

  if kubectl get namespace "$namespace" >/dev/null 2>&1; then
    echo "Namespace '$namespace' already exists."
  else
    echo "Namespace '$namespace' does not exist. Creating..."
    kubectl create namespace "$namespace" || exit_on_error "Unable to create namespace"
  fi

  cat <<EOF > "${ROOT_DIR}/harbor-tech-user.yaml"
---
apiVersion: v1
kind: Secret
metadata:
  name: harbor-tech-user
  namespace: harbor
stringData:
  REGISTRY_STORAGE_S3_ACCESSKEY: ${s3_access_key}
  REGISTRY_STORAGE_S3_SECRETKEY: ${s3_access_secret}
type: Opaque
EOF

}


jobLockFile() {
  local job_name
  job_name=$1
  lock_dir=".job_locks"
  lock_file="${lock_dir}/${job_name}.lock"
  if [[ ! -d ${lock_dir} ]]; then
    mkdir -p ${lock_dir} || exit_on_error "Failed to create job lock dir ${lock_dir}"
  fi
  touch "$lock_file" || exit_on_error "Failed to create job lock file ${lock_file}"
  export lock_file
}

create_deploy_config() {
  local input_file envConfig templateFile output_file vpcPeerEnabled
  input_file="$1"
  envConfig="$2"
  templateFile="$3"
  output_file="$4"
  vpcPeerEnabled=""

  gomplate -d customerConfig="$input_file" -d envConfig="$envConfig" -f "$templateFile" --missing-key="zero" --experimental | yq -P e - > "$output_file"

  vpcPeerEnabled=$(yq e '.customerConfig[] | select(.vpcPeering.enabled == true).customerName' "$input_file")
  etdEnabed=$(yq e '.customerConfig[] | select(.etdApp.enabled == true).customerName' "$input_file")

  if [ -n "$etdEnabed" ]; then
    echo_with_timestamp "INFO" "ETD App enabled for customer. Generating ETD App config..."
    gen_customer_vpc_cidr "$input_file" "$output_file"
  fi

  if [ -n "$vpcPeerEnabled" ]; then
    echo_with_timestamp "INFO" "VPC Peer enabled for customer. Generating VPC Peer config..."
    gen_customer_vpc_peer "$input_file" "$output_file"
  fi
 
}

calculate_fs_size_requests() {
  local input_file output_file
  input_file=$1
  output_file=$2

  DEFAULT_SFTPGO="10Gi"
  DEFAULT_ETDAPP="10Gi"

  yq e -o=json '.' $input_file | jq \
      --arg DEFAULT_SFTPGO $DEFAULT_SFTPGO \
      --arg DEFAULT_ETDAPP $DEFAULT_ETDAPP \
      -r '.customerConfig as $customers | (
      ["0Ki"]
      + [
          $customers[] |
          select(.sftpgo.enabled == true) |
          (if .sftpgo.uploadFsSize then .sftpgo.uploadFsSize else $DEFAULT_SFTPGO end)
      ]
      + [
          $customers[] |
          select(.etdApp.enabled == true) |
          (if .etdApp.etdAppFsSize then .etdApp.etdAppFsSize else $DEFAULT_ETDAPP end)
      ]
      )
  ' |
  jq ".[]" |
  sed -e 's/"//'g |
  xargs -I {} numfmt --from iec-i {} |
  tr '\n' '+' | sed 's/+$//' | bc > $output_file
}

check_and_update_fs_size() {
  local input_file output_file
  values_file=$1
  fs_size_requests_file=$2

  current_allocation_size=$(yq \
      '.rook-ceph-cluster.cephClusterSpec.storage.storageClassDeviceSets[0].volumeClaimTemplates[0].spec.resources.requests.storage' \
      $values_file |
      numfmt --from iec-i)
  requested_allocation_size=$(cat $fs_size_requests_file)

  new_allocation_size=$current_allocation_size
  if [[ $requested_allocation_size -gt $current_allocation_size ]]; then
      new_allocation_size=$requested_allocation_size
  fi

  export new_allocation_size=$(numfmt --to iec-i $new_allocation_size)
  yq e -i '.rook-ceph-cluster.cephClusterSpec.storage.storageClassDeviceSets[0].volumeClaimTemplates[0].spec.resources.requests.storage=env(new_allocation_size)' \
      $values_file
}

create_update_cluster_oidc(){
  local provider_arn ca_thumbprint thumprint issuer_url OIDC_CLIENT_ID tags
  provider_arn="$1"
  ca_thumbprint="$2"
  thumprint="$3"
  issuer_url="$4"
  OIDC_CLIENT_ID="$5"
  tags="$6"

  if [[ -n "$provider_arn" ]]; then
    echo_with_timestamp "INFO" "iam oidc provider alraedy exists, updating $provider_arn"
    aws iam update-open-id-connect-provider-thumbprint --open-id-connect-provider-arn "$provider_arn" --thumbprint-list "$ca_thumbprint" "$thumprint" || exit_on_error "Unable to update thumbprint"
    aws iam add-client-id-to-open-id-connect-provider --open-id-connect-provider-arn "$provider_arn" --client-id "$OIDC_CLIENT_ID" || exit_on_error "Unable to add client id"
    aws iam tag-open-id-connect-provider --open-id-connect-provider-arn "$provider_arn" --tags $tags || exit_on_error "Unable to tag oidc provider"
  else
    echo_with_timestamp "INFO" "creating iam oidc provider"
    aws iam create-open-id-connect-provider --url "$issuer_url" --thumbprint-list "$ca_thumbprint" "$thumprint" --client-id-list "$OIDC_CLIENT_ID" --tags $tags | jq -r .OpenIDConnectProviderArn || exit_on_error "Unable to create oidc provider"
  fi
}

configure_irsa_roles(){
  local projectName shootName accountID awsPartition issuer_domain OIDC_CLIENT_ID rolesDir trustJson trustJson policyJson role_files allRolesJsonFile
  rolesDir="$1"
  projectName="$2"
  shootName="$3"
  accountID="$4"
  awsPartition="$5"
  issuer_domain="$6"
  OIDC_CLIENT_ID="$7"
  trustJson=""
  policyJson=""
  roleTags=""
  role_files=""
  
  pushd "$rolesDir" || exit_on_error "Unable to change directory to $rolesDir"

  role_files=$(find "$rolesDir" -type f -name "*.json")
  for role_file in $role_files; do
    rolefile_name=$(basename "$role_file")
    app_name="${rolefile_name/.json/}"
    roleName="${projectName}-${shootName}-${app_name}"
    roleTags="$tags Key=cluster-component,Value=$app_name"
    echo_with_timestamp "INFO" "Configuring IAM role $roleName"
    trustJson=$(jq -n --arg account "$accountID" --arg part "$awsPartition" --arg domain "$issuer_domain" --arg aud "$OIDC_CLIENT_ID" --slurpfile info "$role_file" '{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Principal":{"Federated":"arn:\($part):iam::\($account):oidc-provider/\($domain)"},"Action":"sts:AssumeRoleWithWebIdentity","Condition":{"StringLike":{"\($domain):sub":"system:serviceaccount:\($info[0].namespace):\($info[0].matchname)"}}}]}')
    policyJson=$(jq -c '{Version:"2012-10-17",Statement:.permissions}' "$role_file")
    # role_exists=$(jq --arg rolename "$roleName" '.Roles[]|select(.RoleName==$rolename)' "$allRolesJsonFile")
    # if [[ "$role_exists" == true ]]; then
    if aws iam get-role --role-name "$roleName" > /dev/null 2>&1; then
      echo_with_timestamp "INFO" "iam role already exists, updating"
      aws iam tag-role --role-name "$roleName" --tags $roleTags || exit_on_error "Unable to tag role"
      aws iam update-assume-role-policy --role-name "$roleName" --policy-document "$trustJson" || exit_on_error "Unable to update trust policy"
    else
      echo_with_timestamp "INFO" "iam role does not exist, creating"
      aws iam create-role --role-name "$roleName" --assume-role-policy-document "$trustJson" --tags $roleTags || exit_on_error "Unable to create role"
    fi
    echo_with_timestamp "INFO" "Update role policy..."
    aws iam put-role-policy --role-name "$roleName" --policy-name "$roleName" --policy-document "$policyJson" || exit_on_error "Unable to update role policy"
  done

  popd || exit_on_error "Unable to change directory to previous directory"
}

# Function to extract the subnet mask and ip address from the CIDR range
extract_ip_cidr_val() {
    local cidr_range
    cidr_range=$1
    # Extract the subnet mask (CIDR prefix) and ip address of cidr range
    vpc_subnet_mask=${cidr_range#*/}
    check_subnet_mask "$vpc_subnet_mask"
    ip_address=${cidr_range%%/*}
    echo "The IP address is: $ip_address"
    echo "The subnet mask (CIDR prefix) is: $vpc_subnet_mask"
    export ip_address vpc_subnet_mask
    calc_subnet_cidr "$vpc_subnet_mask"
}

# Function to check the subnet mask value
check_subnet_mask() {
    local subnet_mask
    subnet_mask=$1
    # Check if the subnet mask is between 16 and 26
    if [[ $subnet_mask -ge 16 && $subnet_mask -le 26 ]]; then
        echo "Subnet mask is valid"
    else
        echo "Error: CIDR prefix provided is not valid. Please update to a value that is between 16 and 26."
        exit 1
    fi
}

# Function to calculate az and subnet cidr values
calc_subnet_cidr() {
    local vpc_subnet_mask vpc_host_bits vpc_hosts subnet_hosts subnet_host_bits subnet_host_bits_floor cidr
    vpc_subnet_mask=$1

    # Calculate the number of vpc hosts
    vpc_host_bits=$((32 - vpc_subnet_mask))
    vpc_hosts=$((2 ** vpc_host_bits - 2))

    # Calculate the subnet baseline CIDR prefix
    subnet_hosts=$((vpc_hosts / 9))
    subnet_host_bits=$(echo "l($subnet_hosts)/l(2)" | bc -l )
    subnet_host_bits_floor=$(echo "scale=0; $subnet_host_bits/1" | bc)
    cidr=$((32 - subnet_host_bits_floor))

    # Set subnet cidr prefix values
    subnetCidrVal0="$((cidr))"
    subnetCidrVal1="$((cidr - 1))"
    subnetCidrVal2="$((cidr - 2))"
    export subnetCidrVal0 subnetCidrVal1 subnetCidrVal2

    # echo values for validation
    echo "The number of hosts in the VPC is: $vpc_hosts"
    echo "The minimum number of hosts in each subnet is: $subnet_hosts"
    echo "For $subnet_hosts hosts, the subnet CIDR prefix baseline is: /$cidr"
}

# Functions to calculate values required for shoot to customer vpc peering
# Function to calculate vpc id
get_vpc_id() {
  local vpc_id projectName shootName customer_id filterName
  vpc_id=$1
  projectName=$2
  shootName=$3
  customer_id=$4
  filterName=""

  if [ -z "$customer_id" ]; then
    filterName="shoot--${projectName}--${shootName}"
  else
    filterName="*${customer_id}"
  fi

  if [ "$vpc_id" != null ]; then
    echo "$vpc_id"
  else
    aws ec2 describe-vpcs --filters "Name=tag:Name,Values=${filterName}" --query "Vpcs[*].VpcId" --output=json --no-cli-pager | jq -r '.[]'
  fi
}
# Function to calculate vpc cidr range
get_vpc_cidr() {
  local vpc_id vpc_cidr
  vpc_id=$1
  vpc_cidr=$2

  if [ -z "$vpc_cidr" ]; then
    aws ec2 describe-vpcs --vpc-ids "$vpc_id" --query "Vpcs[*].CidrBlock" --output=json --no-cli-pager | jq -r '.[]'
  else
    echo "$vpc_cidr"
  fi
}
# Function to calculate required vpc route tables for peering
get_rtb() {
  local vpc_id projectName shootName region customer_id filterName awkStatement rtbVarPrefix ZONES FILTER_VALUES ROUTE_TABLE_IDS
  vpc_id=$1
  projectName=$2
  shootName=$3
  region=$4
  customer_id=$5

  filterName=""
  awkStatement=""
  rtbVarPrefix=""

  if [ -z "$customer_id" ]; then
    filterName="shoot--${projectName}--${shootName}-private-${region}"
    awkStatement="'{printf \"%s%s,\", filtername, \$1}'"
    rtbVarPrefix="shoot"
  else
    filterName="${customer_id}"
    awkStatement="'{printf \"*%s*%s,\", filtername, \$1}'"
    rtbVarPrefix="customer"
  fi

  # Step 1: Get unique zones using describe-subnets
  # shellcheck disable=SC2034
  ZONES=$(aws ec2 describe-subnets --filters "Name=vpc-id,Values=${vpc_id}" --query "Subnets[*].AvailabilityZone" --output=json --no-cli-pager | jq -r 'map(.[-1:]) | unique | .[]')

  # Step 2: Build the dynamic filter based on zones
  FILTER_CMD="echo \"\$ZONES\" | awk -v filtername=$filterName $awkStatement | sed 's/,$//'"
  FILTER_VALUES=$(eval "$FILTER_CMD")

  # Step 3: Construct the aws command with dynamic filter and pull route table ids
  ROUTE_TABLE_IDS=$(aws ec2 describe-route-tables --filters "Name=vpc-id,Values=${vpc_id}" "Name=tag:Name,Values=${FILTER_VALUES}" --query "RouteTables[*].RouteTableId" --output=yaml --no-cli-pager)

  # Step 4: create shoot info yaml file
  cat << EOF | yq e 'map({"rtbId": .})'
$ROUTE_TABLE_IDS
EOF
}
# Function to calculate required vpc security group ids for peering
get_sg_id() {
  local vpc_id projectName shootName filterName customer_id
  vpc_id=$1
  projectName=$2
  shootName=$3
  customer_id=$4

  filterName=""

  if [ -z "$customer_id" ]; then
    filterName="shoot--${projectName}--${shootName}-nodes"
  else
    filterName="*${customer_id}-vpc"
  fi

  aws ec2 describe-security-groups --filters "Name=vpc-id,Values=${vpc_id}" "Name=tag:Name,Values=${filterName}" --query "SecurityGroups[*].GroupId" --no-cli-pager | jq -r '.[]'
}

gen_customer_vpc_peer() {
  local customer_config_file deployment_config_file customers customer_id customerVpcValues
  customer_config_file=$1
  deployment_config_file=$2
  customers=""
  
  echo_with_timestamp "SECTION" "Generate customer vpc peering values..."

  customers=$(yq eval '.customerConfig[] | select(.vpcPeering.enabled == true).customerName' "$customer_config_file")

  echo "$customers" | while read -r customer; do
  customer_id=""
  customerVpcId=""
  customerCidrBlock=""
  customerNodeSgId=""
  customerRtbIds=""
  customerVpcValues=""
  echo_with_timestamp "INFO" "Processing customer: $customer"

  customer_id="$customer"
  customerVpcId=$(get_vpc_id null "" "" "$customer_id")
  customerCidrBlock=$(get_vpc_cidr "$customerVpcId" "")
  customerNodeSgId=$(get_sg_id "$customerVpcId" "" "" "$customer_id")
  customerRtbIds=$(get_rtb "$customerVpcId" "" "" "$region" "$customer_id")

  customerVpcValues=$(cat <<EOF | yq -o j | jq -c
customerVpcId: $customerVpcId
customerCidrBlock: $customerCidrBlock
customerNodeSgId: $customerNodeSgId
customerRtbIds:
$customerRtbIds
EOF
)
  customer_vpc_cmd="yq eval '.deploymentConfig[] |= (select(.appName == \"vpcpeering\" and .customer == \"$customer_id\").values += $customerVpcValues )' -i $deployment_config_file"
  eval "$customer_vpc_cmd"
  done

}

gen_customer_vpc_cidr() {
  local customer_config_file deployment_config_file customers customer_id customerVpcValues
  customer_config_file=$1
  deployment_config_file=$2
  customers=""
  
  echo_with_timestamp "SECTION" "Generate customer vpc cidr..."

  customers=$(yq eval '.customerConfig[] | select(.etdApp.enabled == true).customerName' "$customer_config_file")

  echo "$customers" | while read -r customer; do
  customer_id=""
  customerVpcId=""
  customerCidrBlock=""
  echo_with_timestamp "INFO" "Processing customer: $customer"

  customer_id="$customer"
  customerVpcId=$(get_vpc_id null "" "" "$customer_id")
  customerCidrBlock=$(get_vpc_cidr "$customerVpcId" "")

  customerVpcValues=$(cat <<EOF | yq -o j | jq -c
customerVpcCidr: $customerCidrBlock
EOF
)
  customer_vpc_cmd="yq eval '.deploymentConfig[] |= (select(.appName == \"ecs-etd\" and .customer == \"$customer_id\").values += $customerVpcValues )' -i $deployment_config_file"
  eval "$customer_vpc_cmd"
  done

}