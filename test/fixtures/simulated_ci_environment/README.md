# Integration Testing

Use this directory to create resources reflecting the same resource fixtures
created for use by the CI environment CI integration test pipelines.  The intent
of these resources is to run the integration tests locally as closely as
possible to how they will run in the CI system.

Once created, store the service account key content into the
`SERVICE_ACCOUNT_JSON` environment variable. This reflects the same behavior
as used in CI.

For example:

```bash
terraform init
terraform apply
mkdir -p ~/.credentials
terraform output service_account_private_key > ~/.credentials/network-sa.json
```

Then, configure the environment (suggest using direnv) like so:

```bash
export SERVICE_ACCOUNT_JSON=$(cat ${HOME}/.credentials/network-sa.json)
export PROJECT_ID="network-module"
```

With these variables set, change to the root of the module and execute the
`make test_integration` task. This make target is the same that is executed
by this module's CI pipeline during integration testing, and will run the
integration tests from your machine.

Alternatively, to run the integration tests directly from the Docker
container used by the module's CI pipeline, perform the above steps and then
run the `make test_integration_docker` target

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| billing\_account | The billing account id associated with the project, e.g. XXXXXX-YYYYYY-ZZZZZZ | string | n/a | yes |
| folder\_id | The numeric folder id to create resources | string | n/a | yes |
| organization\_id | The numeric organization id | string | n/a | yes |
| region | The region to deploy to | string | `"us-west1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| service\_account\_private\_key | The SA KEY JSON content.  Store in GOOGLE_CREDENTIALS. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
