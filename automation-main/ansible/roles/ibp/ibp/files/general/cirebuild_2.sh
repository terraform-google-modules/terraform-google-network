#!/bin/sh
### This script is only provided as a reference.  Please refer to the live script at /sap/staging/Scripts

####################### M A I N #####################################
ABOUTPATH=/sap/staging/c2-ibpapp-stg-dev
SCRIPTPATH=/sap/staging/c2-ibpapp-stg-dev
SWPM=/sap/staging/SWPM
TimeStamp=`date +%Y-%m-%d'_'%H.%M.%S`
LogFileName=Log_${TimeStamp}
LogFile=/tmp/${LogFileName}.txt

if [ "$(id -u)" != "0" ]; then
  echo "*******************************************************"
  echo "This script must be run as root" 1>&2
  echo "*******************************************************"
  exit 1
fi


if test -r $3
then
echo "**********************************************************************************"
echo "ERROR! Syntax: cirebuild_2.sh <SID> <TargetDBHost> <TargetCIHost> "
echo "example Syntax: cirebuild_2.sh N23 ibpdb-n23 ibpapp01-n23 "
echo "**********************************************************************************"
exit 1
fi

echo "$TimeStamp - $1:  $2" | tee -a $LogFile
echo "-----------    SWPM4CI INSTALLATION    --------------------"
echo "- Prepare the parameters                                  -"

domain=`dnsdomainname`
proxyhost="proxy"

sid=`echo $1 | tr A-Z a-z`
SID=`echo $1 | tr a-z A-Z `

SOURCE_SID_DB=`grep "Source_SID_DB" $ABOUTPATH/about.txt | sed 's/:/ /g' | awk '{print substr($2,0,3)}' `
SOURCE_sid_DB=`echo $SOURCE_SID_DB | tr A-Z a-z`
SOURCE_SID_ABAP=`grep "Source_SID_ABAP" $ABOUTPATH/about.txt | sed 's/:/ /g' | awk '{print substr($2,0,3)}' `
SOURCE_sid_ABAP=`echo $SOURCE_SID_ABAP | tr A-Z a-z`
SOURCE_DBHOSTNAME=`grep "Source_Hostname_DB" $ABOUTPATH/about.txt | sed 's/:/ /g' | awk '{print $2}' | tr -d '\012\015'`
SOURCE_CIHOSTNAME=`grep "Source_Hostname_CI" $ABOUTPATH/about.txt | sed 's/:/ /g' | awk '{print $2}' | tr -d '\012\015'`
SOURCE_CSHOSTNAME=`grep "Source_Hostname_CS" $ABOUTPATH/about.txt | sed 's/:/ /g' | awk '{print $2}' | tr -d '\012\015'`
SOURCE_MASTERPASSWORD=`grep "Source_MasterPassword" $ABOUTPATH/about.txt | sed 's/:/ /g' | awk '{print $2}' | tr -d '\012\015'`


echo "Cleanup old installs ..."
rm -rf /tmp/installCI
rm -rf /sapmnt/$SID/java

echo "*******************************************************"
echo "* You are going to install:                           *"
more $ABOUTPATH/about.txt
echo "*******************************************************"
echo "Source SID = $SOURCE_SID_ABAP"
echo "Target SID = $SID"
echo "Target DB Host = $2"
echo "Target CI Host = $3"
echo "*******************************************************"
echo "*                                                     *"
echo "* Make sure, the HANA is up and running, then         *"

echo "* press any key to proceed                            *"

read anything

DATABASE_HOST=$2
CI_HOST=$3
MASTERPASSWORD='QwerRewq123'
saphanadbpasswd='IBPnw_SAPNS2'

#### prepare the parameter file for the SWPM installer
cd /tmp
mkdir installCI
chmod 777 installCI
chgrp sapinst /tmp/installCI
cd /tmp/installCI

cp -R $SCRIPTPATH/parameterCI.txt /tmp/installCI
sed -i "s#XXXSIDXXX#$SID#g" /tmp/installCI/parameterCI.txt
sed -i "s#XXXsidXXX#$sid#g" /tmp/installCI/parameterCI.txt
sed -i "s#XXXMASTERPASSWORDXXX#$MASTERPASSWORD#g" /tmp/installCI/parameterCI.txt
sed -i "s#XXXABAPSCHEMAPASSWORDXXX#$saphanadbpasswd#g" /tmp/installCI/parameterCI.txt
sed -i "s#XXXCIHOSTXXX#$CI_HOST#g"  /tmp/installCI/parameterCI.txt
sed -i "s#XXXDBHOSTXXX#$DATABASE_HOST#g"          /tmp/installCI/parameterCI.txt
sed -i "s#XXXDOMAINXXX#$domain#g"                 /tmp/installCI/parameterCI.txt

cp /tmp/installCI/parameterCI.txt /tmp/parameterCI.txt
cd /tmp/installCI

$SWPM/sapinst SAPINST_INPUT_PARAMETERS_URL=parameterCI.txt SAPINST_EXECUTE_PRODUCT_ID=NW_StorageBasedCopy_CI SAPINST_SKIP_DIALOGS=true -nogui -noguiserver
if [ "$?" -ne "0" ]; then
    echo "ERROR: the SWPM CI installer reported an error. Check the logs in /tmp/installCI file." >> LogFile
    echo "Aborting script                                                                       " >> LogFile
	echo "- ERROR: Check the logs in /tmp/installCI                                            -" >> LogFile
    exit 1
  fi

mkdir /usr/sap/$SID/setuplogs_ci
mv /tmp/installCI /usr/sap/$SID/setuplogs_ci

echo "- SWPM CI installation successfully completed             -"