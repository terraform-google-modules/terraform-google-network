#!/bin/bash

# Synopsis: Updates the virus definitions using freshclam and then runs a ClamAV scan using clamscan.
#           Created from the SAC copy found here: https://gitlab.core.sapns2.us/sac-dev/ns2-kontrolle/blob/master/roles/clamav/templates/clamrun.sh
#
# Dependencies:
#   - clamav
#   - clamav-update
#
# Authors: Matt Bittner (i869415)
# Version: 1.0-000001
# Modified: 2019-11-14 - Created
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

function clean_up {
    exit_code="$?"
    echo "INFO: Exiting with code: ${exit_code}"
}

trap "clean_up" EXIT

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
    echo "ERROR: Only root can run virus scan during scripted execution."
    exit 1
fi

echo "INFO: Initializing virus scan"

# Update virus signatures
echo "INFO: Updating virus definitions"
set +e
LD_PRELOAD=$LD_PRELOAD_TARGET ${FRESHCLAM} --stdout
return_code=$?
set -e

# Report virus definition updates
if [[ $return_code -ge 2 ]]; then
    echo "ERROR: Failed to update virus definitions! Virus scan aborted."
    exit $return_code
fi
echo "INFO: Virus definitions updated successfully"

# Start virus scan
echo "INFO: Scan started: $(${DATE} +"%Y-%m-%dT%H:%M:%S%z") (this may take some time)"
set +e
LD_PRELOAD=$LD_PRELOAD_TARGET ${CLAMSCAN} \
    --heuristic-alerts=yes \
    --infected \
    --recursive \
    --stdout \
    --exclude='{{ clamav_file_ignore_pattern }}' \
    --exclude-dir='{{ clamav_dir_ignore_pattern }}' \
    {{ clamav_scan_path }}
return_code=$?
set -e
echo "INFO: Scan stopped: $(${DATE} +"%Y-%m-%dT%H:%M:%S%z")"

# Report virus scan message
if [[ $return_code -le 1 ]]; then
    echo "INFO: Virus scan completed"
    if [[ $return_code -eq 1 ]]; then
        echo "ERROR: Viruses found on system $(${HOST})!"
    else
        echo "INFO: No viruses found"
    fi
else
    echo "ERROR: Failed to complete virus scan!"
fi

exit $return_code
