#!/bin/bash
#
# Filename: bootstrap-linux.sh
# Synopsis: bootstrap file for aws linux instances
# Description: Runs as userdata on AWS Instance on first boot
#   - if specified, clones passed repository to target directory and focuses working directory on repo root
#   - if specified, executes custom passed single line bash command
#   - if specified, either leaves cloned repository on system or cleans up and removes it

logger -s "Terraform : Started bootstrap."

# Clone git repository
GIT_REPOSITORY="${ git_repository }"
GIT_BRANCH="${ git_branch }"
GIT_REPOSITORY_PATH="${ git_repository_path }"
GIT_REPOSITORY_CLEANUP=${ git_repository_cleanup }
GIT_NAME="${ git_name }"
GIT_TOKEN="${ git_token }"
if [[ !( -z $GIT_REPOSITORY || -z $GIT_BRANCH || -z $GIT_REPOSITORY_PATH || -z $GIT_REPOSITORY_CLEANUP || -z $GIT_NAME || -z $GIT_TOKEN ) ]]; then
  rm -rf $GIT_REPOSITORY_PATH
  logger -s "Terraform : Clone git repository '$GIT_REPOSITORY' to path '$GIT_REPOSITORY_PATH'"
  git clone -b $GIT_BRANCH "https://$GIT_NAME:$GIT_TOKEN@$GIT_REPOSITORY" $GIT_REPOSITORY_PATH
  cd $GIT_REPOSITORY_PATH
fi

# Run the Bootstrap
BOOTSTRAP_COMMAND="${ bootstrap_command }"
if [[ ! -z $BOOTSTRAP_COMMAND ]]; then
  CONTEXT=$(pwd)
  logger -s "Terraform : Executing command '$BOOTSTRAP_COMMAND' from context '$CONTEXT'"
  eval $BOOTSTRAP_COMMAND
fi

# Cleanup git repository
if [[ !( -z $GIT_REPOSITORY || -z $GIT_BRANCH || -z $GIT_REPOSITORY_PATH || -z $GIT_REPOSITORY_CLEANUP || -z $GIT_NAME || -z $GIT_TOKEN ) ]]; then
  if $GIT_REPOSITORY_CLEANUP; then
    cd
    logger -s "Terraform : Removing cloned git repository from system upon bootstrap completion '$GIT_REPOSITORY_PATH'"
    rm -rf $GIT_REPOSITORY_PATH
  fi
fi

logger -s "Terraform : Finished bootstrap."
