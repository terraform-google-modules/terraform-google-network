#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Pulls information from MR Labels and Description and creates a change blob

There is a dependency that labels.py runs first on the same commit/runner as this script
"""

# Import Libraries
import os, re, requests, sys, json
from datetime import datetime

print(
    f"DEBUG {datetime.now().strftime('%Y-%m-%d %H:%M:%S')} : Running auto-changelog-pre.py"
)

# Inputs
input_access_token = os.environ["PRE_COMMIT_ACCESS_TOKEN"]  # needs read
input_api_url = os.environ["CI_API_V4_URL"]
input_project_id = os.environ["CI_MERGE_REQUEST_PROJECT_ID"]
input_project_path = os.environ["CI_MERGE_REQUEST_PROJECT_PATH"]
input_merge_request_iid = os.environ["CI_MERGE_REQUEST_IID"]
input_changed_file_paths = os.environ["FILE_DIFFS"].split("\n")
input_root_path = os.environ["ROOT"]
input_mr_description = os.environ["CI_MERGE_REQUEST_DESCRIPTION"]
input_label_path = "/tmp/labels.json"
# depdency that labels.py runs first
with open(input_label_path, "r") as file:
    input_mr_labels = json.load(file)
    # print("DEBUG: input_mr_labels: ", input_mr_labels)
    if (
        not input_mr_labels
        or not isinstance(input_mr_labels, list)
        or len(input_mr_labels) == 0
    ):
        print("ERROR: No MR labels set - exiting", file=sys.stderr)
        sys.exit(1)
# Old Label Logic
# The problem with this logic is that it doesn't pull in new labels that may have been added on the same pipeline run before.
# Keeping this logic for reference if someone comes up with a better way.
# try:
#     input_mr_labels = os.environ["CI_MERGE_REQUEST_LABELS"].split(",")
# except KeyError:
#     print("ERROR: No MR labels set - exiting", file=sys.stderr)
#     sys.exit(1)


# Where to store the temporary change blob
input_blob_path = ".changes"
# Suffix of the change blob file
input_blob_suffix = "_change_blob.json"
# When the script decides on which paths to write the changelog, it will traverse the git diffs from leaf to parent.
# These are the top level paths where the script will not traverse.
# This list should be populated with paths that are the parent of folders that contain changelog files.
input_top_level_paths = [
    ".",
    "ansible/inventory",
    "ansible/playbooks",
    "ansible/roles/ibp",
    "ansible/roles/s4pce",
    "ansible/roles/spr",
    "containers/dev_general",
    "terraform/ibp/modules",
    "terraform/ibp/roots",
    "terraform/s4pce/modules",
    "terraform/s4pce/roots",
    "terraform/spr/modules",
    "terraform/spr/roots",
    "terraform/tools/modules",
    "terraform/tools/roots",
]
# Don't add these labels to the change blob (partial match)
input_exclude_labels = [
    "status",
]
# When parsing which paths should include changelogs, ignore these. (Will never write changelogs here.)
input_exclude_diffs = [
    input_blob_path,
    ".cicd",
    "ansible/roles/shared",
    "release_notes",
    "terraform/shared",
]
# When searching for existing Changelogs, use this name.
# If the file exists, it will stop the traversal path search.
input_changelog_name = "CHANGELOG-SCS.md"
# Parse MR Description for the content between these markers
input_changelog_start_hook = r"<!--\sCHANGELOG_START_HOOK\sDO\sNOT\sREMOVE\sTHIS\s-->"
input_changelog_end_hook = r"<!--\sCHANGELOG_END_HOOK\sDO\sNOT\sREMOVE\sTHIS\s-->"

# End Inputs

# Unique ID of the Change based on Project and MR IID
unique_id = input_project_path + "/-/merge_requests/" + input_merge_request_iid

# Pull the MR Author
base_url = "{api_url}/projects/{project_id}/merge_requests/{merge_request_iid}".format(
    api_url=input_api_url,
    project_id=input_project_id,
    merge_request_iid=input_merge_request_iid,
)
headers = {"Authorization": "Bearer " + input_access_token}
url = base_url
response = requests.get(url, headers=headers)
# print("DEBUG Response: ", response.json())
author_name = response.json()["author"]["name"]
author_username = response.json()["author"]["username"]

# Get the Change Log Entries from MR Description
start_match = re.search(input_changelog_start_hook, input_mr_description)
end_match = re.search(input_changelog_end_hook, input_mr_description)
if start_match and end_match:
    content = input_mr_description[start_match.end() : end_match.start()].split("\n")
    content = [line for line in content if line.strip() != ""]
    # print(f"DEBUG: Content: {content}")
else:
    print("ERROR: Did not find changelog markers in file", file=sys.stderr)
    sys.exit(1)


# Search for locations that changelogs need to be written
# Initialize changelog_paths
changelog_paths = []

# create sorted_file_paths
sorted_file_paths = sorted(
    set([os.path.dirname(path) for path in input_changed_file_paths])
)
sorted_file_paths = [path for path in sorted_file_paths if path != ""]
sorted_file_paths = [
    path
    for path in sorted_file_paths
    if not any(path.startswith(exclude_path) for exclude_path in input_exclude_diffs)
]

# print("DEBUG: sorted_file_paths: ", sorted_file_paths)

# Go through every diff in sorted_file_paths, Add the path to changelog_paths if the following conditions are met.
# 1. The path is already in 'changelog_paths' var
# 2. The the changelog file is in the current path.
# 3. The parent path is in input_top_level_paths
for for_path in sorted_file_paths:
    previous_path = ""
    # Check 1. The path is already in 'changelog_paths' var
    if for_path not in changelog_paths:
        while_loop_done = False
        while_path = for_path
        while_loop_count = 0
        while not while_loop_done:
            # print("DEBUG: while_path: ", while_path)
            # print("DEBUG: while_loop_count: ", while_loop_count)
            # Safety Check
            while_loop_count += 1
            if while_loop_count > 50:
                print(
                    "ERROR: 'while loop' count exceeded threshold. Check for infinite loop bug.",
                    file=sys.stderr,
                )
                sys.exit(1)
            # Check 2. The changelog file is in the current path
            next_walk = input_root_path + "/" + while_path
            # KNOWN ISSUE: If main branch contains paths that don't exist in branch, then the os.walk will fail.
            # print("DEBUG: next_walk: ", next_walk)
            current_files = next(os.walk(next_walk))[2]
            # print("DEBUG: current_files: ", current_files)
            if input_changelog_name in current_files:
                # print("DEBUG: If is true: ", while_path)
                changelog_paths.append(while_path)
                while_loop_done = True
            else:
                # Check 3. The parent path is in input_top_level_paths
                if while_path in input_top_level_paths:
                    if previous_path != "":
                        changelog_paths.append(previous_path)
                    while_loop_done = True
                else:
                    previous_path = while_path
                    while_path = os.path.dirname(while_path)
                    if while_path == "":
                        while_path = "."

# print("DEBUG: unsorted changelog_paths: ", changelog_paths)
changelog_paths = sorted(list((set(changelog_paths))))
# print("DEBUG: changelog_paths: ", changelog_paths)

# Exclude Labels
input_mr_labels.sort()
labels = [
    label
    for label in input_mr_labels
    if not any(excluded_label in label for excluded_label in input_exclude_labels)
]

# Create the Change Blob
change_blob = json.dumps(
    {
        "mr_iid": input_merge_request_iid,
        "unique_id": unique_id,
        "author_name": author_name,
        "author_username": author_username,
        "labels": labels,
        "content": content,
        "paths": changelog_paths,
    }
)

# Open existing change blob file compare and only write if different.
# This will prevent pipelines from re-running indefinitely.
change_blob_path = (
    f"{input_root_path}/{input_blob_path}/{input_merge_request_iid}{input_blob_suffix}"
)
try:
    with open(change_blob_path, "r") as file:
        old_change_blob = file.read()
except FileNotFoundError:
    old_change_blob = ""

if old_change_blob != change_blob:
    with open(change_blob_path, "w") as file:
        json.dump(json.loads(change_blob), file, indent=4, sort_keys=True)
