vault-auth
==========

This role is used to pull secrets from Hashicorp Vault and optionally authenticate with it if need be. If no vault token is provided, then the role will attempt to retrieve a temporary token from Vault using the IAM role that is associated with the instance running the role (This requires that Vault has the AWS authentication method setup). Once authenticated, the role allows for multiple secrets to be retrieved at once and stored in a variety of methods.

Content
-------

1. [Dependencies](#dependencies) - necessary prerequisites to operate the role
2. [Role Variables](#role-variables) - section documenting variables inputs required for the operation of this role
    * [vault_secrets](#vault-secrets) - section documenting the structure of the list of secrets to pass to the role to be retrieved from Vault
3. [Additional Information](#additional-information) - additional tips and tricks to help with setup and usage of the role
4. [Example Playbook](#example-playbook) - documented example of how to properly invoke this role from an ansible playbook
5. [Example Use Cases](#example-use-cases) - sample documentation for how the role may be used in a variety of common use cases
    * [Scenario 1 - Retrieving a single secretl](#scenario-1-retrieving-a-single-secret) - simple example showing how to retrieve only one secret from Vault
    * [Scenario 2 - Retrieving multiple secrets](#scenario-2-retrieving-multiple-secrets) - a more complex example showing how the role can easly invoked to batch-retrieve a list of secrets from Vault
    * [Scenario 3 - Pulling secrets from a versioned key value store](#scenario-3-pulling-secrets-from-a-versioned-key-value-store) - an example showing how one can pull always the latest version or a specific version of a secret from a versioned (V2) key-vault secrets engine in Vault
    * [Scenario 4 - Appending retrieved secrets to an existing ansible list variable](#scenario-4-appending-retrieved-secrets-to-an-existing-ansible-list-variable)
    * [Scenario 5 - Appending retrieved secrets to an existing ansible key-value dictionary variable](#scenario-5-appending-retrieved-secrets-to-an-existing-ansible-key-value-dictionary-variable)
6. [Authors](#authors) - information about the authors

Dependencies
------------

* Anisble 2.9+
* A Hashicorp Vault server.
* A valid Hashicorp Vault token set by the following options:
  * Passed via the `vault_token` Ansible variable
  * Set via the `VAULT_TOKEN` environment variable on the localhost
  * Stored in the `~/.vault-token` file on the source host machine
  * Retrieved via the Vault AWS authentication method if the instance has the proper IAM role attached.
  * Retrieved via the Vault Azure authentication method if the instance has the proper service principal attached.

Role Variables
--------------

| Name             | Type   | Default | Description |
| ---------------- | ------ | ------- | ----------- |
| vault_address    | string | | (**mandatory**) The address of the Vault server (Include https:// in the value) |
| vault_engine_aws | string | `aws` | The name of the AWS authentication method that is being authenticated to |
| vault_engine_azure | string | `azure` | The name of the Azure authentication method that is being authenticated to |
| vault_aws_auth | bool | `false` | Whether to utilize an AWS authentication method to retrieve Vault token |
| vault_azure_auth | bool | `false` | Whether to utilize an Azure authentication method to retrieve Vault token |
| vault_azure_auth_role | string | | (**mandatory when vault_azure_auth = true**) The name of the Vault Azure authentication role that is being authenticated to |
| vault_credentials | dict | | (**mandatory when vault_secrets_type != kv**) The dictionary that defines the secrets engine and secrets engine role to use to retrieve credentials |
| vault_engine_gcp | string | `gcp` | The name of the GCP authentication method that is being authenticated to |
| vault_gcp_auth_role | string | | The name of the Vault Azure authentication method role that is being authenticated to |
| vault_gcp_auth_type | bool | | The type of GCP entity that is authenticating to the GCP authentication method |
| vault_gcp_max_jwt_exp | integer | `60` | The expiration, in minutes, of the json web token that is retrieved from GCP |
| vault_gcp_service_account_email | string | | (**mandatory when vault_gcp_auth_type = iam**)The service account email being used for authentication to the GCP authentication method |
| vault_delegate   | string | `localhost` | The host to delegate the Vault API calls to |
| vault_ssl_verify | bool   | `true` | Whether to verify SSL certificates of the Vault server|
| vault_secrets    | list   | | A list of dictionaries defining each secret to pull from Vault (See below for details) |
| vault_upload_secrets    | list   | | A list of dictionaries defining each secret to post to Vault (See below for details) |
| vault_token      | string | | (**mandatory**) The token used to authenticate and retrieve secrets from Vault |

### vault_secrets

List of keys to be supplied for the `vault_secrets` dictionary:

* secret_path - (**mandatory**) *string*, path to the secret within vault beginning with the engine name
    * e.g. `kv_sms_secrets/products/sms/cre/infrastructure/domain/management`
    * e.g. `ENGINE/PATH/TO/SECRET`
* secret_version - (optional) *integer*, only applies to versioned (v2) key-value engines, the specific version of the secret to retrieve (may force v2 engine search of latest version by passing `latest` however this is **not** mandatory)
    * e.g. `1`, `2`, `latest`
* secret_key - (optional) *string*, specific key within the secret to pull the value from, otherwise the whole blob is retured
    * e.g. `groupList.csv`, `username`, `password`
* ansible_fact_name - (optional) *string*, when specified, an ansible variable will be created with this name and the secret's value stored in it
    * e.g. `variable1`
* ansible_list_name - (optional) *string*, when specified, an ansible list variable to append the retrieved secret value to, will define new empty list if not already defined
    * e.g. `list_variable1`
* ansible_dict_name - (optional) *string*, when specified, an ansible dictionary variable to append the retrieved secret as a key-value pair to, will define new empty dictionary if not already defined
    * e.g. `dict_variable1`
* ansible_dict_key - (optional) *string*, when 'ansible_dict_name' defined, the custom key to add the secret key-value pair to the dictionary with, will default to using 'secret_key' when left undefined
    * e.g. `groupList.csv`, `username`, `password`

### vault_secrets

List of keys to be supplied for the `vault_upload_secrets` dictionary:

* secret_path - (**mandatory**) *string*, path to the secret within vault beginning with the engine name
    * e.g. `kv_sms_secrets/products/sms/cre/infrastructure/domain/management`
    * e.g. `ENGINE/PATH/TO/SECRET`
* secret_key_value_dict - (**mandatory**) *dictionary*, A dictionary of key value pairs for the Vault secret
    * e.g.
    ```
    secret_key_value_dict:
      example_key_1: example_secret_1
      example_key_2: example_secret_2
    ```

### vault_credentials

The dictionary keys that can be supplied to the `vault_credentials` dictionary:

* vault_(aws/azure/gcp)_secrets_engine -The name of the aws, azure, or gcp secrets engine that is being used to generate credentials
    * e.g. `gcp_example_terraform`
* vault_(aws/azure/gcp)_secrets_engine_roles - List of roles that credentials will be generated for. These roles must all be configured in the secrets engine specified in 'vault_(aws/azure/gcp)_secrets_engine'
    * e.g. `evnironment-prefix`
* ansible_dict_name - (Optional) when specified, the credentials retrieved from the Azure secrets engine will be appended to the dictionary specified in this variable. This can be an existing dictionary or a new dictionary. If this option is used along with `ansible_fact_name`, `ansible_fact_name` will take precedence. If this is not specifed, retrieved credentials will be stored under the variable `vault_retrieved_credentials`.
    * e.g. `example_ansible_dict`
    * e.g.
    ```
      example_ansible_dict:
        example_key_1: example_secret_1
        example_key_2: example_secret_2
    ```
* ansible_fact_name - (Optional) when specified, an ansible variable will be created with this name and the secret's value stored in it. This option will override the use of `ansible_dict_name`. If this is not specifed, retrieved credentials will be stored under the variable `vault_retrieved_credentials`.
    * e.g. `example_fact_name`

Additional Information
----------------------

**Vault Tokens:** To use the role, a Vault token must be provided. A Vault token can be retrieved in two different ways. The first way is to log into the web UI of Vault and click the top right drop down, and then select `Copy token`. The second way is to log into Vault via the command line using the `vault login` command which will create a token file at `~/.vault-token`.

Once you have a Vault token, it must be supplied to the `vault-auth` role in one of three ways. The first way is to supply the token directly to the playbook that is calling the `vault-auth` role via the `vault_token` Ansible variable. This method is the least ideal due to security concerns. Alternatively, the token can be provided to the `vault_token` variable via a `vars_prompt:` section of the playbook which is more secure than providing it as an extra var, but requires user input making it less automatable.

The second way to provide the Vault token to the role is by setting it in the `VAULT_TOKEN` environment variable on the localhost (Ansible controller). The `VAULT_TOKEN` environment variable can be securely set on the localhost via the following command:
```
read -sp "Vault token: " TOKEN; export VAULT_TOKEN="${TOKEN}"; echo .
```

The third way to provide the Vault token to the role is by specifying it in the `~/.vault-token` file on the localhost (Ansible controller). This can be done manually by placing the Vault token value that was copied from the web UI directly into the file on line 1. Otherwise, this file can be created by issuing the following command, replacing the address value with the address of your Vault server. This will prompt you for your LDAP password:
```
vault login -address='https://build-vault.ns2-build-dev.sapns2.us' -method='ldap'
```

Additionally, if the target host or localhost that the role is running on is an AWS EC2 instance, then the instance's IAM role can be used to retrieve a temporary Vault token. To do this, the instance must have an IAM role attached to the instance that permits access to Hashicorp Vault and the Vault server must have the AWS EC2 engine enabled. To use this method of retrieving the Vault token, ensure that a Vault token is not specified in any of the three methods mentioned previously, those being the `vault_token` Ansible variable, the `VAULT_TOKEN` environment variable on the localhost, or the `~/.vault-token` file on the localhost.

Example Playbooks
-----------------

An example playbook can be found at `playbooks/examples/vault-auth.yml` with seperate plays for each usecase as covered in the next section.

This example playbook retrieves three secrets from Vault. All three items in the `vault_secrets` list reference the same Vault secret that is stored at the path `application/path/to/hashicorp_secret`. The difference between each of the three items is which keys within the secret are pulled and how they are stored.

In the first item, the secret `application/path/to/hashicorp_secret` is queried for the value of a specific key within it named `alice_key` and stored in an Ansible fact variable named `var1_alice_key`. In the second item, the value of the `betty_key` key is stored in the generic `vault_retrieved_secrets` variable and can be reference via `{{ vault_retrieved_secrets.betty_key }}`. The third item pulls every key defined in the `application/path/to/hashicorp_secret` secret and stores them in the `vault_retrieved_secrets` variable instead of pulling a specific key from the secret.

```
---
- name: Retrieve multiple secrets from Vault
  hosts: localhost
  connection: local
  vars:
    vault_address: 'https://build-vault.ns2-build-dev.sapns2.us'
    vault_secrets:
      - secret_path: 'engine_name/path/to/hashicorp_secret'
        secret_key: 'alice_key'
        ansible_fact_name: 'var1_alice_key'
      - secret_path: 'engine_name/path/to/hashicorp_secret'
        secret_key: 'betty_key'
        ansible_fact_name: ''
      - secret_path: 'engine_name/path/to/hashicorp_secret'
        secret_key: ''
        ansible_fact_name: ''

  tasks:
  - name: Retrieve secrets from Vault
    include_role:
      name: ../roles/vault-auth

  - name: Show all retrieved secrets
    debug:
      msg: "{{ vault_retrieved_secrets }}"

  - name: Show a specific secret
    debug:
      msg: "{{ vault_retrieved_secrets.betty_key }}"

...
```

This example playbook retrieves two sets of credentials from Vault. The items within the `vault_credentials` dictionary refer to the secrets engine that will be used to generate credentials and the roles that credentials will be generated for. These secrets will be saved to a custom dictionary fact, specified by `ansible_dict_name` which can be an existing or undefined dictonary.

```
---
- name: Retrieve multiple secrets from Vault
  hosts: localhost
  connection: local
  vars:
    vault_address: 'https://build-vault.ns2-build-dev.sapns2.us'
    vault_secrets_type: azure
    vault_credentials:
      ansible_dict_name: example_dict
      vault_azure_secrets_engine: example_azure_engine
      vault_azure_secrets_engine_roles:
        - example_azure_engine_role_1
        - example_azure_engine_role_2
  tasks:
    - name: Retrieve credentials from Vault
      include_role:
        name: ../vault-auth

    - name: Show retrieved credentials
      debug:
        msg: "{{ example_dict }}"

    - name: Show specific role credentials
      debug:
        msg: "{{ example_dict.example_azure_engine_role_1 }}"

...
```

Example Use Cases
-----------------

### Scenario 1 - Retrieving a single secret

A playbook requires you to authenticate to a server with a certain password; instead of hardcoding the password, you leverage Vault and store the password there as a secret. The secret is stored in a kv (key:value) format. The path to the secret (password in your case) in Vault is `application/postgresql`. A Vault token must be provided to the playbook by either specifying it in the `VAULT_TOKEN` environment variable on the localhost, specifying it in the `~/.vault-token` file, or specifying it in the `vault_token` extra var (not recommended).

```
---
- hosts: all
  vars:
    vault_address: 'https://build-vault.ns2-build-dev.sapns2.us'
    vault_secrets:
      - secret_path: 'application/databases/postgresql'
        secret_key: 'postgresql_server_password'
        ansible_fact_name: ''

  tasks:
  - name: Retrieve secrets from Vault
    include_role:
      name: ../roles/vault-auth

# Contents of the 'vault_retrieved_secrets' Ansible variable:
# {
#   "vault_retrieved_secrets": {
#     "postgresql_server_password": "Testpasswordvalue1!"
#   }
# }

  - name: Call the 'postgresql' role
    include_role:
      name: ../roles/postgresql
    vars:
      postgresql_pass: "{{ vault_retrieved_secrets.postgresql_server_password }}"

...
```

### Scenario 2 - Retrieving multiple secrets

A playbook requires you to authenticate to AWS using your access and secret keys, as such you leverage Hashicorp Vault to store your keys as a secret. The secret is stored in a kv (key:value) format. The path to the secret in Vault is `application/aws/svc-cron/credentials`. Once a Vault token is provided to the playbook in one of the three ways specified above, run the following playbook:

```
---
- hosts: all
  vars:
    vault_address: 'https://build-vault.ns2-build-dev.sapns2.us'
    vault_secrets:
      - secret_path: 'application/aws/svc-cron/credentials'
        secret_key: 'access_key'
        ansible_fact_name: 'aws_access_key'
      - secret_path: 'application/aws/svc-cron/credentials'
        secret_key: 'secret_key'
        ansible_fact_name: 'aws_secret_key'

  tasks:
  - name: Retrieve secrets from Vault
    include_role:
      name: ../roles/vault-auth

# Contents of the two newly created Ansible fact variables which are automatically passed to any subsequent roles:
# {
#   "aws_access_key": "ABCDABCDABCDABCD",
#   "aws_secret_key": "abc123zyx456abc123zyx456abc123zyx456"
# }

  - name: Call the 'aws-automation-tools' role
    include_role:
      name: ../roles/aws-automation-tools

...
```

### Scenario 3 - Pulling secrets from a versioned key value store

It is important to note that it is possible to pull specific versions of secrets out of a versioned (v2) secrets engine in HashiCorp Vault.

```
---
- hosts: all
  vars:
    vault_address: 'https://build-vault.ns2-build-dev.sapns2.us'
    vault_secrets:
        # Example to show pulling the latest version of a secret from a kv-v2 secrets engine (when the user has access to read the secret engine's configurations)
      - secret_path: 'ENGINE/PATH/TO/SECRET'
        secret_key: 'EXAMPLE_KEY'
        ansible_fact_name: 'EXAMPLE_FACT'
        # Example to show forced attempt pull latest version of a secret from a versioned kv-v2 secrets engine despite the user not having access to read information about the secrets engine configuration
      - secret_path: 'PATH/TO/SECRET'
        secret_version: 'latest'
        secret_key: 'EXAMPLE_KEY'
        ansible_fact_name: 'EXAMPLE_FACT'
        # Example to show pulling a specific version of a secret from a kv-v2 secrets engine
      - secret_path: 'PATH/TO/SECRET'
        secret_version: '2'
        secret_key: 'EXAMPLE_KEY'
        ansible_fact_name: 'EXAMPLE_FACT'

  tasks:
  - name: Retrieve secrets from Vault
    include_role:
      name: ../roles/vault-auth
```

### Scenario 4 - Appending retrieved secrets to an existing ansible list variable

This role can also be used to append retrieved secrets values to existing dictionaries and fed into other configurations. Consider a role that requires a list of private SSH keys to pull down and store on a system. It accepts a list variable called `ssh_keys`.

```
---
- hosts: all
  vars:
    ssh_keys: []
    vault_address: 'https://build-vault.ns2-build-dev.sapns2.us'
    vault_secrets:
      - secret_path: 'application/ssh/key-name-1'
        secret_key: 'private_key'
        ansible_list_name: 'ssh_keys'
      - secret_path: 'application/ssh/key-name-2'
        secret_key: 'private_key'
        ansible_fact_name: 'ssh_keys'

  tasks:
  - name: Add private SSH keys to system for the svc-account user
    include_role:
      name: ../roles/add-ssh-key
    vars:
      ssh_keys_for_user: svc-account

# Contents of the two newly created Ansible list would contain the following values:
# {
#   "ssh_keys" : [
#     "-----BEGIN OPENSSH PRIVATE KEY-----\naaabbbcccXktdjEAAAAACmFlczI1Ni1jdHIAAAAGYmNyeXB0AAAAGAAAABA5ubJgIx..."
#     "-----BEGIN OPENSSH PRIVATE KEY-----\nzzzyyyxxxdjEAAAAACmFlczI1Ni1jdHIAAAAGYmNyeXB0AAAAGAAAABA5ubJgIx..."
#   ]
# }

...
```

### Scenario 5 - Appending retrieved secrets to an existing ansible key-value dictionary variable

This role can also be used to append retrieved secrets values to existing simple key-value dictionaries and fed into other configurations. Consider the example where the `keycloak` ansible role requires a list of certificate authority bundles in a chain of trust to be passed to it in order to be able to configure LDAPS write back capabilities. The below example shows how all CA certificates can be pulled down from Vault and appended to the `keycloak_ca_roots` dictionary:

```
---
- hosts: all
  vars:
    keycloak_ca_roots: {}
    vault_address: 'https://vault.sms.aus.sapns2.internal'
    vault_secrets:
      - secret_path: 'kv_sms_secrets/products/sms/aus/infrastructure/pki/aus-root-ca'
        secret_key: 'certificate_raw'
        ansible_dict_name: 'keycloak_ca_roots'
        ansible_dict_key: 'aus-root-ca'
      - secret_path: 'kv_sms_secrets/products/sms/aus/infrastructure/pki/aus-intermediate-ca-x1'
        secret_key: 'certificate_raw'
        ansible_dict_name: 'keycloak_ca_roots'
        ansible_dict_key: 'aus-intermediate-ca-x1'
      - secret_path: 'kv_sms_secrets/products/sms/aus/infrastructure/pki/aus-sms-microsoft-intermediate-ca'
        secret_key: 'certificate_raw'
        ansible_dict_name: 'keycloak_ca_roots'
        ansible_dict_key: 'aus-sms-microsoft-intermediate-ca'

  tasks:
  - name: Configure Keycloak
    include_role:
      name: ../roles/keycloak

# Contents of the two newly created Ansible list would contain the following values:
# {
#   "keycloak_ca_roots" :
#     aus-root-ca: "-----BEGIN CERTIFICATE-----\nMIIF8TCCA9mgAwIBAgIQILj4Wotz15nUL9adYXippjANBaaabbbccc..."
#     aus-intermediate-ca-x1: "-----BEGIN CERTIFICATE-----\nMIIF8TCCA9mgAwIBAgIQILj4Wotz15nUL9adYXippjANBzzzyyyxxx..."
#     aus-sms-microsoft-intermediate-ca: "-----BEGIN CERTIFICATE-----\nMIIF8TCCA9mgAwIBAgIQILj4Wotz15nUL9adYXippjANBnnnmmmooo..."
# }

...
```

# Scenario 6 - Appending retrieved secrets to a custom fact

This role can be used to retrieve credentials from a vault secrets engine to get dynamically generated and short lived credentials. These credentials can be passed to other tasks to grant cross platform access if required.

```
---

  - hosts: localhost
    vars:
      vault_address: 'https://vault.ns2-example.sapns2.us'
      vault_ssl_verify: false
      vault_secrets_type: gcp
      vault_credentials:
        ansible_fact_name: test_fact
        vault_gcp_secrets_engine: gcp_example_engine
        vault_gcp_secrets_engine_roles:
          - gcp_example_engine_role_1
          - gcp_example_engine_role_2
    tasks:
      - name: Retrieve GCP Credentials
        include_role:
          name: vault-auth

# Contents of newly created custom fact:
# {
#   "test_fact":
#     "example_engine_role_1": {
#       "gcp_credentials": "ewogICJ0eXBlIjogInNlcnZpY2VfYWNjb3VudCIsCi..."
#     },
#     "example_engine_role_2": {
#       "gcp_credentials": "ewogICJ0eXBlIjogInNlcnZpY2VfYWNjb3VudCIsCi..."
#     }
# }

...
```

Author Information
------------------

* Mo Musau (mo.musau@sapns2.com)
* Alijohn Ghassemlouei (alijohn.ghassemlouei@sapns2.com)
* Louis Lee (louis.lee@sapns2.com)
* Matt Bittner (matthew.bittner@sapns2.com)
* Devon Thyne (devon.thyne@sapns2.com)
