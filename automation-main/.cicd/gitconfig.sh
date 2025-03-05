#!bin/bash
export ROOT=$(pwd)

usage() {
  echo "Usage:  $0 [-t type]"
  echo
  echo "Configure git client."
  echo
  echo "Options:"
  echo "  -t [ssh|api]"
  echo "         Configure git authentication using ssh or api token."
  echo "         Default is 'api'"
  echo "  -h Show this help message"
}

# Default Values
TYPE=api

# Parse options
while getopts "t:h" opt; do
  case "${opt}" in
    t) TYPE="${OPTARG}" ;;
    h) usage; exit 0 ;;
    *) ;;
  esac
done

echo "$(date) : Setting up git config"
git config --global user.email "$GITLAB_USER_EMAIL"
git config --global user.name "PIPELINE $GITLAB_USER_NAME"

if [ "${TYPE}" = "ssh" ]; then
  echo "$(date): Git SSH Config"
  mkdir -p ~/.ssh
  echo ${DEPLOY_KEY} | base64 -d > ~/.ssh/deploy_key
  chmod 600 ~/.ssh/deploy_key
  echo "Host ${CI_SERVER_HOST}" > ~/.ssh/config
  echo "  StrictHostKeyChecking no" >> ~/.ssh/config
  echo "  UserKnownHostsFile=/dev/null" >> ~/.ssh/config
  echo "  HostName ${CI_SERVER_HOST}" >> ~/.ssh/config
  echo "  User git" >> ~/.ssh/config
  echo "  IdentityFile ~/.ssh/deploy_key" >> ~/.ssh/config
  git remote set-url origin --push git@${CI_SERVER_HOST}:${CI_PROJECT_PATH}.git
else
  git remote set-url origin \
    "https://gitlab-ci-token:${PRE_COMMIT_ACCESS_TOKEN}@${CI_SERVER_HOST}/${CI_MERGE_REQUEST_SOURCE_PROJECT_PATH}.git"
fi
