#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Retrieve merge request titles and format for release notes.
"""

import sys, os, requests

GITLAB_API_ENDPOINT = os.getenv('CI_API_V4_URL')
PROJECT_ID = os.getenv('CI_PROJECT_ID')
API_TOKEN = os.getenv('PRE_COMMIT_ACCESS_TOKEN')

mrs = set()
for line in sys.stdin:
    hash = line.rstrip('\n')
    merge_requests_url = "{}/projects/{}/repository/commits/{}/merge_requests".format(
        GITLAB_API_ENDPOINT, PROJECT_ID, hash
    )
    r = requests.get(merge_requests_url, headers={"PRIVATE-TOKEN": API_TOKEN})
    r.raise_for_status()
    for mr in r.json():
        if mr['state'] != 'merged':
            continue
        if mr['id'] in mrs:
            continue
        mrs.add(mr['id'])

        print('- !{} {}'.format(mr['iid'], mr['title']), flush=True)
