#!/bin/bash

eval "$(jq -r '@sh "execute_command=\(.command)"')"

# Execute input command and capture output/error
random_sequence=$( openssl rand -hex 32 )
result=$(
  { stdout=$( eval ${execute_command} ) ; } 2>&1
  echo "${random_sequence}"
  echo "${stdout}"
)

capture_stdout=$( echo ${result#*${random_sequence}} )
capture_stderr=$( echo ${result%${random_sequence}*} )

# Produce JSON object containing the results
jq -n \
  --arg stdout "${capture_stdout}" \
  --arg stderr "${capture_stderr}" \
  '{"stdout":$stdout, "stderr":$stderr}'
