#!/bin/sh
### This script is only provided as a reference.  Please refer to the live script at /sap/staging/Scripts

####################### M A I N #####################################
release=$3
InstallPath=/sap/staging/$release
SCRIPTPATH=/sap/staging/c2-ibpapp-stg-dev
ABOUTPATH=/sap/staging/c2-ibpapp-stg-dev
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

if test -r $4
then
echo "**********************************************************************************"
echo "ERROR! Syntax: csrebuild_2.sh <SID> <TargetDBHost> <RelativeTarLocation> <TargetCSHost> "
echo "example Syntax: csrebuild_2.sh N23 ibpdb-n23 tar ibpapp01-n23 "
echo "**********************************************************************************"
exit 1
fi

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
rm -rf /tmp/installCS
rm -rf /sapmnt/$SID/java

echo "*******************************************************"
echo "* You are going to install:                           *"
more $ABOUTPATH/about.txt
echo "*******************************************************"
echo "Source SID = $SOURCE_SID_ABAP" >> $LogFile
echo "Target SID = $SID" >> $LogFile
echo "Target DB Host = $2" >> $LogFile
echo "Target CS Host = $4" >> $LogFile
echo "*******************************************************"
echo "* Press any key to proceed                            *"

read anything

DATABASE_HOST=$2
ASCS_HOST=$4
MASTERPASSWORD='QwerRewq123'
saphanadbpasswd='IBPnw_SAPNS2'

# Create sapsys group
echo "Create sapsys group ..."
groupadd sapsys -g 79

#echo extracting the tar balls
echo "Extracting tar balls ..."
ln -snf /usr/sap/$SID /usr/sap/$SOURCE_SID_ABAP
ln -snf /sapmnt/$SID /sapmnt/$SOURCE_SID_ABAP
echo "Extracting from"
echo "$InstallPath"
cd /

# Untar sapmnt
echo "Untar /sapmnt ..."
cat $InstallPath/sapmnt.tgz-* | tar xvfz -

# Untar usrsap
echo "Untar /usr/sap ..."
cat $InstallPath/usrsap.tgz-* | tar xvfz -

#### prepare the parameter file for the SWPM installer
cd /tmp
mkdir installCS
chmod 777 installCS
groupadd sapinst
chgrp sapinst installCS
cd installCS

# Prepare CS parameter file
echo "Prepare CS parameter file ..."
cp -R $SCRIPTPATH/parameterCS.txt /tmp/installCS
sed -i "s#XXXSIDXXX#$SID#g"                       /tmp/installCS/parameterCS.txt
sed -i "s#XXXsidXXX#$sid#g"                       /tmp/installCS/parameterCS.txt
sed -i "s#XXXMASTERPASSWORDXXX#$MASTERPASSWORD#g" /tmp/installCS/parameterCS.txt
sed -i "s#XXXABAPSCHEMAPASSWORDXXX#$saphanadbpasswd#g" /tmp/installCS/parameterCS.txt
sed -i "s#XXXASCSHOSTXXX#$ASCS_HOST#g"            /tmp/installCS/parameterCS.txt
sed -i "s#XXXDBHOSTXXX#$DATABASE_HOST#g"          /tmp/installCS/parameterCS.txt
sed -i "s#XXXDOMAINXXX#$domain#g"                 /tmp/installCS/parameterCS.txt

cp /tmp/installCS/parameterCS.txt /tmp/parameterCS.txt
cd /tmp/installCS

echo "Execute SAPINST for ASCS..."
$SWPM/sapinst SAPINST_INPUT_PARAMETERS_URL=parameterCS.txt SAPINST_EXECUTE_PRODUCT_ID=NW_StorageBasedCopy_ASCS SAPINST_SKIP_DIALOGS=true -nogui -noguiserver
if [ "$?" -ne "0" ]; then
    echo "ERROR: the SWPM CS installer reported an error. Check the logs in /tmp/installCS file."
    echo "Aborting script"
	echo "--------- SERVERINFO --------" > /tmp/serverinfo.txt
	df -h >> /tmp/serverinfo.txt
	chmod 777 /tmp/serverinfo.txt
    exit 1
  fi

mkdir /usr/sap/$SID/setuplogs
mv /tmp/installCS /usr/sap/$SID/setuplogs

echo "- SWPM CS installation successfully completed             -"