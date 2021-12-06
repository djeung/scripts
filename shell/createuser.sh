# User input vars
#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

echo "Create a new user"
echo "Have SSH public key ready"
echo "================================="
read -p "New username: " newuser
read -p "Add to sudo: [y|N]? " sudopriv

useradd -m -d /home/${newuser} -s /bin/bash ${newuser}
mkdir /home/${newuser}/.ssh 
chmod 700 /home/${newuser}/.ssh
touch /home/${newuser}/.ssh/authorized_keys
chmod 600 /home/${newuser}/.ssh/authorized_keys
chown -R ${newuser}:${newuser} /home/${newuser}/.ssh

if [[ "$sudopriv" = "y" ]]; then
usermod -aG wheel ${newuser}
fi

echo "Paste in SSH public key"
echo "================================="
read -p "SSH public key for : " varpubkey

echo "${varpubkey}" >> /home/${newuser}/.ssh/authorized_keys

echo "================================="
echo "${newuser} created"
