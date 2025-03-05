#!bin/bash
# This script relies on tf docs being available.
# echo "$(date) : Installing Terraform Docs"
# - wget -qO- https://github.com/terraform-docs/terraform-docs/releases/download/v0.18.0/terraform-docs-v0.18.0-linux-amd64.tar.gz | tar xvz -C /usr/local/bin

export ROOT=$(pwd)
terraform-docs --version
which terraform-docs

echo "$(date +'%Y-%m-%d %H:%M:%S') : Running pre-commit for TF Docs"
pre-commit run --all-files -c .pre-commit-tfdocs.yaml || status=$?
git status
git add **/tf-docs.md
if ! git diff-index --quiet HEAD; then
  echo "$(date +'%Y-%m-%d %H:%M:%S') : Writing back tf-docs"
  git commit -m "auto tf-docs CI job" -m "job url: $CI_JOB_URL"
  echo "$(date +'%Y-%m-%d %H:%M:%S') : Commit tf-docs back to source, set FILES_COMMIT_BACK_FLAG=1"
  FILES_COMMIT_BACK_FLAG=1
fi
