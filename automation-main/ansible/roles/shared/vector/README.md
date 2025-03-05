Vector
======

Deploys [Vector](https://vector.dev), a lightweight agent that can retrieve
logs, and or metrics and forward them to one or more sinks.

Currently, this role implements functionality for:

    - AWS CloudWatch
    - Azure Object Storage
    - Google Oproation Logs

Requirements
------------

- RHEL 8.x
- Ubuntu 18.04
- Suse 15

## CloudWatch

For CloudWatch, the system should have an IAM profile associated that allows
writing to CloudWatch, or other AWS configuration for the `default` profile.

## Azure Object Storage

We require the connection string for the Azure Storage Account, which includes
the AccountKey, due to a limitation of the underlying Azure SDK for Rust.

## Google Cloud Platform

For reading project logs we require there to be a log router setup to send logs to
PubSub topic with a PubSub subscription with access from the instance service account.

For writing to GCP Logging platform we require the `logging.logCreator` permissions to
be granted to the instance service account.

Role Variables
--------------

- `vector_version`: The vector version to install, when installing from an S3
    bucket

    (Default: "")

- `vector_s3_binaries_url`: An URL to the vector directory path, should contain
    sub-folders that match the following:

    ```
    vector/
        0.19.0/
            vector-0.19.0-amd64.deb
            vector-0.19.0-1.x86_64.rpm
        0.18.1/
            vector-0.18.1-amd64.deb
            vector-0.18.1-1.x86_64.rpm
    ```

    This is for installation in environments where there is no external
    internet access. The preferred method is to leave this blank, and to
    install the latest version that is available from upstream.

    (Default: "")

- `vector_azure_blob_storage_connection_string`: The Azure Blob Storage
    connection string, example:

    ```
    BlobEndpoint=https://storageaccount.blob.core.usgovcloudapi.net/;DefaultEndpointsProtocol=https;AccountName=storageaccount;AccountKey=c2lnbmluZ2tleQ==;EndpointSuffix=core.usgovcloudapi.net
    ```

    (Default: "")

- `vector_azure_blob_storage_container_name`: The Azure Blob Storage Container
    Name, this is where the logs will be stored.

    (Default: "")

- `ns2_azure_activity_event_hub_endpoint`: The Azure Event Hub Endpoint URL, example:

    ```
    eventhub-logging.servicebus.usgovcloudapi.net
    ```

    (Default: "")

- `ns2_azure_activity_event_hub_topic_prefix`: The Azure Event Hub Topic Prefix, example:

    ```
    environment-logging
    ```

    (Default: "")

- `ns2_azure_activity_event_hub_connection_string`: The Azure EventHub connection string, example:

    ```
    Endpoint=sb://eventhub.servicebus.usgovcloudapi.net/;SharedAccessKeyName=vector;SharedAccessKey=b/0...
    ```

    (Default: "")

- `ns2_gcp_project_logs_pubsub_subscription`: The GCP PubSub subscription name for project logs example:

    ```
        gcp-project-logs
    ```

    (Default: "")

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

```
  - hosts: all
    tasks:
      - name: Install/configure Vector
        ansible.builtin.include_role:
          name: vector
```

License
-------

BSD

Generate Vector Graph
----------------------
To generate a vector graph you must have graphviz installed.
```bash
brew install graphviz
```
After that you can run this command from the `vector/files` directory
```bash
VECTOR_SPLUNK_INDEX_PREFIX="test-index" \                                                                                                                                                                                                        ─
VECTOR_DEFAULT_SPLUNK_INDEX="splunk_hec" \
VECTOR_CA_FILE="mock" \
VECTOR_CERT_FILE="mock" \
VECTOR_TLS_CERT_KEY_PASS="mock" \
VECTOR_VRL_VCS_TO_SPLUNK=../config/aggregator_processing/transforms/vcs_to_splunk.vrl \
NS2_GCP_PROJECT_ID="123456789012" \
NS2_GCP_PROJECT="test-project" \
VECTOR_SPLUNK_LOGS_KINESIS_STREAM_NAME="test" \
VECTOR_SPLUNK_LOGS_KINESIS_REGION="test" \
vector --config vector.yaml  graph \
--config-dir "/config/gcp_project_logs/" \
--config-dir "/config/gcp_transforms/" \
--config-dir "/config/log_collectors/*" \
--config-dir "/config/aggregator_processing" \
--config-dir "/config/aggregator_gcp_sinks" \
--config-dir "/config/aggregator_firehose_sinks" \
|  dot -Tsvg \
-Grankdir="LR" \
-Gsearchsize=100 \
-GTBbalance="max" \
-Gsplines=ortho \
-Glabel_scheme=3  \
-Goverlap="scalexy" \
-Gforcelabels=true \
-Gxlables=true \
> graph/vector_graph.svg

```

Author Information
------------------

* Bert JW Regeer (bert.regeer@sapns2.com)
