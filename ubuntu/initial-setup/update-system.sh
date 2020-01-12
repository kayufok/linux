#!/bin/bash 
###########################################################################
# 
#   1. updates the list of available packages and their versions
#   2. installs newer versions of the packages
#   3. Setup ufw
#
###########################################################################

# 1. updates the list of available packages and their versions
apt-get update;

# 2. installs newer versions of the packages
apt-get upgrade -y;

# 3. Setup UFW
apt install ufw -y;

ufw default deny incoming;

ufw default allow outgoing;

ufw allow ssh;

ufw allow 22;

ufw allow 2222;

ufw enable;