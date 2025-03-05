#!/bin/bash

export VAULT_TOKEN=""

install_vault_cli() {
  echo "Checking Vault CLI Versions..."

  VLT_VERSION=$(curl -s https://releases.hashicorp.com/vault/index.json \
  | jq -r '.versions | keys | .[]' \
  | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' \
  | sort -V \
  | tail -n 1)

  echo "Downloading Vault CLI..."
  curl -O "https://releases.hashicorp.com/vault/${VLT_VERSION}/vault_${VLT_VERSION}_linux_amd64.zip"
  unzip -o "vault_${VLT_VERSION}_linux_amd64.zip"
  mv -f vault /usr/local/bin/
  rm "vault_${VLT_VERSION}_linux_amd64.zip"
  vault --version
}

generate_vault_token() {
  vault_role_id=$1
  vault_secret_id=$2
  echo "Generating Vault token..."
  VAULT_TOKEN=$(vault write auth/approle/login role_id="$vault_role_id" secret_id="$vault_secret_id" -format=yaml | yq e '.auth.client_token')
  export VAULT_TOKEN
  echo "Vault token generated successfully."
}

install_vault_cli
generate_vault_token "$VAULT_ROLE_ID" "$VAULT_SECRET_ID"

declare -A keys
keys["rsa"]="2048 /hostkeys/id_rsa ${VAULT_PATH}/hostkeys/id_rsa"
keys["ecdsa-384"]="384 /hostkeys/id_ecdsa_p384 ${VAULT_PATH}/hostkeys/id_ecdsa_p384"
keys["ecdsa-256"]="256 /hostkeys/id_ecdsa_p256 ${VAULT_PATH}/hostkeys/id_ecdsa_p256"

generate_ssh_key() {
  local key_type=$1
  local key_bits=$2
  local key_path=$3

  if [ ! -f "$key_path" ]; then
    echo "Generating $key_type key with $key_bits bits at $key_path"
    ssh-keygen -t "$key_type" -b "$key_bits" -f "$key_path" -N ""
    chmod 644 "$key_path"
  else
    echo "$key_type key at $key_path already exists."
  fi
}

vault_key_exists() {
  local path=$1
  vault read "$path" > /dev/null 2>&1
  return $?
}

if vault read kv_core_secrets/data/products/ste/dev/gardener/customer4/sftp/config | grep "No value"; then
  echo "Secret exists."
else
  echo "secret no exist"
fi

write_vault_customer_config() {
  local path=$1
  local jsonFile=$2
  vault write "$path" "@${jsonFile}"
}

write_vault_keys() {
  local vaultpath id_rsa id_ecdsa_p384 id_ecdsa_p256 id_rsa_pub id_ecdsa_p384_pub id_ecdsa_p256_pub
  vaultpath=$1
  id_rsa=$(awk '{print "    " $0}' /hostkeys/id_rsa)
  id_ecdsa_p384=$(awk '{print "    " $0}' /hostkeys/id_ecdsa_p384)
  id_ecdsa_p256=$(awk '{print "    " $0}' /hostkeys/id_ecdsa_p256)
  id_rsa_pub=$(awk '{print "    " $0}' /hostkeys/id_rsa.pub)
  id_ecdsa_p384_pub=$(awk '{print "    " $0}' /hostkeys/id_ecdsa_p384.pub)
  id_ecdsa_p256_pub=$(awk '{print "    " $0}' /hostkeys/id_ecdsa_p256.pub)

  cat <<EOF > /hostkeys/hostkey-values.yaml
data:
  id_rsa: |
${id_rsa}
  id_rsa.pub: |
${id_rsa_pub}
  id_ecdsa_p384: |
${id_ecdsa_p384}
  id_ecdsa_p384.pub: |
${id_ecdsa_p384_pub}
  id_ecdsa_p256: |
${id_ecdsa_p256}
  id_ecdsa_p256.pub: |
${id_ecdsa_p256_pub}
EOF
  
  yq e /hostkeys/hostkey-values.yaml -o=json > /hostkeys/hostkey-values.json

  vault write "$vaultpath" "@/hostkeys/hostkey-values.json"
}

# Loop through keys array and perform operations
for key in "${!keys[@]}"; do
  IFS=' ' read -r -a key_properties <<< "${keys[$key]}"
  key_bits=${key_properties[0]}
  key_path=${key_properties[1]}
  key_type=${key%-*}

  generate_ssh_key "$key_type" "$key_bits" "$key_path"

done

keys_exist=$(vault read -format=json "${VAULT_PATH}/hostkeys" 2>/dev/null)

if [ -n "$keys_exist" ]; then
  echo "$key key at ${VAULT_PATH}/hostkeys already exists in Vault."
else
  echo "Writing hostkeys key to Vault..."
  write_vault_keys "${VAULT_PATH}/hostkeys"
  echo "hostkeys written to Vault successfully."
fi

echo "Running pgsql Check..."

check_db_exists() {
  PGPASSWORD=$G_PSQL_PASSWORD psql -h "$PSQL_HOST" -p "$PSQL_PORT" -U "$G_PSQL_USERNAME" -d postgres -tc "SELECT 1 FROM pg_database WHERE datname = '$PSQL_DB';" | grep -q 1
}

create_db() {
  PGPASSWORD=$G_PSQL_PASSWORD psql -h "$PSQL_HOST" -p "$PSQL_PORT" -U "$G_PSQL_USERNAME" -d postgres -c "CREATE DATABASE $PSQL_DB;"
}

check_user_exists() {
  PGPASSWORD=$G_PSQL_PASSWORD psql -h "$PSQL_HOST" -p "$PSQL_PORT" -U "$G_PSQL_USERNAME" -d postgres -tc "SELECT 1 FROM pg_roles WHERE rolname = '$PSQL_USER';" | grep -q 1
}

create_db_user() {
  PGPASSWORD=$G_PSQL_PASSWORD psql -h "$PSQL_HOST" -p "$PSQL_PORT" -U "$G_PSQL_USERNAME" -d postgres -c "CREATE USER $PSQL_USER WITH PASSWORD '$PSQL_PASS';"
}

update_db_user() {
  PGPASSWORD=$G_PSQL_PASSWORD psql -h "$PSQL_HOST" -p "$PSQL_PORT" -U "$G_PSQL_USERNAME" -d postgres -c "ALTER USER $PSQL_USER PASSWORD '$PSQL_PASS';"
}

grant_privileges() {
  PGPASSWORD=$G_PSQL_PASSWORD psql -h "$PSQL_HOST" -p "$PSQL_PORT" -U "$G_PSQL_USERNAME" -d postgres -c "GRANT ALL PRIVILEGES ON DATABASE $PSQL_DB TO $PSQL_USER;"
  PGPASSWORD=$G_PSQL_PASSWORD psql -h "$PSQL_HOST" -p "$PSQL_PORT" -U "$G_PSQL_USERNAME" -d "$PSQL_DB" -c "GRANT ALL PRIVILEGES ON SCHEMA public TO $PSQL_USER;"
  PGPASSWORD=$G_PSQL_PASSWORD psql -h "$PSQL_HOST" -p "$PSQL_PORT" -U "$G_PSQL_USERNAME" -d "$PSQL_DB" -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO $PSQL_USER;"
  PGPASSWORD=$G_PSQL_PASSWORD psql -h "$PSQL_HOST" -p "$PSQL_PORT" -U "$G_PSQL_USERNAME" -d "$PSQL_DB" -c "GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO $PSQL_USER;"
  PGPASSWORD=$G_PSQL_PASSWORD psql -h "$PSQL_HOST" -p "$PSQL_PORT" -U "$G_PSQL_USERNAME" -d "$PSQL_DB" -c "GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO $PSQL_USER;"
  PGPASSWORD=$G_PSQL_PASSWORD psql -h "$PSQL_HOST" -p "$PSQL_PORT" -U "$G_PSQL_USERNAME" -d "$PSQL_DB" -c "ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO $PSQL_USER;"
  PGPASSWORD=$G_PSQL_PASSWORD psql -h "$PSQL_HOST" -p "$PSQL_PORT" -U "$G_PSQL_USERNAME" -d "$PSQL_DB" -c "ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON SEQUENCES TO $PSQL_USER;"
  PGPASSWORD=$G_PSQL_PASSWORD psql -h "$PSQL_HOST" -p "$PSQL_PORT" -U "$G_PSQL_USERNAME" -d "$PSQL_DB" -c "ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON FUNCTIONS TO $PSQL_USER;"
}

if check_user_exists; then
  # Update database user password
  echo "Database user $PSQL_USER already exists. Updating password..."
  # update_db_user
else
  # Create the new database user
  echo "Creating new database user $PSQL_USER..."
  create_db_user
fi

if check_db_exists; then
  echo "Database $PSQL_DB already exists."
else
  echo "Database $PSQL_DB does not exist. Creating database..."
  create_db
  # Grant privileges to the new user on the new database
  echo "Granting privileges to user $PSQL_USER on database $PSQL_DB..."
  grant_privileges
fi

echo "db setup completed successfully."

echo "Checking if customer config values are in Vault..."

config_exists=$(vault read -format=json "${VAULT_PATH}/config" 2>/dev/null)

if [ -n "$config_exists" ]; then
  echo "${VAULT_PATH}/config already exists in Vault."
  else
  echo "${VAULT_PATH}/config Does not exist in Vault."
  
  cat <<EOF > config-values.json
{
  "data": {
    "SFTPGO_DATA_PROVIDER__HOST": "${PSQL_HOST}",
    "SFTPGO_DATA_PROVIDER__NAME": "${PSQL_DB}",
    "SFTPGO_DATA_PROVIDER__PASSWORD": "${PSQL_PASS}",
    "SFTPGO_DATA_PROVIDER__PORT": "${PSQL_PORT}",
    "SFTPGO_DATA_PROVIDER__USERNAME": "${PSQL_USER}",
    "SFTPGO_DEFAULT_ADMIN_PASSWORD": "${DEFAULT_ADMIN_PASSWORD}",
    "SFTPGO_DEFAULT_ADMIN_USERNAME": "admin",
    "SFTPGO_HTTPD__SIGNING_PASSPHRASE": "${SIGNING_PASSPHRASE}"
  }
}
EOF
  
  echo "Writing ${VAULT_PATH}/config to Vault..."
  write_vault_customer_config "${VAULT_PATH}/config" "config-values.json"
  echo "${VAULT_PATH}/config written to Vault successfully."
fi

# copy aws config for s3
customerName=$(echo "$VAULT_PATH" | cut -d'/' -f7)
vaultBasePath1=${VAULT_PATH//\/${customerName}\/sftp/}
vaultBasePath=${vaultBasePath1/\/data/}
awsConfig=$(vault kv get -field=config "${vaultBasePath}/global/aws")
vault kv put "${vaultBasePath}/${customerName}/sftp/aws" config="$awsConfig"
