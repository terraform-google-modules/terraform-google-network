#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Remove Status Labels from Merged Merge Requests.
"""

# Import Libraries
import os, requests

# Inputs
var_access_token = os.environ["PRE_COMMIT_ACCESS_TOKEN"]
var_project_id = os.environ["CI_PROJECT_ID"]
var_api_url = os.environ["CI_API_V4_URL"]

# Base Values
base_url = "{api_url}/projects/{project_id}".format(
    api_url=var_api_url,
    project_id=var_project_id,
)
headers = {"Authorization": "Bearer " + var_access_token}


# Get Current Labels
url = base_url + "/merge_requests?state=merged&labels=status::*"
response = requests.get(url, headers=headers)
count = len(response.json())

# If no MRs found, exit
if count == 0:
    print("No MRs found with status labels.")
    exit()

for i in range(count):
    labels = response.json()[i]["labels"]
    labels = [label for label in labels if not label.startswith("status::")]
    labels_str = ",".join(labels)
    child_iid = str(response.json()[i]["iid"])
    url = base_url + "/merge_requests/" + child_iid
    params = {"labels": labels_str}
    child_response = requests.put(url, headers=headers, params=params)
    print(child_response)
    print(f"Set Labels for {url} : {labels_str}")
