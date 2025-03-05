#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Adds Labels to specific Merge Requests based on the files (paths) changed in the Merge Request.
"""

# Import Libraries
import os, re, requests, json

# Inputs
input_label_path = "/tmp/labels.json"
input_access_token = os.environ["PRE_COMMIT_ACCESS_TOKEN"]
input_project_id = os.environ["CI_MERGE_REQUEST_PROJECT_ID"]
input_merge_request_iid = os.environ["CI_MERGE_REQUEST_IID"]
input_api_url = os.environ["CI_API_V4_URL"]
input_search_terms = [
    "terraform",
    "ansible",
    "kubernetes",
    "containers",
    "ibp",
    "s4pce",
    "spr",
    "tools",
]  # Search terms to look for in file paths

# Base Values
base_url = "{api_url}/projects/{project_id}/merge_requests/{merge_request_iid}".format(
    api_url=input_api_url,
    project_id=input_project_id,
    merge_request_iid=input_merge_request_iid,
)
headers = {"Authorization": "Bearer " + input_access_token}


# Get Current Labels
url = base_url
response = requests.get(url, headers=headers)
labels = response.json()["labels"]

# Get Files Changed
url = base_url + "/diffs"
input_per_page = 30  # This breaks if more than 30?
params = {"per_page": input_per_page}
response = requests.get(url, headers=headers, params=params)
last_page_number = int(re.search(r"page=(\d+)", response.links["last"]["url"]).group(1))

# Go Through Each Page of Files Changed
for page in range(1, last_page_number + 1):
    params = {"per_page": input_per_page, "page": page}
    # DEBUG
    # params = {"per_page": input_per_page, "page": 1}
    response = requests.get(url, headers=headers, params=params)
    total_num_files = len(response.json())
    # Search and Label based on each file path
    for file in range(total_num_files):
        new_path = response.json()[file]["new_path"]
        for term in input_search_terms:
            if re.search(term, new_path):
                labels.append(term)
                input_search_terms.remove(term)
                # print("DEBUG: ", input_search_terms)
        if len(input_search_terms) == 0:
            break
    if len(input_search_terms) == 0:
        break


# Remove duplicates from labels list, convert to comma separated string
labels = list(set(labels))
labels.sort()
labels_str = ",".join(labels)
# Write labels to json to be used by other scripts
with open(input_label_path, "w") as outfile:
    json.dump(labels, outfile)

# Write Labels to Merge Request
url = base_url
params = {"labels": labels_str}
response = requests.put(url, headers=headers, params=params)
print(response)
print(response.json()["labels"])
