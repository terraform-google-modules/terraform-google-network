#!/bin/bash

# File to be read
input_file="/tmp/ansible_pip_requirements.txt"

# Check if file exists
if [[ ! -f "$input_file" ]]; then
    echo "File not found!"
    exit 1
fi

# Read and parse each line
while IFS= read -r line; do
    line=$(echo "$line" | awk -F'==' '{print $1}' | xargs)
    echo "Versions of $line:"
    eval "pip3 index versions $line 2>/dev/null | tail -n2"
done < "$input_file"
