#!/bin/sh

apk update
apk add --no-cache curl postgresql-client grep yq jq

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

echo "$VAULT_TOKEN" > /extra-tools/vault-token
cp /usr/bin/curl /extra-tools/curl
cp /usr/bin/psql /extra-tools/bin
cp /bin/grep /extra-tools/grep