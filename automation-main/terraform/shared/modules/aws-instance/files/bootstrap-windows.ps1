<powershell>
<#
  THIS IS A PLACEHOLDER FILE. NEEDS IMPLEMENTATION.


  .Synopsis
    bootstrap file for aws windows instances

  .Description
    Runs as userdata on AWS Instance on first boot:
      - if specified, clones passed repository to target directory and focuses working directory on repo root
      - if specified, executes custom passed single line bash command
      - if specified, either leaves cloned repository on system or cleans up and removes it
#>

#TODO: Implement logging mechanism

# Clone git repository
$GIT_REPOSITORY="${ git_repository }"
$GIT_BRANCH="${ git_branch }"
$GIT_REPOSITORY_PATH="${ git_repository_path }"
$GIT_REPOSITORY_CLEANUP=${ git_repository_cleanup }
$GIT_NAME="${ git_name }"
$GIT_TOKEN="${ git_token }"
#TODO: implement cloning of passed repository if all inputs provided

# Run the Bootstrap
$BOOTSTRAP_COMMAND="${ bootstrap_command }"
#TODO: implement execution of passed command if provided

#TODO: implement cleanup of cloned repository when specified

</powershell>
