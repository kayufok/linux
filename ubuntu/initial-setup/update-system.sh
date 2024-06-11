#!/bin/bash
###########################################################################
#
#   1. updates the list of available packages and their versions
#   2. installs newer versions of the packages
#   3. Setup ufw
#   4. Change SSH default port to 915
#
###########################################################################

# 1. updates the list of available packages and their versions
sudo apt update

# 2. installs newer versions of the packages
sudo apt full-upgrade -y

# 3. Setup UFW
sudo apt install ufw -y

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw enable

# 4. Change SSH default port to 915
# Backup the SSH configuration file
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Modify the SSH configuration file to change the port
sudo sed -i 's/^#Port 22/Port 915/' /etc/ssh/sshd_config

# Allow the new SSH port through UFW and remove the old rule
sudo ufw allow 915/tcp
sudo ufw delete allow ssh

# Restart SSH service to apply the new configuration
sudo systemctl restart ssh

# 5. Setup fail2ban to block IPs after failed attempts
sudo apt install fail2ban -y

# fail2ban local config
sudo cat <<EOT > /etc/fail2ban/jail.local
[DEFAULT]
ignoreip = 127.0.0.1/8 999.999.999.0/24 888.888.888.0/24

[sshd]
enabled  = true
port     = 915
filter   = sshd
logpath  = /var/log/auth.log
# backend = systemd
maxretry = 5
findtime = 86400
bantime  = 864000
EOT

# restart fail2ban
sudo systemctl restart fail2ban

# check Fail2Ban status for sshd
sudo fail2ban-client status sshd

# check login history
tail -n 100 /var/log/auth.log
