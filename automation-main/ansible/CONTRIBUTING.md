# Ansible Contributing for Single Tenant Engineering
The following standards are applied to achieve a scalable framework centering on a small core code but still maintaining flexibility through optional customizations and add-ons.  This code should be generally self-sufficient and document external dependencies where required.

## Ansible Terminology
The following is a subset of Ansible terminology commonly used. For an exhaustive list of terms, please follow Hashicorp guidelines.  [LINK](https://docs.ansible.com/ansible/latest/reference_appendices/glossary.html)

* **Playbook** - A YAML file that defines a set of tasks to be executed.
* **Play** - A single block of tasks in a playbook.
* **Task** - A single unit of work in a playbook.
* **Role** - A way of organizing tasks and related files to accomplish a larger goal.
* **Ansible Tags** - A way to mark specific tasks within Ansible.

## Current Ansible Versions
The following table lists the terraform versions that all code should be pinned to.

* **NOTE** - At this time, this is recommended but not enforced.  Enforcement will be implemented in upcoming releases.

* **WARNING**
  * We should be careful about using ansible-core > 2.16 as this won't be supported for RHEL 8 VMs. One of the source code (dnf) shows system_interpreter is using /usr/bin/python3. While Ansible will claim it is using the python3.8 interpreter, the source code will default to /usr/bin/python3. This is due to the system default symlink of: `/usr/bin/python3 -> /usr/bin/python3.6.8`
  * venv setup will not resolve problem as this is a builtin module. Potential fix is to change symlink but will impact system files that rely on python 3.6.8. We should avoid modifying system symlinks.

| Python Package | Version |
| --- | --- |
| ansible-core | 2.16.14 |
| boto3 | 1.36.6 |
| botocore | 1.36.6 |
| passlib | 1.7.4 |
| cffi | 1.17.1 |
| cryptography | 44.0.0 |
| jinja2 | 3.1.5 |
| jmespath | 1.0.1 |
| markupsafe | 3.0.2 |
| packaging | 24.2 |
| pycparser | 2.22 |
| python-dateutil | 2.9.0.post0 |
| pyyaml | 6.0.2 |
| resolvelib | 1.0.1 |
| s3transfer | 0.11.2 |
| setuptools | 75.8.0 |
| six | 1.17.0 |
| urllib3 | 2.3.0 |

| Collection / Module | Version |
| --- | --- |
| amazon.aws | 8.2.2 |
| ansible.posix | 2.0.0 |
| ansible.utils | 5.1.2 |
| ansible.windows | 2.7.0 |
| azure.azcollection | 3.1.0 |
| community.aws | 8.0.0 |
| community.general | 10.3.0 |
| community.sap_libs | 1.4.2 |
| google.cloud | 1.4.1 |

## Ansible Standards
The following are enforced standards.

* <details><summary>Do not rely on "Ansible Tags" for production workflows.</summary><p>

  Explanation: `Ansible Tags` are a troubleshooting and debugging tool. Do not create a workflow that requires the use of tags in a production environment. Tag behavior and application are non-intuitive and may result in unexpected results if not fully understood.  The skill requirements for using `Ansible Tags` reliably in a production environment is relatively high.
  </p></details>

* <details><summary>Break up large codeblocks in playbooks with smaller tagged plays.</summary><p>

  Explanation: Breaking up large codeblocks into smaller related action makes it easier to troubleshoot and test. Applying tags to plays further enhances organization and testing options.
  </p></details>

* <details><summary>Use unique naming to separate global variables from role or job variables </summary><p>

  Example:  <role_name>_<variable>, or <runbook_name>_<variable>

  Explanation: Variable persisist and are unique to the host. Ansible does not automatically cleanup variables. It is important to track variable usage to prevent variable collision.
  </p></details>

* <details><summary>When calling roles or tasks from playbooks, pass the metadata to a role variable, do not rely on global variables at functional levels.</summary><p>

  Explanation: Ansible 'playbook' and 'fact' variables are effectively global in scope. Prevent accidental collisions by passing values to role variables and manipulate those instead.
  </p></details>

* <details><summary>Each Product-Line should provide a default inventory template alongside Playbooks and Roles.</summary><p>

  * All Playbooks within a Product-Line should be written to this default inventory.
  * The Inventory File Template should document all variables and contain example usage values.
  * Regional Teams will use the templates and maintain region specific inventories.

  Explanation: Standardization of workflow practices and Operational expectations. STE has opted to maintain a standard way of tracking variables in use for each business.

* <details><summary>Avoid using "Ignore Errors"</summary><p>

  Explanation: Ignore Errors is indisciriminate and effectively results in non-idempotent code. Additionaly it leaves red colored output that may be mis-interpreted by Operators.
  </p></details>

* <details><summary>Use the Ansible FQCN when calling task modules</summary><p>

  Explanation: "Declaring an FQCN ensures that an action uses code from the correct namespace. This avoids ambiguity and conflicts that can cause operations to fail or produce unexpected results."
  Link: https://ansible.readthedocs.io/projects/lint/rules/fqcn/
  </p></details>

## Ansible Changelogs
* For Playbooks, Changelogs should be included in the Playbook comment header. Use syntax prescribed in the General Contributing Guide.
* For Roles, a file `CHANGELOG-SCS.md` should be included. Use syntax prescribed in the General Contributing Guide.

## Ansible Best Practice
The following are general best practices to be enforced by Code Approvers. Deviations must be documented in code before approval in Merge Requests.
* Resource creation and configuration should be done in roles.
  * `Playbooks` should be used to orchestrate roles.
  * Minimize the amount of configuration done in a playbook.
* Large `Playbooks` should be broken up by `Plays` and noted with `Ansible Tags`.
* New Code should be idempotent, or be sufficiently documented in situations where idempotency is not possible.
* Be cognizant of the stdout of tasks. Make the effort as human readable as possible.
* Keep Roles smaller and single purpose where possible.
* Use Loop Variables to prevent Variable Name Collisions.
## Ansible Layout
TBD
