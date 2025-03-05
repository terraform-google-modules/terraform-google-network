#!/bin/bash
# Synopsis: Scipt used to document process of how to download and build the aws-efs-utils DEB file
# Usage:
#   Download and build the DEB file:
#     ./build-aws-efs-utils-deb.sh
#   Download and build the DEB file the upload to AWS S3 bucket:
#     ./build-aws-efs-utils-deb.sh ns2-cre-sms-binaries media/aws-efs-utils

VERSION=v1.30.2

S3_BUCKET=$1
S3_PATH=$2

sudo apt-get -y install git binutils
git clone https://github.com/aws/efs-utils
cd efs-utils
git checkout -b ${VERSION}
make deb
cd build
BUILT_DEB=$( ls amazon-efs-utils-${VERSION/v}*.deb )
echo ${BUILT_DEB}

if [ ! -z "$S3_BUCKET" ] && [ ! -z "$S3_PATH" ]; then
  aws s3api put-object \
    --bucket ${S3_BUCKET} \
    --key ${S3_PATH}/${BUILT_DEB} \
    --body ${BUILT_DEB}
fi
