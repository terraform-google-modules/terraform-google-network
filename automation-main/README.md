# automation

NOTE - Please report any broken links or relative paths to [STOI Board](https://jira.tools.sap/secure/RapidBoard.jspa?rapidView=44311&projectKey=STOI&view=detail#)

This is the official code repository for Sovereign Cloud Single Tenant Engineering (STE). This repository is intended to be a central location for all automation code, including Terraform, Ansible, and other automation tools required to run and deploy Single Tenant Solutions.

## Release Management

This repository will use release tags as part of it's release management process.  The release tags will be in the format of `vYYYY.MM.Patch` where `YYYY` is the year, `MM` is the Month, and `Patch` is the patch version.  The release tags will be used to identify the version of the code that is deployed to the environment.

For more detailed instructions on using release tags please see the [Release Management](https://wiki.one.int.sap/wiki/display/SAPSCS/STE+Release+Strategy) page.


## Usage
### As a Local Repository
This repository can be cloned locally. It contains no outside dependencies.

* To clone the main branch:
  ```sh
  git clone https://gitlab.core.sapns2.us/scs/ste/automation.git
  ```
* To clone a specific release tag:
  ```sh
  git clone --depth 1 --branch ___release_tag___ https://gitlab.core.sapns2.us/scs/ste/automation.git
  ```
  * where `depth 1` will only clone the latest commit and not the entire history.
  * where `___release_tag___` is the release tag you want to clone.


### As a submodule.
This repository can be added as a submodule to another repository.  This is the recommended method for regional `Environment` repositories.

* **Setup**
  * Create your `Environment` repository.
  * Add this repository as a submodule.
    ```sh
    git submodule add https://gitlab.core.sapns2.us/scs/ste/automation.git
    ```
  * To pin the submodule to a specific branch, use the following command:
    ```sh
    git submodule add -b ___release_tag___ https://gitlab.core.sapns2.us/scs/ste/automation.git
    ```
  * Push your changes to your `Environment` repository.

* **Update Branch Pin**
  * To update the release tag of the submodule.
  * Open the file `.gitmodules` in the root of your `Environment` repository.
  * Update the `branch` value to the new release tag.
  * Push your changes to your `Environment` repository.

* **Usage**
  1. Clone your `Environment` repository with submodules
      * `git clone --recurse-submodules https://your.server/your-repo.git`


### Terraform and Relative Paths
Any occurance of the word `EXAMPLE_SOURCE` should be replaced with the relative path to the local folder containing the repository.  This can be done with a simple find and replace.

* Example:
  ```sh
  export STE_AUTOMATION=/path/to/local/repository
  find ./ -type f -exec sed -i '' -e 's|EXAMPLE_SOURCE|${STE_AUTOMATION}|g' {} \;
  ```

Specific instructions may be found in the README.md of the Terraform Module.


### Ansible and Paths
Update your [Ansible Configuration](https://docs.ansible.com/ansible/latest/reference_appendices/config.html) paths to include the following paths:

* Example:
  ```sh
  export STE_AUTOMATION=/path/to/local/repository
  ```
  ```ini
  [defaults]
  roles_path = $STE_AUTOMATION/ansible/roles/ibp:$STE_AUTOMATION/ansible/roles/s4pce:$STE_AUTOMATION/ansible/roles/spr:$STE_AUTOMATION/ansible/roles/shared
  ```
  ```sh
  # Commands to Validate
  ansible-config dump | grep DEFAULT_ROLES_PATH
  ansible-playbook $STE_AUTOMATION/ansible/playbooks/tools/test-ste-roles-path.yml
  ```

Alternatively the environment variables can be used: `ANSIBLE_ROLES_PATH`

## Collaboration
### Support
Active Support will be provided for up to `N-1` number of major versions from the latest release. Support will include bug fixes, feature requests, and general assistance.

### Bugs and Issues
To report bugs and issues please submit tickets to the [STOI Board](https://jira.tools.sap/secure/RapidBoard.jspa?rapidView=44311&projectKey=STOI&view=detail#).  Instructions on how to submit a ticket can be found [here](https://wiki.one.int.sap/wiki/display/SAPSCS/Support+Request+Process)


### Feature Requests
Large efforts or requests must be submitted through the portfolio process. Please contact [David Welz](mailto:david.welz@sap.com) Or [Christoph Eichin](mailto:christoph.eichin@sap.com) to get the request form.


### Contributing Process
For code contributions, please submit a merge request using the provided MR template. Merge Request must pass minimum validation checks including a log of the validation checks. The MR will be reviewed by the STE team and merged if approved.

Please find a full list of contribution guidelines here:  TBD - CONTRIBUTION GUIDELINES
* [General Contribution Guidelines](./CONTRIBUTING.md)
* [Terraform Contribution Guidelines](./terraform/CONTRIBUTING.md)
* [Ansible Contribution Guidelines](./ansible/CONTRIBUTING.md)
* [Docker Contribution Guidelines](./containers/CONTRIBUTING.md)
* [Kubernetes Contribution Guidelines](./kubernetes/CONTRIBUTING.md)

### Use of Pre-Commit
[pre-commit](https://pre-commit.com) is used in this repository to make sure
that all commits that are made meet the coding standards/style and that it is
enforced. CI will also enforce the exact same standards.

* <details><summary>Pre-Commit Installation</summary><p>

  * For macOS using Homebrew:
    ```
    brew install pre-commit
    pre-commit install
    ```
</p></details>

* <details><summary>Pre-Commit Usage</summary><p>

  * To run on all files. Use caution because this will run on all files in the repository:
    ```
    pre-commit run --all-files
    ```
  * To run pre-commit on a specific file:
    ```
    pre-commit run --files <file>
    ```
  * To Commit Changes to the repository:
    ```
    git add .
    git commit -m "Commit Message"
    ```
</p></details>

### Use of TF-Docs
TF-Docs is enforced automatically by the CI/CD pipeline for any Merge Requests involving terraform code.  It is used to generate documentation for Terraform code.  The documentation is generated in each terraform folder with the output file `tf-docs.md`.  The documentation is generated in markdown format and can be viewed in GitLab.

### Automatic Labels
A subset of labels are automatically applied to Merge Requests based on the contents of the Merge Request.  The labels are used to identify technology used and product modified.

### Automatic Changelogs
Changelogs will be automatically generated by the pipeline using information gathered in the Merge Request Description. Changelogs should not be edited directly. See Repository Maintenance below for more information.

## Repository Maintenance
* **Tokens**
  The CI/CD pipeline uses tokens to authenticate to the GitLab API.  These tokens will expire annually.
    * `PRE_COMMIT_ACCESS_TOKEN` is used by Pre-Commit and TF-Docs to make changes. This token will need write-repository and needs to be updated under CI/CD -> Variables.
    * Pipeline `deploy_key` - does not expire.  It is used by the mirror pipeline to writeback changes.
    * Pipeline `git_pat` - expires annually. It is used by the mirror pipeline to read source repositories (shared). This token needs read_repository and needs to be updated under CI/CD -> Variables.

* **Harbor Robot**
  * The CI/CD pipeline uses a Harbor Robot to authenticate to the Harbor Registry to pull specified container images.  This readonly robot must have it's credentials added to the CI/CD Variable `DOCKER_AUTH_CONFIG`.  For further instructions please see the [Gitlab Help](https://docs.gitlab.com/ee/ci/docker/using_docker_images.html#configure-a-job)

* **Cutover**
  * To configure, start, or stop mirrored repositories.  Please make changes to the [configuration json](https://gitlab.core.sapns2.us/scs/ste/pipeline-repo-mirror/-/blob/main/config/config-repos.json?ref_type=heads)
  * NOTE: Mirrored repositories do not run the CI/CD pipeline. See below to enable it once mirroring has been removed.
    * To change TF-Docs targets, please make changes to the `exclude` line in the file [.pre-commit-tfdocs.yaml](https://gitlab.core.sapns2.us/scs/ste/automation/-/blob/main/.pre-commit-tfdocs.yaml?ref_type=heads)
    * To change the Precommit targets, please make changes to the `exclude` line in the file [.pre-commit-config.yaml](https://gitlab.core.sapns2.us/scs/ste/automation/-/blob/main/.pre-commit-config.yaml?ref_type=heads)

* **CI/CD Pipeline**
  * Pre-Commit and Terraform Docs - This runs automatically on any Merge Request (updates) and is required to pass before Merge.
  * Label-Cleanup - This only runs on request when the variable `CLEANUP_LABELS` is set to `true`.  This will remove any `status::*` labels from Merged Merge Requests.
  * Releases - This runs when a semantic tag is created with the format `v[YYYY].[MM].[patch_number]` (e.g. `v2024.10.1`) to generate Release Notes.

* **Automatic Changelog Pipeline**
  * Changelogs are applied using a two part pipeline. The pre-merge pipeline generates a "change blob" pulling information from the Merge Request and related metadata.  The post-merge pipeline will then apply the "change blob" into changelogs in the appropriate place.
  * An Access Token is required for pre-merge pipeline
    * Pipeline requires read MR permissions.
    * Currently using `PRE_COMMIT_ACCESS_TOKEN`
  * A Deploy Key is required for the post-merge pipeline
    * Generate SSH Key
    * Add to Deploy Keys
    * Convert to Base64
    * Add private key to pipeline variable "CHANGELOG_KEY"
    * Add Repository Permission "Push to Protected Branch" for the Deploy Key
  * Update/Adjust Input Variables in both `auto-changelog-post.py` and `auto-changelog-pre.py`



* **Releases**
  * To create a release, On the [tags](https://gitlab.core.sapns2.us/scs/ste/automation/-/tags) page, create a `New Tag` from the `main` branch using the semantic version format `v[YYYY].[MM].[patch_number]` (e.g. `v2024.10.1`). Add a summary message to the tag e.g. Enhancements, Improvements and Bug fixes.
  * Release notes are auto-generated from Merge Requests and labels. For the recommended Merge Request practices, please review the [Best Practices Documentation](https://sap.sharepoint.com/:w:/r/teams/SingleTenantEngineeringTeam/Shared%20Documents/General/Single%20Tenant%20Coding%20Standards%20and%20Best%20Practice.docx?d=wb8758c46aa214d568c26e795b3660ff9&csf=1&web=1&e=mVJ8Mo&nav=eyJoIjoiNTE4MjAyNTkyIn0)
  * Release notes generated can be found on the [Releases Page](https://gitlab.core.sapns2.us/scs/ste/automation/-/releases). Review the auto-generated notes and modify as needed.

## Contacts
* STE Team Distribution List: [DL Sovereign Cloud - TE STE employees](mailto:DL_6595801D801E4C0107A22249@global.corp.sap)
* Feature Requests: [David Welz](mailto:david.welz@sap.com) Or [Christoph Eichin](mailto:christoph.eichin@sap.com)
* Bugs and Issues: [STOI Board](https://jira.tools.sap/secure/RapidBoard.jspa?rapidView=44311&projectKey=STOI&view=detail#)

## License
The contents of this repository is SAP Classification: Internal
