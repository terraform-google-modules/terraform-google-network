#!bin/bash
# ----------
# Sets up Git, runs python script and pushes commit changes.
# Requires Deploy Key set in CICD as CHANGELOG_KEY
# ----------
export ROOT=$(pwd)

echo "DEBUG $(date +'%Y-%m-%d %H:%M:%S') : Running auto-changelog-post.sh"
python3 $ROOT/.cicd/auto-changelog-post.py
pre-commit run --all-files

echo "DEBUG $(date +'%Y-%m-%d %H:%M:%S'): Git SSH Config"
git config --global user.email "ste-pipeline@noreply"
git config --global user.name "ste-pipeline"
git config --system credential.helper store

mkdir -p ~/.ssh
echo ${CHANGELOG_KEY} | base64 -d > ~/.ssh/changelog_key
chmod 600 ~/.ssh/changelog_key
echo "Host ${CI_SERVER_HOST}" > ~/.ssh/config
echo "  StrictHostKeyChecking no" >> ~/.ssh/config
echo "  UserKnownHostsFile=/dev/null" >> ~/.ssh/config
echo "  HostName ${CI_SERVER_HOST}" >> ~/.ssh/config
echo "  User git" >> ~/.ssh/config
echo "  IdentityFile ~/.ssh/changelog_key" >> ~/.ssh/config
git checkout main
git remote set-url origin --push git@${CI_SERVER_HOST}:${CI_PROJECT_PATH}.git

echo "DEBUG $(date +'%Y-%m-%d %H:%M:%S'): Git Commit"
git add **/CHANGELOG-SCS.md
git add **/*_change_blob.json
git commit -m "Changelog Update, $CI_COMMIT_TIMESTAMP SHA: $CI_COMMIT_SHORT_SHA"
git status

echo "DEBUG $(date +'%Y-%m-%d %H:%M:%S'): Git Push"
git push
git status
