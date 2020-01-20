#!/bin/bash 
###############################################################################################
# 
#   **********************************************************************
#   **** Remark: Switch to Login Account and stay at its root folder  ****
#   **********************************************************************
#   1. Create RSA Key
#   2. Grant Right to generated public key for "sshd" to read
#   3. Copy generated public key to server 
#   4. Enable ssh key login
#   5. Set TWO FACTOR login (Password and SSH Key)
#   6. Restart sshd.service to enable the setting
#   Reference:
#   https://www.digitalocean.com/community/tutorials/initial-server-setup-with-centos-7
###############################################################################################
# ------------------------------------------------------------ #
# Switch user
su rickyfok;
# Define Variables
SERVER_IP_ADDRESS="$(ip route get 1 | awk '{print $NF;exit}')";
# ------------------------------------------------------------ #

# 1. Create RSA Key
cd /home/$USER;
echo -e "\n"|ssh-keygen -N "";

# 2. Grant Right to generated public key for "sshd" to read
chmod 755 ~/.ssh;

# 3. Copy generated public key to ~/.ssh/authorized_keys
ssh-copy-id $USER@$SERVER_IP_ADDRESS;

# 4. Enable ssh key login - !!ROOT account!!
exit;
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config;

# 5. Set TWO FACTOR login (Password and SSH Key) - !!ROOT account!!
echo -n "AuthenticationMethods publickey" >> /etc/ssh/sshd_config;

# 6. Restart sshd.service to enable the setting - !!ROOT account!!
systemctl restart sshd.service;
