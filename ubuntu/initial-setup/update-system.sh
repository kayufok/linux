#!/bin/bash 
###########################################################################
# 
#   1. updates the list of available packages and their versions
#   2. installs newer versions of the packages
#   3. Setup ufw
#
###########################################################################

# 1. updates the list of available packages and their versions
sudo apt-get update;

# 2. installs newer versions of the packages
sudo apt-get upgrade -y;

# 3. Setup UFW
sudo apt install ufw -y;

sudo ufw default deny incoming;

sudo ufw default allow outgoing;

sudo ufw allow ssh;

sudo ufw allow 22;

sudo ufw enable;

# 7. Setup fail2ban to block ip after failed attempts
sudo apt-get install fail2ban -y;

# fail2ban local config 

printf '%s\n' \
'[DEFAULT]' \
'ignoreip = 127.0.0.1/8 999.999.999.0/24 888.888.888.0/24' \
'' \
'[sshd]' \
'enabled  = true' \
'port     = ssh' \
'filter   = sshd' \
'logpath  = /var/log/auth.log' \
'# backend = systemd' \
'maxretry = 5' \
'findtime = 86400' \
'bantime  = 864000' > /etc/fail2ban/jail.local

# restart fail2ban
systemctl restart fail2ban

# checkban list
#
#
#
fail2ban-client status sshd

# check login hist 
#
#
#
tail -n 100 /var/log/auth.log