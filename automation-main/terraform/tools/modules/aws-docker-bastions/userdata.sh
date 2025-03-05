#!/bin/bash
# This bootstrap script installs docker for ubuntu and creates a basic MOTD.

logger -s "Terraform : Started bootstrap."

ansible-playbook -i localhost, -c local /etc/ansible/playbooks/repository-management.yml -e "repo_enable=true application_preset_selection=['base','epel']"

sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo echo "
Welcome to the Docker Bastion Host!
Some useful commands:
- docker image ls
- docker login <fqdn>
- docker run <fqdn>/<image>:<tag>

- git config --global url."https://gitlab.core.sapns2.us/scs/ste/automation.git".insteadOf "git@gitlab.core.sapns2.us:scs/ste/automation.git"
- git config --system credential.helper store
- git config --global user.email "example@email.internal"
- git config --global user.name "i99999"
- mkdir /repos; cd /repos; git clone https://gitlab.core.sapns2.us/scs/ste/automation

- git restore .
- git pull
- git checkout <branch>
- git switch <branch>

- aws configure
" | sudo tee -a /etc/motd > /dev/null

logger -s "Terraform : Finished bootstrap."
