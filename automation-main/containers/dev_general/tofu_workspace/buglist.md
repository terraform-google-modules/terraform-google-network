# Buglist for tofu workspace
Tracking known issues and bugs

## Ansible vs AWS vs RHEL
* **Issue**: Certain combinations of Ansible, AWS Collections, and RHEL result in error when running the following playbook.
    * UPDATE 2025-01-30 - The bug with `ec2_instance_info` is resolved, but this is outstanding with `ansible.builtin.dnf`
    * Link: https://github.com/ansible/ansible/blob/stable-2.18/lib/ansible/modules/dnf.py#L491
    * This appears to specifically an issue with Ansible-Core and the module `ansible.builtin.dnf`
    * Specifically, the `dnf` module is calling the symlink `/usr/bin/python3` which on some systems is linking to python3.6
    * In theory, we can update the symlink to 3.7+, but need to investigate the impact.
    * It appears that pinning ansible-core to `2.16.14` causes `ec2_instance_info` to fail unless the aws collection is also pinned.
    * ```yaml
      - hosts: all
        gather_facts: false
        vars:
          ansible_python_interpreter: /usr/bin/python3
        tasks:
        - name: Create virtualenv
          ansible.builtin.include_role:
            name: virtualenv
          vars:
            virtualenv: /usr/local/ansible
            virtualenv_command: /usr/bin/python3.8 -m venv # <-- This is set to force 3.8. If not, python3 is used which symlinks to python3.6
            virtualenv_install_pip_bool: false
            virtualenv_set_python_interpreter: true
        - name: '[Red Hat] - Update the yum cache'
          ansible.builtin.dnf:
            state: present
            update_cache: true
          register: yum_makecache_results
          failed_when:
            - yum_makecache_results.rc != 0
            - yum_makecache_results.results[0] | regex_search('^There are no enabled repos') | length == 0
          become: true
        - name: Get EC2 Metadata
          ec2_metadata_facts:
          register: ec2_metadata
        - debug: var=ansible_ec2_instance_id
        - name: "Get EC2 Instance Info"
          ec2_instance_info:
            region: "us-gov-west-1"
            instance_ids:
              - "{{ ansible_ec2_instance_id }}"
          register: ec2_instance_info
        - debug: var=ec2_instance_info
      ```
  * Error Message:
    * ```sh
      SyntaxError: future feature annotations is not defined
      ```
* **Hypothesis**:
    * Affects RHEL <=8.x
    * Related to Python?
    * Related to Ansible Version above 2.16.x
    * Related to Collection `amazon.aws` above 8.2.1
* **Remediation**:
  * Pin Versions
    * `ansible.core` == 2.16.14
    * `amazon.aws` == 8.2.2
    * `community.aws` == 8.0.0
  * Retested with
    * `ansible.core` == 2.18.2 # This still errors.
    * `amazon.aws` == 9.1.1 # This causes EC2 to error.
    * `community.aws` == 9.0.0
    * `RHEL` == 8.6, 8.8, 9.2 # Because the OS is symlinked to python3.16 this errors DNF module


## Resolvelib version dependency
* **Issue**: `ansible.core` has a hard version cap on `resolvelib<1.1.0`
* **Hypothesis**: none
* **Remediation**: cap resolvelib version until this is gone.
  * This limit has been raised to 2.0.0 in the latest dev branch: https://github.com/ansible/ansible/pull/84218


## TENV vs Pre-Commit
* **Issue**: TENV will not work with Pre-commit
  * Link: https://github.com/tofuutils/tenv/issues/328
* **Hypothesis**:
* **Remediation**:
  * Use TFENV until this is resolved.

## DNS search up failing inside container
* **Issue**: DNS does not resolve frequently inside the container with a custom docker compose file.
    * ```yaml
      services:
        workspace:
          image: harbor.dev.ste.dev.scs.sap/dev_general/tofu_workspace:latest
          tty: true
            # ... Other stuff here ... #
          networks:
            - vpn
          cap_add:
            - NET_ADMIN
            - NET_RAW
          dns:
            - 10.60.200.15
          dns_search:
            - ibp.dev.sapns2.internal

      networks:
        vpn:
          driver: bridge
      ```
* **Hypothesis**:
  * `Bridged` docker network has conflicting interactions with VPN adapter
* **Remediation**:
  * Use the default `compose.yml` file and do not include `bridge` networks
  * Look into a DNS Container. There's a prepackaged Alpinelinux/unbound. Also see: https://pmig.at/en/tech/guides/docker-dns-server/

## Title
* **Issue**:
* **Hypothesis**:
* **Remediation**:
