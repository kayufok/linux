#!/bin/bash 
###########################################################################
# 
#   1. Change Password On Current Account
#   2. Create another login account
#   3. Change Password for login account
#   4. Grant administrator privileges to login account [Optional]
#      Use "sudo" to execute command (e.g sudo ls -la /root)
#   5. Restrict SSH login to root account
#
###########################################################################

# ------------------------------ #
# Initialize Environment Variables
. /home/common/ConfigEnvVar.sh
# ------------------------------ #

# 1. Change Password On Current Account
echo -e "$SystemPassword\n$SystemPassword" | passwd;

# 2. Create another login account
sudo adduser rickyfok --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password;

# 3. Change Password for login account
echo -e "$SystemPassword\n$SystemPassword" | passwd rickyfok;

# 4. Grant administrator privileges to login account [Optional]
#    Install sudo mode if not be installed
usermod -aG sudo rickyfok;

# 5. Restrict SSH login to root account
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config;
# Reload the /etc/ssh/sshd_config to disable Root Login

sudo systemctl start sshd;

sudo systemctl reload sshd;
