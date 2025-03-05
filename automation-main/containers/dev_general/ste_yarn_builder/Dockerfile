# BUILDING:
#   version='2025-02-15'
#   harbor_fqdn='harbor.dev.ste.dev.scs.sap'
#   container_name='dev_general/ste_yarn_builder'
#   platform='linux/amd64,linux/arm64/v8'
#   docker build --platform=$platform -t $harbor_fqdn/$container_name\:$version .
#   docker push $harbor_fqdn/$container_name\:$version
#   docker tag $harbor_fqdn/$container_name\:$version $harbor_fqdn/$container_name\:latest \
#     && docker push $harbor_fqdn/$container_name\:latest \
#     && docker image rm $harbor_fqdn/$container_name\:latest
#   unset version harbor_fqdn container_name
# USAGE:
#   docker pull $harbor_fqdn/$container_name\:$version
#   MY_DOCUSAURUS_REPO=~/Repos/scs/documentation/production/
#   docker run -it \
#    -v $MY_DOCUSAURUS_REPO:/mnt/docusaurus \
#    -p 3000:3000 \
#    --rm dev_general/ste_yarn_builder_amd64:$version
# NOTES:
# - This container is not really suitable as a runner. Yarn and NPM are both package managers themselves.
# - The process of docusaurus process itself generates lots of temp files from the yarn install and yarn build.
# - These temp files (.docusaurus and node_modules) will be saved to the mounted Docusaurus repo volume.
# - hadolint is optional for now.

# hadolint global ignore=DL3018,DL3059
FROM alpine:3.21.2 AS build
RUN apk update
RUN apk add --no-cache bash
# YARN packages
RUN apk add --no-cache yarn npm
RUN yarn install && yarn cache clean

COPY welcome.txt /etc/motd
RUN echo 'cat /etc/issue && cat /etc/motd' >> /etc/bash/bashrc
COPY ./copyfile-yarn_run.sh /root/yarn_run.sh
RUN chmod a+x /root/yarn_run.sh
ENTRYPOINT [ "/bin/bash" ]
