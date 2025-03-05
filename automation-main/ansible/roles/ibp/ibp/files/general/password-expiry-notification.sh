#!/bin/bash
# Description: This script will send the an e-mail to NS2 IBP Operations by reading backup log files
# Dependencies:
# - NS2 IBP deployment of SAP CPI-DS
# - Functioning egress mail relay
# - Valid local postfix configuration
# - Egress firewall rule to permit sending email off system
# Version: 1.0-000001
# Author: Srinivasa Atluri (c5281394)
# Modified: 2020-11-30 - Created

# system variables
SID=`echo "$SAPSYSTEMNAME"`

# script variables
TIMESTAMP=`date +'%Y-%m-%d'`
SCRIPT_DIRECTORY="/usr/sap/scripts"
USER_EXPIRATION_UNTIL_LOG_FILE="${SCRIPT_DIRECTORY}/user-expire.log"
USER_EXPIRATION_UNTIL_LOG_FILE="${SCRIPT_DIRECTORY}/user-until.log"

# notification variables
BODY="${SCRIPT_DIRECTORY}/body.log"
COUNT=`cat ${USER_EXPIRATION_UNTIL_LOG_FILE}|wc -l`
COUNT_COMPARISON=`cat ${USER_EXPIRATION_UNTIL_LOG_FILE}|wc -l`

# notification
if [ ${COUNT} -ge 1 ] || [  ${COUNT_COMPARISON} -ge 1 ] ; then
echo "***************$SID****************" >${BODY}
echo "PASSWORD EXPIRATION NOTICE FOR $SID " >>${BODY}
echo "***********************************" >>${BODY}
cat  ${USER_EXPIRATION_UNTIL_LOG_FILE} >>${BODY}
cat  ${USER_EXPIRATION_UNTIL_LOG_FILE} >>${BODY}
cat ${BODY}
mail -s "Alert | Local SAP User Password Expiry Report for `hostname -a | awk '{print $3}'` " -r "alerts@ibp.sapns2.us" DLSAPNS2IBPOPS@sapns2.com<${body}
fi
rm ${USER_EXPIRATION_UNTIL_LOG_FILE}
