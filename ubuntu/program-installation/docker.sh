#!/bin/bash 
###########################################################################
# 
#   Installation of Docker
#   1. Uninstall old versions
#   2. update ubuntu
#   3. Install packages to allow apt to use a repository over HTTPS:
#   4. Start the Docker daemon and enable it to automatically start at boot time
#
#   Reference: https://docs.docker.com/v17.09/engine/installation/linux/docker-ce/ubuntu/#prerequisites
###########################################################################

# 1. Uninstall old versions
sudo apt-get remove docker docker-engine docker.io;

# 2. update ubuntu
sudo apt-get update;

# 3. Install packages to allow apt to use a repository over HTTPS:
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common;

# 4. Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;

# 5. set up the stable repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable";

# 6. Update the apt package index.
sudo apt-get update;


# 7. Install the latest version of Docker CE
sudo apt-get install docker-ce docker-ce-cli containerd.io -y;


