#!/bin/sh
### This script is only provided as a reference.  Please refer to the live script at /hana/staging/Scripts

# tag it and bag it
(
#variable input/declaration
sid=`echo $1 | tr A-Z a-z`
SID=`echo $1 | tr a-z A-Z `
release=$2
# source path - RW
SOURCEPATH=/hana/staging/$release
# about.txt path - RW
ABOUTPATH=/hana/staging/c2-ibpdb-stg-dev
# scripts path - RW
#newpath=/hana/staging/Scripts
newpath=/hana/staging/c2-ibpdb-stg-dev
DATABASE_HOST=$3
SYSTEM_USAGE=$4

domain=`dnsdomainname`
proxyhost="proxy"

#HANA is already installed:
status=`/usr/sap/hostctrl/exe/sapcontrol -nr 02 -function GetInstanceProperties | grep INSTANCE_NAME | cut -d ',' -f '3' | cut -d ' ' -f '2' `
#echo "$status"
echo "#####Pre-Check script###########"
if [ "$status" == "HDB02" ]
then
echo "HANA is already installed in the server, please cross check & run dbcleanup.sh Script"
exit
else
echo "HANA not installed, proceeding"
fi

#Set default sapsys groupid and new password - RW
groupid=79
passwd='QwerRewq123'
saphanadbpasswd='IBPnw_SAPNS2'

#only root user allowed
if [ "$(id -u)" != "0" ]; then
	echo "Please use root user to run the script" 1>&2
	exit 1
fi

#Check mandatory parameters
if test -r $4
	then
	echo "*******************************************************"
	echo "ERROR! Syntax: dbrebuild.sh <SID> <release> <DATABASE_HOST> <SYSTEM_USAGE> "
        echo " SYSTEM_USAGE values: [production|test|development] "
        echo " example dbrebuild_2.sh N23 tar ibpdb-n23 test"
	echo "*******************************************************"
	exit 1
fi

#Source parameters

SOURCE_SID_DB=`grep "Source_SID_DB" $ABOUTPATH/about.txt | sed 's/:/ /g' | awk '{print substr($2,0,3)}' `
SOURCE_sid_DB=`echo $SOURCE_SID_DB | tr A-Z a-z`
SOURCE_SID_ABAP=`grep "Source_SID_ABAP" $ABOUTPATH/about.txt | sed 's/:/ /g' | awk '{print substr($2,0,3)}' `
SOURCE_sid_ABAP=`echo $SOURCE_SID_ABAP | tr A-Z a-z`
SOURCE_DBHOSTNAME=`grep "Source_Hostname_DB" $ABOUTPATH/about.txt | sed 's/:/ /g' | awk '{print $2}' | tr -d '\012\015'`
SOURCE_CIHOSTNAME=`grep "Source_Hostname_CI" $ABOUTPATH/about.txt | sed 's/:/ /g' | awk '{print $2}' | tr -d '\012\015'`
SOURCE_CSHOSTNAME=`grep "Source_Hostname_CS" $ABOUTPATH/about.txt | sed 's/:/ /g' | awk '{print $2}' | tr -d '\012\015'`
SOURCE_MASTERPASSWORD=`grep "Source_MasterPassword" $ABOUTPATH/about.txt | sed 's/:/ /g' | awk '{print $2}' | tr -d '\012\015'`
hdb_instanceNumber=02
unicode=true
sapmnt=/sapmnt

echo "*******************************************************"
echo "* We are going to install:                            *"
more $ABOUTPATH/about.txt
echo "*******************************************************"
echo "Target SID = $SID on $DATABASE_HOST"
echo "*******************************************************"
echo "SOURCE_SID_DB         " $SOURCE_SID_DB
echo "SOURCE_sid_DB         " $SOURCE_sid_DB
echo "SOURCE_SID_ABAP       " $SOURCE_SID_ABAP
echo "SOURCE_sid_ABAP       " $SOURCE_sid_ABAP
echo "SOURCE_DBHOSTNAME     " $SOURCE_DBHOSTNAME
echo "SOURCE_CIHOSTNAME     " $SOURCE_CIHOSTNAME
echo "SOURCE_CSHOSTNAME     " $SOURCE_CSHOSTNAME
echo "SOURCE_MASTERPASSWORD " $SOURCE_MASTERPASSWORD
echo "*******************************************************"

#stop host agent
  echo "Stop Host Agent..."
  /etc/init.d/sapinit stop

  #cleanup DB
  echo "Performing cleanup..."
	  rm -rf /tmp/UNIFIEDINSTALL
	  rm -rf /tmp/UNIFIED
	  rm -rf /tmp/LMTP*
	  rm -rf /tmp/sapinst*
	  rm -rf /tmp/.sap*
	  rm -rf /hana/shared/$SID/*
	  rm -rf /hana/data/$SID/*
	  rm -rf /hana/log/$SID/*
	  rm -rf /hana/backup/$SID/data/*
	  rm -rf /hana/backup/$SID/log/*
	  rm -rf /sapmnt/$SID/exe
	  rm -rf /sapmnt/$SID/global
	  rm -rf /sapmnt/$SID/profile
	  rm -rf /usr/sap/sapservices
	  rm -rf /usr/sap/$SID.hdbinstall
	  rm -rf /usr/sap/$SID.hdbupgrade
	  rm -rf /usr/sap/$SID/*
	  rm /tmp/.sapstr*
	  rm /tmp/STDIN*
	  rm -rf /usr/sap/hdbstudio*
	  rm -rf /usr/sap/hdbclient
	  rm -rf /var/tmp/hdb*
	  rm -rf /tmp/$SID*
	  rm /var/tmp/saposcol.pid
	  rm -rf /var/lib/hdb/*
	  rm -rf /usr/sap/$SID
	  rm -rf /hana/shared/$SID/*
	  rm -rf /hana/data/$SID/*
	  rm -rf /hana/log/$SID/*
	  rm -rf /var/tmp/hdb*
	  rm -rf /var/lib/hdb
	  rm /hana/shared/$SOURCE_SID_DB
	  rm /hana/data/$SOURCE_SID_DB
	  rm /hana/log/$SOURCE_SID_DB
	  rm -rf /tmp/posrdb*
	  ln -snf /hana/shared/$SID /hana/shared/$SOURCE_SID_DB
	  ln -snf /hana/data/$SID /hana/data/$SOURCE_SID_DB
	  ln -snf /hana/log/$SID /hana/log/$SOURCE_SID_DB

# Create target SID directories for extraction - RW
          echo "Creating directories for extraction..."
          mkdir -p /hana/data/$SID
          mkdir -p /hana/log/$SID
          mkdir -p /hana/shared/$SID
          mkdir -p /hana/backups/$SID/HDB02/backup/data
          mkdir -p /hana/backups/$SID/HDB02/backup/log

# create the hi1adm (temporary user needed during extraction of virtual appliance)
  echo "Creating temporary n00adm needed during extaction..."
  if [ "$SOURCE_SID_DB" == "N00" ]; then
     mkdir -p /usr/sap/N00/home
     useradd -d /usr/sap/N00/home -g $groupid -u 12393 -s /bin/csh -c "SAP HANA Database System Administrator" n00adm
     pwconv
     #passwd hi1adm
   fi

  echo "Press any key to start extraction of the Virtual Appliance..."
  read anything

 #start host agnet
  echo "Starting host agent..."
  /etc/init.d/sapinit start

 #extracting files
  echo "Extracting files..."
  cd $SOURCEPATH
  cat hana-data.tgz-* | tar -zkpxvf - -C /
  cat hana-log.tgz-* | tar -zpkxvf - -C /
  cat hana-shared.tgz-* | tar -zpkxvf - -C /

  if [ "$SOURCE_SID_DB" == "N00" ]; then
     echo "assign group id.."
     sed -i "s#groupid': 1000,#groupid': $groupid,#g"   /hana/shared/$SID/global/hdb/install/support/cfg
     sed -i "s#adm_id': 1001,#adm_id': 12393,#g"  /hana/shared/$SID/global/hdb/install/support/cfg
  fi

echo "Extraction completed successfully"
echo "Press any key to perform the hdblcm"
read anything

cp $newpath/hdb_passwords.xml /tmp
echo "Updating hdb_passwords.xml with new password..."
sed -i "s#XXXMASTERPASSWORDXXX#$passwd#g"  /tmp/hdb_passwords.xml

 echo "Rename the HANA DB"
  cat /tmp/hdb_passwords.xml |  /hana/shared/$SID/hdblcm/hdblcm --action register_rename_system --datapath=/hana/data/$SID/  --databackuppath=/hana/backups/$SID/HDB02/backup/data --logpath=/hana/log/$SID/ --logbackuppath=/hana/backups/$SID/HDB02/backup/log --root_user=root --listen_interface=global --number=02 --system_usage=$SYSTEM_USAGE --target_sid=$SID --hostmap=$SOURCE_DBHOSTNAME=$DATABASE_HOST  --target_password=$passwd --read_password_from_stdin=xml --batch -nostart

  if [ "$?" -ne "0" ]; then
      echo "ERROR: the hdblcm reported an error. Check the logs"
      echo "Aborting script...."
	  exit 1
  fi

#adjusting hdbenv.csh
  echo "changing hana/shared/$SID/HDB02/hdbenv.csh -> /usr/sap/$SID/HDB02/hdbenv.csh"
  sed -i "s#hana/shared#usr/sap#g"  /usr/sap/$SID/HDB02/hdbenv.csh

# Update HANA PSE
echo "updating  the PSE files on HANA"
su - "$sid"adm -c "cp /hana/staging/Scripts/NS2-IBPDB.pse /usr/sap/$SID/HDB02/"$DATABASE_HOST"/sec/SAPSSLS.pse"
su - "$sid"adm -c "cp /hana/staging/Scripts/NS2-IBPDB.pse /usr/sap/$SID/HDB02/"$DATABASE_HOST"/sec/sapsrv.pse"
echo "HANA PSE updated..."

#removing source installation.ini file
# check if the installation.ini exist and delete it. - RW
if [ -e /hana/shared/$SID/hdbclient/install/installation.ini ]
then
    su - "$sid"adm -c "rm /hana/shared/$SID/hdbclient/install/installation.ini"
fi

  #Change Ownership on the backup directory
  echo "Change Ownership on the backup directory..."
  chown -R "$sid"adm:sapsys /hana/backups

  #starting hana DB
  echo "starting hana database now..."
  su - "$sid"adm -c "sapcontrol -nr 02 -function Start"

  #checking whether hana db is up and running
  echo "checking whether DB is running, this will take some time, please be patient!!!"
  n=0
  su - "$sid"adm -c "sapcontrol -nr 02 -function GetSystemInstanceList | grep GREEN"
  while [ ! "$?" == 0 ]
  do
  echo "`date` -- HANA not yet running, waiting until it is up ...";
  sleep 60;
  n=$(( $n + 1 ))
  # echo $n;
  #will exit after 30 tries
  if [ $n -gt 30 ]; then
  echo
  echo "HANA did not start after ~30 mins, please check manually!"
  exit
  fi

  su - "$sid"adm -c "sapcontrol -nr 02 -function GetSystemInstanceList | grep GREEN"
  done
  echo "HANA DB started..."

#stopping the tenant DB
echo "stoping the source tenant  database now..."
su - "$sid"adm -c "hdbsql -xj -i 02 -n $DATABASE_HOST:30213 -u SYSTEM -p $SOURCE_MASTERPASSWORD alter system stop database $SOURCE_SID_DB"
echo "checking tenant DB is stopped or not.............."
su - "$sid"adm -c "sapcontrol -nr 02 -function GetSystemInstanceList "
#su - "$sid"adm -c "sapcontrol -nr 02 -function GetProcessList"
sleep 60;
su - "$sid"adm -c "sapcontrol -nr 02 -function GetProcessList"
echo "Tenant DB stoppped..."
#renaming the tenant DB

echo "renaming the tenant database"
su - "$sid"adm -c "hdbsql -xj -i 02 -n $DATABASE_HOST:30213 -u SYSTEM -p $SOURCE_MASTERPASSWORD rename database $SOURCE_SID_DB to $SID"
sleep 60;
echo "Tenant DB renamed..."

 #starting tenant DB
echo "starting Tenant DB..."
su - "$sid"adm -c "hdbsql -xj -i 02 -n $DATABASE_HOST:30213 -u SYSTEM -p $SOURCE_MASTERPASSWORD alter system start database $SID"
echo "checking tenant DB is started or not.............."
su - "$sid"adm -c "sapcontrol -nr 02 -function GetSystemInstanceList "
sleep 60;
su - "$sid"adm -c "sapcontrol -nr 02 -function GetProcessList"
echo "Tenant DB started..."

# Change application schema password
echo "change ABAP Schema user SAPHANADB password..."
su - "$sid"adm -c "hdbsql -xj -i 02 -n $DATABASE_HOST -u SYSTEM -p $SOURCE_MASTERPASSWORD ALTER USER SAPHANADB PASSWORD '$saphanadbpasswd'"
su - "$sid"adm -c "hdbsql -xj -i 02 -n $DATABASE_HOST -u SYSTEM -p $SOURCE_MASTERPASSWORD ALTER USER SAPHANADB DISABLE PASSWORD LIFETIME"

# Store SAPHANADB credentials in HDB Store
echo "store SAPHANADB credentials in HDB store..."
su - "$sid"adm -c "hdbuserstore SET DEFAULT $DATABASE_HOST:30215 SAPHANADB '$saphanadbpasswd'"

# Store SYSTEM credentials in HDB Store
echo "store SYSTEM credentials in HDB store..."
su - "$sid"adm -c "hdbuserstore SET W $DATABASE_HOST:30215 SYSTEM $SOURCE_MASTERPASSWORD"

#creating sec folder on hostctrl agent
echo "Updating  the PSE files on Host agent sec directory..."

# Check if sec directory exists, and create it
HOSTCTRLSEC=/usr/sap/hostctrl/exe/sec

if [ -d "$HOSTCTRLSEC" ]; then
        echo "------------------------------------"
        echo "hostctrl already has sec directory"
        echo "------------------------------------"
        cd $HOSTCTRLSEC
else
        echo "------------------------------------"
        echo "hostcrl missing sec dir, creating sec..."
        echo "------------------------------------"
        cd /usr/sap/hostctrl/exe
        mkdir sec
        cd $HOSTCTRLSEC
fi

# Update hostctrl pse
echo "Update hostctrl pse..."
su - sapadm -c "cp /hana/staging/Scripts/NS2-IBPDB.pse /usr/sap/hostctrl/exe/sec/SAPSSLS.pse"
su - sapadm -c "cp /hana/staging/Scripts/NS2-IBPDB.pse /usr/sap/hostctrl/exe/sec/sapsrv.pse"
chown -R sapadm:sapsys /usr/sap/hostctrl/exe/sec

chmod -R 755 /usr/sap/hostctrl/exe/sec
# Restart hostctrl
echo "Restart sap hostctrl process..."
/usr/sap/hostctrl/exe/hostexecstart -restart

# Remove N00 references
echo  "Remove N00 references..."
rm -rf /hana/data/N00
rm -rf /hana/log/N00
rm -rf /hana/shared/N00

echo "DB Installation script finished. Please check logs /tmp/dbinstallation.log"

)2>&1 |tee /tmp/dbinstallation.log