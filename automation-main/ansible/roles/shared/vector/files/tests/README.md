# Vector Tests

Vector has a built-in test function. Before merging any new configs into this repo, all tests should be run and pass successfully.

## Running Tests
From this current directory (`tests`) you can run all vector tests easily with a single command as long as vector is install on your computer.

Some environment variables are expected to be set. Vector checks for these before running, even if they are not being used. Because of this we must set some of these before we can run tests.

### Command: All Tests
```bash
VECTOR_SPLUNK_INDEX_PREFIX="test-index" \
VECTOR_DEFAULT_SPLUNK_INDEX="splunk_hec" \
VECTOR_CA_FILE="mock" \
VECTOR_CERT_FILE="mock" \
VECTOR_TLS_CERT_KEY_PASS="mock" \
VECTOR_VRL_VCS_TO_SPLUNK=../config/aggregator_processing/transforms/vcs_to_splunk.vrl \
NS2_GCP_PROJECT_ID="123456789012" \
NS2_GCP_PROJECT="test-project" \
vector --config vector.yaml test \
--config-dir "../config/gcp_project_logs/" \
--config-dir "../config/gcp_transforms/" \
--config-dir "../config/log_collectors/*" \
--config-dir "../config/aggregator_processing" \
 --config-dir "mock_processors" \
 "./*_logs/*"
```

### Command: All Tests With Debugging
```bash
VECTOR_SPLUNK_INDEX_PREFIX="test-index" \
VECTOR_DEFAULT_SPLUNK_INDEX="splunk_hec" \
VECTOR_CA_FILE="mock" \
VECTOR_CERT_FILE="mock" \
VECTOR_TLS_CERT_KEY_PASS="mock" \
VECTOR_VRL_VCS_TO_SPLUNK=../config/aggregator_processing/transforms/vcs_to_splunk.vrl \
NS2_GCP_PROJECT_ID="123456789012" \
NS2_GCP_PROJECT="test-project" \
vector --config vector.yaml -vv test \
--config-dir "../config/gcp_project_logs/" \
--config-dir "../config/gcp_transforms/" \
--config-dir "../config/log_collectors/*" \
--config-dir "../config/aggregator_processing" \
 --config-dir "mock_processors" \
 "./*_logs/*"
```
Once all tests have completed, you will see an output of the results from the tests.
