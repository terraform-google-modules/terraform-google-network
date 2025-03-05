#!bin/bash
# ----------
# Sets up git and env variables. Runs python script and pushes commit changes.
# ----------

export ROOT=$(pwd)
echo "DEBUG $(date +'%Y-%m-%d %H:%M:%S') : Running auto-changelog-pre.sh"

git fetch origin $CI_MERGE_REQUEST_SOURCE_BRANCH_NAME
git fetch origin $CI_MERGE_REQUEST_TARGET_BRANCH_NAME
export FILE_DIFFS=$(git diff --name-only --no-color origin/$CI_MERGE_REQUEST_SOURCE_BRANCH_NAME..origin/$CI_MERGE_REQUEST_TARGET_BRANCH_NAME)
# echo "DEBUG FILE DIFFS: $FILE_DIFFS"

python3 $ROOT/.cicd/auto-changelog-pre.py
if [[ $? -ne 0 ]]; then
  echo "DEBUG $(date +'%Y-%m-%d %H:%M:%S') : Running auto-changelog-pre.py failed, please address"
  exit 1
fi

git status
git add **/*_change_blob.json
if ! git diff-index --quiet HEAD; then
  echo "DEBUG $(date +'%Y-%m-%d %H:%M:%S') : Writing back changelog_blob"
  git commit -m "changelog_blob CI job" -m "job url: $CI_JOB_URL"
  echo "DEBUG $(date +'%Y-%m-%d %H:%M:%S') : Commit updated changelog_blob back to source, FILES_COMMIT_BACK_FLAG=1"
  FILES_COMMIT_BACK_FLAG=1
fi
