#!/bin/bash
# Synopsis: Scipt used to document process of how to download and build the aws-efs-utils RPM file
# Usage:
#   Download and build the RPM file:
#     ./build-aws-efs-utils-rpm.sh
#   Download and build the RPM file the upload to AWS S3 bucket:
#     ./build-aws-efs-utils-rpm.sh ns2-cre-sms-binaries media/aws-efs-utils

VERSION=v1.30.2

S3_BUCKET=$1
S3_PATH=$2

sudo yum -y install git rpm-build make
git clone https://github.com/aws/efs-utils
cd efs-utils
git checkout -b ${VERSION}
make rpm
cd build
BUILT_RPM=$( ls amazon-efs-utils-${VERSION/v}*.rpm )
echo ${BUILT_RPM}

if [ ! -z "$S3_BUCKET" ] && [ ! -z "$S3_PATH" ]; then
  aws s3api put-object \
    --bucket ${S3_BUCKET} \
    --key ${S3_PATH}/${BUILT_RPM} \
    --body ${BUILT_RPM}
fi
