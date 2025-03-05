# BUILDING:
#   version='2025-02-15'
#   harbor_fqdn='harbor.dev.ste.dev.scs.sap'
#   container_name='dev_general/ste_runner_tf1.5.7'
#   platform='linux/amd64'
#   docker build --platform=$platform -t $harbor_fqdn/$container_name\:$version .
#   docker push $harbor_fqdn/$container_name\:$version
#   docker tag $harbor_fqdn/$container_name\:$version $harbor_fqdn/$container_name\:latest \
#     && docker push $harbor_fqdn/$container_name\:latest \
#     && docker image rm $harbor_fqdn/$container_name\:latest
#   unset version harbor_fqdn container_name
# USAGE:
#   docker pull $harbor_fqdn/$container_name\:$version
#   docker run -it --rm $harbor_fqdn/$container_name\:$version
# NOTES:
# - Using "from alpine" instead of scratch because of unidentified dependencies in pre-commit.
# - Latest Alpine: curl -L -s 'https://registry.hub.docker.com/v2/repositories/library/alpine/tags'|jq '."results"[]["name"]'
# - Latest Terraform: curl https://api.github.com/repos/hashicorp/terraform/releases/latest | jq --raw-output '.tag_name'
# - https://ashishb.net/all/docker-be-careful-about-the-scratch-image/
# - https://www.hashicorp.com/blog/installing-hashicorp-tools-in-alpine-linux-containers
#   To use hadolint locally. docker run -i --rm hadolint/hadolint:latest < Dockerfile
# - Latest Terraform Docs: curl https://api.github.com/repos/terraform-docs/terraform-docs/releases/latest | jq --raw-output '.tag_name'

# hadolint global ignore=DL3018,DL3059
FROM alpine:3.21.2 AS build
ARG TARGETPLATFORM
ENV TERRAFORM_ARCH=${TARGETPLATFORM//"linux/amd64"/"linux_amd64"}
ENV HADO_ARCH=${TARGETPLATFORM//"linux/amd64"/"x86_64"}
ENV TFDOC_ARCH=${TARGETPLATFORM//"linux/amd64"/"amd64"}
ENV TERRAFORM_ARCH=${TERRAFORM_ARCH//"linux/arm64"/"linux_arm64"}
ENV HADO_ARCH=${HADO_ARCH//"linux/arm64"/"arm64"}
ENV TFDOC_ARCH=${TFDOC_ARCH//"linux/amd64"/"arm64"}

# Not Pinning these given the nature of the container.
RUN apk update
# Add Base Packages
RUN apk add --no-cache git bash openssh-client jq
# Label.py Packages
RUN apk add --no-cache python3 py3-requests
# Pre-commit/TFDoc Packages
RUN apk add --no-cache pre-commit python3-dev musl-dev perl py3-certifi py3-urllib3

ARG PRODUCT="terraform"
ARG VERSION="1.5.7"
ARG HADO_VERSION="2.12.0"
ARG TF_DOC_VERSION="0.19.0"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
WORKDIR /tmp
RUN \
apk add --update --virtual .deps --no-cache gnupg \
&& wget -q https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_${TERRAFORM_ARCH}.zip \
&& wget -q https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_SHA256SUMS \
&& wget -q https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_SHA256SUMS.sig \
&& wget -qO- https://www.hashicorp.com/.well-known/pgp-key.txt | gpg --import \
&& gpg --verify ${PRODUCT}_${VERSION}_SHA256SUMS.sig ${PRODUCT}_${VERSION}_SHA256SUMS \
&& grep ${PRODUCT}_${VERSION}_linux_amd64.zip ${PRODUCT}_${VERSION}_SHA256SUMS | sha256sum -c \
&& unzip /tmp/${PRODUCT}_${VERSION}_linux_amd64.zip -d /tmp \
&& mv /tmp/${PRODUCT} /usr/local/bin/${PRODUCT} \
&& rm -f /tmp/${PRODUCT}_${VERSION}_linux_amd64.zip ${PRODUCT}_${VERSION}_SHA256SUMS ${VERSION}/${PRODUCT}_${VERSION}_SHA256SUMS.sig \
&& apk del .deps \
&& mkdir -p /root/.terraform.d/plugin_cache \
&& touch /root/.terraformrc \
&& echo 'plugin_cache_dir="/root/.terraform.d/plugin_cache"' > /root/.terraformrc

RUN \
wget -q -O "/usr/bin/hadolint" "https://github.com/hadolint/hadolint/releases/download/v${HADO_VERSION}/hadolint-Linux-${HADO_ARCH}" \
&& chmod a+x "/usr/bin/hadolint"

RUN \
wget -qO- \
  "https://github.com/terraform-docs/terraform-docs/releases/download/v${TF_DOC_VERSION}/terraform-docs-v${TF_DOC_VERSION}-linux-${TFDOC_ARCH}.tar.gz" \
  | tar xvz -C /usr/local/bin

COPY copyfile-precommit.yaml /tmp/precommit.yaml
RUN git init \
    && pre-commit install-hooks -c /tmp/precommit.yaml

FROM alpine:3.21.2

COPY --from=build /root/.terraform.d /root/.terraform.d
COPY --from=build /root/.terraformrc /root/.terraformrc
COPY --from=build /root/.cache/pre-commit /root/.cache/pre-commit
COPY --from=build /usr/local/bin/terraform /usr/local/bin/terraform
COPY --from=build /usr/bin/hadolint /usr/bin/hadolint
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=build /usr/share/git-core /usr/share/git-core
COPY --from=build /usr/libexec/git-core /usr/libexec/git-core
COPY --from=build /usr/lib/python3.12 /usr/lib/python3.12
COPY --from=build \
  /usr/bin/git \
  /usr/bin/pre-commit \
  /usr/bin/python \
  /usr/bin/python3 \
  /usr/bin/python3.12 \
  /usr/bin/basename \
  /usr/bin/dirname \
  /usr/bin/tail \
  /usr/bin/tr \
  /usr/bin/sort \
  /usr/bin/perl \
  /usr/bin/ssh \
  /usr/bin/jq \
  /usr/bin/
COPY --from=build \
  /lib/ld-musl-x86_64.so.1 \
  /lib/
COPY --from=build \
  /usr/lib/libbrotlicommon.so.1 \
  /usr/lib/libbrotlidec.so.1 \
  /usr/lib/libcares.so.2 \
  /usr/lib/libcrypto.so.3 \
  /usr/lib/libcurl.so.4 \
  /usr/lib/libexpat.so.1 \
  /usr/lib/libidn2.so.0 \
  /usr/lib/libncursesw.so.6 \
  /usr/lib/libnghttp2.so.14 \
  /usr/lib/libonig.so.5 \
  /usr/lib/libpcre2-8.so.0 \
  /usr/lib/libpsl.so.5 \
  /usr/lib/libpython3.12.so.1.0 \
  /usr/lib/libreadline.so.8 \
  /usr/lib/libsqlite3.so.0 \
  /usr/lib/libssl.so.3 \
  /usr/lib/libunistring.so.5 \
  /usr/lib/libz.so.1 \
  /usr/lib/libzstd.so.1 \
  /usr/lib/perl5/core_perl/CORE/libperl.so \
  /usr/lib/
COPY --from=build \
  /bin/ls \
  /bin/sh \
  /bin/date \
  /bin/sed \
  /bin/uname \
  /bin/bash \
  /bin/pwd \
  /bin/grep \
  /bin/mktemp \
  /bin/rm \
  /bin/
COPY --from=build \
  /usr/local/bin/terraform-docs \
  /usr/local/bin

ENTRYPOINT [ "/bin/bash" ]
