# Integration Testing

Use this directory to create resources reflecting the same resource fixtures
created for use by the CI environment CI integration test pipelines.  The intent
of these resources is to run the integration tests locally as closely as
possible to how they will run in the CI system.

Once created, store the service account key content into the
`GOOGLE_CREDENTIALS` environment variable.  This reflects the same behavior as
used in CI.

For example:

```bash
terraform init
terraform apply
terraform output service_account_private_key > ~/.credentials/network-sa.json
```

Then, configure the environment (suggest using direnv) like so:

```bash
export GOOGLE_CREDENTIALS_PATH="${HOME}/.credentials/network-sa.json"
export GOOGLE_CREDENTIALS="${HOME}/.credentials/network-sa.json"
export TF_VAR_project_id="network-module"
```

With these variables set, change to the root of the module and execute the `make test_integration` task.
This make target is the same that is executed by this module's CI pipeline during integration testing, and
will run the integration tests from your machine.

Alternatively, to run the integration tests directly from the Docker container used by the module's CI pipeline, copy
the credentials file to the root of the module and then run the `make test_integration_docker` target:

```
# Change to the root of the module
cd /path/to/module

# Copy credentials and run test
cp $GOOGLE_CREDENTIALS_PATH ./credentials.json
make test_integration_docker
```

[^]: (autogen_docs_start)


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| billing_account | The billing account id associated with the project, e.g. XXXXXX-YYYYYY-ZZZZZZ | string | - | yes |
| folder_id | The numeric folder id to create resources | string | - | yes |
| organization_id | The numeric organization id | string | - | yes |
| region | The region to deploy to | string | `us-west1` | no |

## Outputs

| Name | Description |
|------|-------------|
| service_account_private_key | The SA KEY JSON content.  Store in GOOGLE_CREDENTIALS. |

[^]: (autogen_docs_end)
