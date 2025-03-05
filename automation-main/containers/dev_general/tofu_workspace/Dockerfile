# BUILDING:
#   version='2025-02-15'
#   harbor_fqdn='harbor.dev.ste.dev.scs.sap'
#   container_name='dev_general/tofu_workspace'
#   platform='linux/amd64,linux/arm64/v8'
#   docker build --platform=$platform -t $harbor_fqdn/$container_name\:$version .
#   docker push $harbor_fqdn/$container_name\:$version
#   docker tag $harbor_fqdn/$container_name\:$version $harbor_fqdn/$container_name\:latest \
#     && docker push $harbor_fqdn/$container_name\:latest \
#     && docker image rm $harbor_fqdn/$container_name\:latest
#   unset version harbor_fqdn container_name
# NOTE: Multi-platform build requires you to turn on ContainerD Image Store in Docker Desktop
# USAGE:
#   docker pull $harbor_fqdn/$container_name\:$version
#   STE_AUTOMATION=~/Repos/scs/ste/automation   # REQUIRED Path to STE Automation repo
#   MY_REPOS_PATH=~/Repos                       # (Optional) Path to your other repos
#   MY_AWS_CONFIG_PATH=~/.aws/config            # (Optional) Path to your AWS config
#   MY_AWS_CREDENTIAL_PATH=~/.aws/credentials   # (Optional) Path to your AWS credentials
#   TF_VAR_build_user="i999999"                 # (Optional) Build user (for Terraform)
#   AWS_PROFILE="ibpdev"                        # (Optional) AWS profile
#   docker run -it \
#     -v $STE_AUTOMATION:/mnt/ste_automation \
#     -v $MY_REPOS_PATH:/mnt/repos \
#     -v $MY_AWS_CONFIG_PATH:/root/.aws/config \
#     -v $MY_AWS_CREDENTIAL_PATH:/root/.aws/credentials \
#     --env TF_VAR_build_user=$TF_VAR_build_user \
#     --env AWS_PROFILE=$AWS_PROFILE \
#     --rm $harbor_fqdn/$container_name:$version
# NOTES:
# - This container is only intended to be used as a generic execution environment.  It does not support editing and modifying files.
# - Find latest pip versions:   pip3 index versions <package name>
# - Find latest Azure CLI version: curl https://api.github.com/repos/Azure/azure-cli/releases/latest | jq '.tag_name'
# - Upgrade all installed Ansible Collections: \
#     for module in $(ansible-galaxy collection list | grep -E '[a-z._0-9]+ +[0-9]' | awk '{print $1}') ; do ansible-galaxy collection install -U $module ; done
# - Find the latest version of AWS CLI
#     curl -s https://raw.githubusercontent.com/aws/aws-cli/v2/CHANGELOG.rst | egrep -oe '^\d+\.\d+\.\d+' | head -n 1
# - Find the latest TENV
#     curl --silent https://api.github.com/repos/tofuutils/tenv/releases/latest | jq -r .tag_name
# - Need to DOWNGRADE and CAP Ansible Core version to 2.16.x as 2.17.x won't work with RHEL8
# - Stay on Python 3.12.x due to Azure Python/Compiler Dependencies for now.

# hadolint global ignore=DL3008,DL3059
FROM python:3.13.1-slim-bookworm
ARG TARGETPLATFORM
ENV AWS_ARCH=${TARGETPLATFORM//"linux/amd64"/"x86_64"}
ENV AWS_ARCH=${AWS_ARCH//"linux/arm64"/"aarch64"}
ENV TENV_ARCH=${TARGETPLATFORM//"linux/amd64"/"amd64"}
ENV TENV_ARCH=${TENV_ARCH//"linux/arm64"/"arm64"}
ENV TOFU_ARCH=${TENV_ARCH}

ARG AZURE_CLI="2.68.0-1~bookworm" \
    AWS_CLI="2.23.7" \
    TOFU_VERSION="1.9.0" \
    TENV="v4.1.0"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
WORKDIR /tmp

# Install Local Providers Mirror
COPY copyfile-tofurc /root/.tofurc
COPY copyfile-versions.tf /tmp/versions.tf
RUN \
apt-get update && apt-get install --no-install-recommends -y wget \
&& wget -q -O "/tmp/opentofu.deb" "https://github.com/opentofu/opentofu/releases/download/v${TOFU_VERSION}/tofu_${TOFU_VERSION}_${TOFU_ARCH}.deb" \
&& dpkg --install /tmp/opentofu.deb \
&& mkdir -p /root/.cache/tf_providers_mirror \
&& mkdir -p /root/.tofu.d/plugin_cache \
&& tofu providers mirror /root/.cache/tf_providers_mirror \
&& dpkg --purge tofu \
&& rm /tmp/opentofu.deb \
&& apt-get autoremove -y wget \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

# Trying TENV instead of just a TOFU install: https://github.com/tofuutils/tenv
RUN \
apt-get update && apt-get install --no-install-recommends -y wget \
&& wget -q -O "/tmp/tenv.deb" "https://github.com/tofuutils/tenv/releases/download/${TENV}/tenv_${TENV}_${TENV_ARCH}.deb" \
&& dpkg -i "/tmp/tenv.deb" \
&& rm -rf "/tmp/tenv.deb" \
&& apt-get autoremove -y wget \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

# Install AWS CLI
RUN \
apt-get update && apt-get install --no-install-recommends -y unzip wget \
&& wget -q -O "/tmp/awscliv2.zip" "https://awscli.amazonaws.com/awscli-exe-linux-${AWS_ARCH}-${AWS_CLI}.zip" \
&& unzip /tmp/awscliv2.zip -d /tmp/ \
&& /tmp/aws/install \
&& rm -rf /tmp/aws /tmp/awscliv2.zip \
&& apt-get autoremove -y unzip wget \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Azure CLI
COPY ./copyfile-azure-cli.sources /tmp/azure-cli.sources
RUN \
apt-get update && apt-get install --no-install-recommends -y gpg wget \
&& mv /tmp/azure-cli.sources /etc/apt/sources.list.d/azure-cli.sources \
&& mkdir -p /etc/apt/keyrings \
&& wget -q -O /tmp/microsoft.asc https://packages.microsoft.com/keys/microsoft.asc \
&& gpg --dearmor /tmp/microsoft.asc \
&& mv /tmp/microsoft.asc.gpg /etc/apt/keyrings/microsoft.gpg \
&& chmod go+r /etc/apt/keyrings/microsoft.gpg \
&& apt-get update && apt-get install --no-install-recommends -y "azure-cli=${AZURE_CLI}" \
&& apt-get autoremove -y gpg wget \
&& apt-get clean && rm -rf /var/lib/apt/lists/* \
&& rm -rf /root/.wget-hsts /tmp/microsoft.asc

# Install Ansible
COPY ./copyfile-ansible.cfg /root/.ansible.cfg
COPY ./ansible_pip_requirements.txt /tmp/ansible_pip_requirements.txt
COPY ./ansible_collection.yml /tmp/ansible_collection.yml
RUN pip3 install --no-cache-dir -r /tmp/ansible_pip_requirements.txt
RUN ansible-galaxy collection install -r /tmp/ansible_collection.yml

# Compile Azure Collection Requirements
RUN \
apt-get update && apt-get install --no-install-recommends -y gcc libc6-dev \
&& pip3 install --no-cache-dir -r /root/.ansible/collections/ansible_collections/azure/azcollection/requirements.txt \
&& apt-get autoremove -y gcc libc6-dev \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

# Other Packages we want, not required by previous installs.
# These should be Pinned
# jq openssh sshpass required by Ansible
# curl, unzip, less, vim-tiny, git added for convenience by request
# Please add packages on a newline followed by it's depedencies.

# Stupid debian package versioning......
ENV SSHPASS_VERSION=${TARGETPLATFORM//"linux/amd64"/"1.09-1+b1"}
ENV SSHPASS_VERSION=${SSHPASS_VERSION//"linux/arm64"/"1.09-1"}
RUN \
apt-get update && apt-get install --no-install-recommends -y \
  openssh-client=1:9.2p1-2+deb12u4 libbsd0=0.11.7-2 libcbor0.8=0.8.0-2+b1 libedit2=3.1-20221030-2 libfido2-1=1.12.0-2+b1 \
  jq=1.6-2.1 libjq1=1.6-2.1 libonig5=6.9.8-1 \
  sshpass=${SSHPASS_VERSION} \
  curl=7.88.1-10+deb12u8 libbrotli1=1.0.9-2+b6 libcurl4=7.88.1-10+deb12u8 libldap-2.5-0=2.5.13+dfsg-5 libnghttp2-14=1.52.0-1+deb12u2 libpsl5=0.21.2-1 librtmp1=2.4+20151223.gitfa8646d.1-2+b2 libsasl2-2=2.1.28+dfsg-10 libsasl2-modules-db=2.1.28+dfsg-10 libssh2-1=1.10.0-3+b1 \
  unzip=6.0-28 \
  rsync=3.2.7-1+deb12u2 libpopt0=1.19+dfsg-1 \
  git=1:2.39.5-0+deb12u2 git-man=1:2.39.5-0+deb12u2 libbrotli1=1.0.9-2+b6 libcurl3-gnutls=7.88.1-10+deb12u8 liberror-perl=0.17029-2 libexpat1=2.5.0-1+deb12u1 libgdbm-compat4=1.23-3 libldap-2.5-0=2.5.13+dfsg-5 libnghttp2-14=1.52.0-1+deb12u2 libperl5.36=5.36.0-7+deb12u1 libpsl5=0.21.2-1 librtmp1=2.4+20151223.gitfa8646d.1-2+b2 libsasl2-2=2.1.28+dfsg-10 libsasl2-modules-db=2.1.28+dfsg-10 libssh2-1=1.10.0-3+b1 perl=5.36.0-7+deb12u1 perl-modules-5.36=5.36.0-7+deb12u1 \
  vim-tiny=2:9.0.1378-2 vim-common=2:9.0.1378-2 \
  less=590-2.1~deb12u2 \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

RUN update-ca-certificates
ENV TF_VAR_git_name="" \
    TF_VAR_git_token="" \
    STE_AUTOMATION="/mnt/ste_automation"

COPY welcome.txt /etc/motd
RUN echo 'cat /etc/issue && cat /etc/motd' >> /etc/bash.bashrc
WORKDIR /mnt
ENTRYPOINT [ "/bin/bash" ]
