#!/bin/bash

# This script mirrors Docker images from etd private registry to incluster registry. Since etd registry required SAP VPN, script must be run on local machine by user with access to etddev registry. 

# Configuration
SOURCE_REGISTRY="etddev.int.repositories.cloud.sap"
TARGET_REGISTRY="harbor.dev.ste.dev.scs.sap/etddev"
CONTAINERS=("etd_coldstorage" "etd_kafka_2_hana" "etd_logcollector" "etd_loglearner" "etd_normalizer" "etd_transporter")
VERSIONS_COUNT=5
CONCURRENCY_LIMIT=5

# Source registry credentials
SOURCE_USERNAME="username"
SOURCE_PASSWORD="authtoken"

# Target registry credentials
TARGET_USERNAME="username"
TARGET_PASSWORD="password"

# Function to login to a Docker registry
docker_login() {
    local registry=$1
    local username=$2
    local password=$3
    echo "Logging into ${registry}..."
    echo "${password}" | docker login "${registry}" -u "${username}" --password-stdin
}

# Function to get the latest tags of a container from the source registry
get_latest_tags() {
    local container=$1
    curl -s -u "${SOURCE_USERNAME}:${SOURCE_PASSWORD}" "https://${SOURCE_REGISTRY}/v2/${container}/tags/list" | jq -r '.tags | sort | reverse | .[0:'"${VERSIONS_COUNT}"'] | .[]'
}

# Function to process a single image tag
process_image() {
    local container=$1
    local tag=$2
    local source_image="${SOURCE_REGISTRY}/${container}:${tag}"
    local target_image="${TARGET_REGISTRY}/${container}:${tag}"

    echo "Processing ${source_image}..."

    # Check if the image exists in the target registry
    if ! docker manifest inspect "${target_image}" > /dev/null 2>&1; then
        echo "${target_image} does not exist in the target registry. Pulling from source registry..."

        # Pull the latest version from the source registry
        echo "Pulling ${source_image}..."
        docker pull "${source_image}"

        # Push the image to the target registry
        echo "Tagging and pushing ${target_image}..."
        docker tag "${source_image}" "${target_image}"
        docker push "${target_image}"

        # Remove the image from local machine
        echo "Removing ${source_image} and ${target_image} from local machine..."
        docker rmi "${source_image}" "${target_image}"
    else
        echo "${target_image} already exists in the target registry. Skipping pull and push."
    fi
}

# Login to source and target registries
docker_login "${SOURCE_REGISTRY}" "${SOURCE_USERNAME}" "${SOURCE_PASSWORD}"
docker_login "${TARGET_REGISTRY}" "${TARGET_USERNAME}" "${TARGET_PASSWORD}"

# Loop through each container
for container in "${CONTAINERS[@]}"; do
    tags=$(get_latest_tags "${container}")

    # Loop through each tag and process it
    for tag in ${tags}; do
        # Run the process_image function in the background
        process_image "${container}" "${tag}" &

        # Limit the number of concurrent jobs
        while [ $(jobs -r | wc -l) -ge ${CONCURRENCY_LIMIT} ]; do
            sleep 1
        done
    done

    # Wait for all background jobs to finish
    wait
done

echo "Script completed."