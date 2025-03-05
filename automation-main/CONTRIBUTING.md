# General Contributing for Single Tenant Engineering
The following outlines general standards and best practices for the Single Tenant Engineering group. For Language or Tool Specific Contributing guides, please reference the appropriate documents.

## General Terminology
The following is a subset of terminology commonly used.

* **Code** - Any unit of software written to perform a specific task.
* **Contribution** - Any code or documentation submitted for review.
* **Standards** – Guidelines or rules that are enforced.  Code Contribution not meeting these rules will be rejected.
* **Best Practice** – Strongly recommended guidelines enforced by the code approvers. Deviations must be documented in code before approval in Merge Requests.
* **Style** – Suggested guidelines that do not block a Merge Request.
* **Branch** - A separate line of development.
* **Main** - Primary Branch of the code repository. Releases are made from this branch.

## General Standards
* Main Branch is protected and can only be updated by the Merge Request Process.
  * For support purposes, the Main Branch is not considered a stable branch.
  * General support will only be given for releases.
* All code development should be done and tested in branches
* Merge Requests to Main require the requisite number of code approvals.
  * See section [Merge Requests](#merge-requests) for more information.
* Follow Language Specific Contributing Guides.
* This is a global repository, do not include any region-specific information in code.

## External Contributing Standards
* Code Contribution must not contain region specific information.
* Follow General Contributing Guidelines, once a Merge Request is ready for review.  Please open or update a STOI Ticket and link to the Merge Request

## Internal Contributing Standards
* Code Contribution must have a matching Jira Ticket.
* Please link the Jira ticket to the Merge Request.

## Merge Requests
Merge Requests must meet the following criteria for acceptance:
* Review and Approval by minimum 2 Code Reviewers
* Coding Standards Enforced by Code Reviewers
* Best Practices Enforced by Code Reviewers, or documented exception.
* MR Title following Automatic Release Notes Criteria
* MR Description following Automatic Change Log Criteria
* MR Labels applied following Automatic Release Notes Criteria
* Link to Jira ticket included in MR Description
* Link to MR included in Jira Ticket.

## Changelogs
* Changelogs should be updated for each change
  * Changelog format should follow:
    ```md
    # <yyyy-mm-dd> <Contributers>
    * Change1
    * Change2
    * Change...
    ```
  * Example:
    ```md
    # 2024-10-25 i868402
    * Added container to support thing
    ```
* Under the MR Description, please add the Changelog as your in the Issue Summary.

## Release Notes
Release notes are generated for each release. Release notes are generated from Merge Request (MR) titles. To generate presentable release notes, we need to follow best practices outlined below

## Change Logs vs Release Notes
Change Logs are detailed entries of code changes made to a code repository where the audience is technical internal and audits. Changelogs are updated per Merge Request.

Release Notes are user-friendly summaries of changes released in a period. Its audience is external users. Release Notes are updated per Release periods.

## Automatic Release Notes
Release notes are communicated to our stakeholders and the goal of these guides is to automate the process of generating release notes. To automate release notes, please observe the following.

* Merge request titles should reflect the value the change is adding to the codebase.
* Do not include employee ID or other specific information in the title.
* Use labels to classify your change as either `Enhancement`, `Bug`, `Feature`, or `Chore`
* Your MR will be automatically labelled for product lines and language.
* Start MR titles with a capital letter
* MRs with breaking changes should have a [BREAKING CHANGE] at the beginning of title

Examples of MR best practice structure
* An MR for updating SPR releases will look like this:
  * Title: Update defaults for new version of Access Control
  * Tags: [business::spr] [Enhancement]

* An MR for supporting new AWS infrastructure:
  * Title: Add support for enabling s3 lifecycle policies
  * Tags: [business::ibp] [Feature]


## General Best Practice
* Inputs should be restricted to variables files or variables.  Inputs should not be hardcoded.
* Cloud Hypervisor Tagging, Labels, and Names used for Programmatic Metadata should separate from Organizational Tagging and Labels. Resource Names should not be used for Organizational purposes.
* Code should be created from a modular perspective where possible.
* Do not nest functional code blocks or shared modules within each other
