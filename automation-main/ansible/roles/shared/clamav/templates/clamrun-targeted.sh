#!/bin/bash

# Synopsis: Tuns a ClamAV scan using clamscan against a parametrized target directory
#           Created from the SAC copy found here: https://gitlab.core.sapns2.us/sac-dev/ns2-kontrolle/blob/master/roles/clamav/templates/clamrun.sh
#
# Dependencies:
#   - clamav
#   - clamav-update
#
# Authors: Matt Bittner (i869415), Devon Thyne (i513825)
# Version: 1.0-000001
# Modified: 2021-04-16 - Created
#

set -o errexit

# Global variables
# TODO: Will need to revisit when making this compatible with other operating systems. Must ensure these paths are correct.

readonly CLAMSCAN=/usr/bin/clamscan
readonly FRESHCLAM=/usr/bin/freshclam
readonly HOST=/bin/hostname
readonly DATE=$(which date)
LD_PRELOAD_TARGET=""

# Source /etc/os-release if present
if [ -f /etc/os-release ]; then
    . /etc/os-release

    if [[ "$REDHAT_SUPPORT_PRODUCT" == "Red Hat Enterprise Linux" && "$REDHAT_SUPPORT_PRODUCT_VERSION" == "9.2" ]]; then
        LD_PRELOAD_TARGET="/lib/fips_enable.so"
    fi
fi

if [ ! "$#" -eq 1 ]; then
    echo "ERROR: Exactly 1 argument required containing the target path to perform virus scan."
    exit 255
fi
TARGET_PATH=$1

function clean_up {
    exit_code="$?"
    echo "INFO: Exiting with code: ${exit_code}"
}

trap "clean_up" EXIT

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
    echo "ERROR: Only root can run virus scan during scripted execution."
    exit 126
fi

echo "INFO: Initializing virus scan agaist target path - ${TARGET_PATH}"

# Start virus scan
echo "INFO: Scan started: $(${DATE} +"%Y-%m-%dT%H:%M:%S%z")"
set +e
LD_PRELOAD=$LD_PRELOAD_TARGET ${CLAMSCAN} \
    --heuristic-alerts=yes \
    --infected \
    --recursive \
    --stdout \
    ${TARGET_PATH}
return_code=$?
set -e
echo "INFO: Scan stopped: $(${DATE} +"%Y-%m-%dT%H:%M:%S%z")"

# Report virus scan message
if [[ $return_code -le 1 ]]; then
    echo "INFO: Virus scan completed"
    if [[ $return_code -eq 1 ]]; then
        echo "ERROR: Viruses found on system $(${HOST}) within target path - ${TARGET_PATH}"
    else
        echo "INFO: No viruses found"
    fi
else
    echo "ERROR: Failed to complete virus scan!"
fi

exit $return_code
