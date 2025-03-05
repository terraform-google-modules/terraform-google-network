#!/bin/sh
HIGHEST_MAJOR_VERSION='0'
HIGHEST_MINOR_VERSION='0'
WDISP_RELEASES=$(ls /staging/webdispatcher/Build/ | grep WDISP | tr '\n' ' ')

for release in $WDISP_RELEASES
do
  WDISP_MAJOR_VERSION=$(echo $release | cut -d'-' -f2 | sed 's/Rel//')
  WDISP_MINOR_VERSION=$(echo $release | cut -d'-' -f3 | sed 's/PL//')
  if [[ $WDISP_MAJOR_VERSION -gt $HIGHEST_MAJOR_VERSION ]]
  then
    HIGHEST_MAJOR_VERSION=$WDISP_MAJOR_VERSION
    HIGHEST_MINOR_VERSION='0'
  fi
  if [[ ${WDISP_MINOR_VERSION#0} -gt ${HIGHEST_MINOR_VERSION#0} ]]
  then
    HIGHEST_MINOR_VERSION=$WDISP_MINOR_VERSION
  fi
done
# Output full release name
echo "WDISP-Rel${HIGHEST_MAJOR_VERSION}-PL${HIGHEST_MINOR_VERSION}-TAR"