#!/bin/bash

function set_up() {
    source scripts/source/common.sh
    TEST_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    VALUES_FILE=${TEST_DIR}/stubs/values.yaml
    cp $VALUES_FILE $VALUES_FILE.bak
    export TEST_DIR VALUES_FILE
}

get_value() {
    yq '.rook-ceph-cluster.cephClusterSpec.storage.storageClassDeviceSets[0].volumeClaimTemplates[0].spec.resources.requests.storage' $VALUES_FILE
}

cleanup() {
    rm -f ${TEST_DIR}/stubs/values.yaml.bak
}

reset_values_file() {
    cp -f $VALUES_FILE.bak $VALUES_FILE
}

function test_CephFS_check_and_update_fs_size() {

    # Test 30Gi
    echo "30Gi" | numfmt --from iec-i > /tmp/30Gi
    check_and_update_fs_size ${VALUES_FILE} /tmp/30Gi
    assert_equals $(get_value ${VALUES_FILE}) "100Gi"
    rm /tmp/30Gi
    reset_values_file

    # Test 120Gi
    echo "120Gi" | numfmt --from iec-i > /tmp/120Gi
    check_and_update_fs_size ${VALUES_FILE} /tmp/120Gi
    assert_equals $(get_value ${VALUES_FILE}) "120Gi"
    rm /tmp/120Gi
    reset_values_file

    cleanup
}