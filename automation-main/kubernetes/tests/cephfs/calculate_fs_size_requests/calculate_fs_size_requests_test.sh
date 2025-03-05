#!/bin/bash

function set_up() {
    source scripts/source/common.sh
    TEST_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    export TEST_DIR
}

function test_CephFS_calculate_fs_size_requests() {

    # Test 30 - size overrides
    calculate_fs_size_requests ${TEST_DIR}/stubs/30.yaml /tmp/30_fs_size_requests
    result=$(cat  /tmp/30_fs_size_requests | numfmt --to iec-i)
    assert_equals $result "30Gi"
    rm /tmp/30_fs_size_requests

    # Test 0
    calculate_fs_size_requests ${TEST_DIR}/stubs/0.yaml /tmp/0_fs_size_requests
    result=$(cat  /tmp/0_fs_size_requests | numfmt --to iec-i)
    assert_equals $result "0"
    rm /tmp/0_fs_size_requests

}