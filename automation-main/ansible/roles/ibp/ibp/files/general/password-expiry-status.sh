#!/bin/bash
# Description: This script will perform password expiry check and trigger another email to send the email
# Dependencies:
# - NS2 IBP deployment of SAP CPI-DS
# - Script running as SAP Administrator with proper file permissions
# Version: 1.0-000001
# Author: Srinivasa Atluri (c5281394)
# Modified: 2020-11-30 - Created

# system variables
SID=`echo "$SAPSYSTEMNAME"`
INSTANCE="00"
SID_PATH=/usr/sap/${SID}
INSTALLATION_PATH=${SID_PATH}/HDB${INSTANCE}
SCRIPT_DIRECTORY="/usr/sap/scripts"
LOG_DIRECTORY="/usr/sap/scripts/logs"
HDBSQL_EXECUTABLE=${INSTALLATION_PATH}/exe/hdbsql
USERSTORE_OPTION="-U HDBRUNSQLKEY"

# script variables
USER_EXPIRATION_SQL_COMMAND="${SCRIPT_DIRECTORY}/user-expire.sql"
USER_EXPIRATION_UNTIL_SQL_COMMAND="${SCRIPT_DIRECTORY}/user-until.sql"
USER_EXPIRATION_UNTIL_LOG_FILE="${SCRIPT_DIRECTORY}/user-expire.log"
USER_EXPIRATION_UNTIL_LOG_FILE="${SCRIPT_DIRECTORY}/user-until.log"
SCRIPT_LOG=`echo "${LOG_DIRECTORY}/script_log_users_expire.log"`

# execute commands
${HDBSQL_EXECUTABLE} -c \; -xa ${USERSTORE_OPTION} -I ${USER_EXPIRATION_SQL_COMMAND} -o ${USER_EXPIRATION_UNTIL_LOG_FILE} >> ${SCRIPT_LOG}
${HDBSQL_EXECUTABLE} -c \; -xa ${USERSTORE_OPTION} -I ${USER_EXPIRATION_UNTIL_SQL_COMMAND} -o ${USER_EXPIRATION_UNTIL_LOG_FILE} >> ${SCRIPT_LOG}
${SCRIPT_DIRECTORY}/passwd-expiry-notification.sh >>${SCRIPT_LOG}