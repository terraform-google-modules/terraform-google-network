#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Reads all change blobs and writes them to the actual Changelog
"""

# Import Libraries
import os, sys, json, datetime
from datetime import datetime

print(
    f"DEBUG {datetime.now().strftime('%Y-%m-%d %H:%M:%S')} : Running auto-changelog-post.py"
)

# Inputs
input_timestamp = os.environ["CI_COMMIT_TIMESTAMP"]
input_timestamp = (
    datetime.strptime(input_timestamp, "%Y-%m-%dT%H:%M:%S+00:00").date().isoformat()
)
input_server_address = os.environ["CI_SERVER_URL"]
input_root_path = os.environ["ROOT"]
input_blob_path = ".changes"
input_blob_suffix = "_change_blob.json"
input_changelog_name = "CHANGELOG-SCS.md"

change_blob_path = f"{input_root_path}/{input_blob_path}"

# Loop through all change blobs found in change_blob_path and write to appropriate locations
for file in os.listdir(change_blob_path):
    if file.endswith(input_blob_suffix):
        change_blob_file = f"{change_blob_path}/{file}"
        with open(change_blob_file, "r") as file:
            change_blob = json.load(file)
        # For Each Path found in change blob, loop:
        for path in change_blob["paths"]:
            changelog_path = f"{input_root_path}/{path}/{input_changelog_name}"
            if not os.path.exists(changelog_path):
                open(changelog_path, "a").close()
            with open(changelog_path, "r+") as r_file:
                body = r_file.read()
                r_file.seek(0)
                r_file.writelines(
                    [
                        f"## {input_timestamp} | {change_blob['author_username']}\n",
                        f"### {change_blob['labels']} | [MR {change_blob['mr_iid']}]({input_server_address}/{change_blob['unique_id']})\n",
                    ]
                    + [(f"{line}\n") for line in change_blob["content"]]
                    + [
                        f"\n",
                        f"{body}",
                    ]
                )
        # Delete File and close if statement
        os.remove(change_blob_file)
