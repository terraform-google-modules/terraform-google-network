virtualenv
=========

This role is used to create a virtualenv with necessary python packages for Ansible executions

Requirements
------------

* python3

Role Variables
--------------

| Variable Name | Default | Description | Value Options |
| ------------- | ------- | ----------- | ------------- |
| virtualenv    | `/usr/local/ansible-runner` | The path of the virtualenv |
| virtualenv_command | `python3 -m venv` | The command to create the virtualenv |
| virtualenv_pip_package_list | `[boto, boto3, botocore]` | List of pip packages to install to the virtualenv |
| virtualenv_set_python_interpreter | `false` | Whether or not to set the ansible_python_interpreter to be the virtualenv |
| virtualenv_ansible_symlink | `true` | Whether or not to create symlinks to use the virtualenv installation of Ansible |

Dependencies
------------

N/A

Example Playbook
----------------

Including an example of how to use this role to create a virtualenv:

    ```yml
      - hosts: all
        become: true
        tasks:

          - name: Include virtualenv role
            ansible.builtin.include_role:
              name: virtualenv
            vars:
              virtualenv_pip_package_list: [boto3, botocore, cryptography]
    ```

Including an example of how to use this role to create a virtualenv, set the python_interpreter, and re-set the python_interpreter to the original interpreter. When modifying the python interpreter of localhost and calling this role from another role, the ansible_python_interpreter should be re-set to the original interpreter to ensure that the remaining playbook executions can function properly

    ```yml
    - name: Get the ansible_python_interpreter
      set_fact:
        original_ansible_python_interpreter: "{{ hostvars['localhost'].ansible_python_interpreter }}"
      delegate_to: localhost
      delegate_facts: true
      run_once: true

    - name: Include virtualenv role
      ansible.builtin.include_role:
        name: virtualenv
        apply:
          delegate_to: localhost
          delegate_facts: true
      run_once: true
      vars:
        virtualenv_set_python_interpreter: true
        virtualenv_pip_package_list: [boto3, botocore, cryptography]

  - name: Restore original python interpreter
      ansible.builtin.include_role:
        name: virtualenv
        tasks_from: set-python-interpreter.yml
        apply:
          delegate_to: localhost
          delegate_facts: true
      run_once: true
      vars:
        wanted_ansible_python_interpreter: "{{ hostvars['localhost'].original_ansible_python_interpreter }}"
    ```

Author Information
------------------

* Ashley Nguyen (<ashley.nguyen01@sap.com>)
