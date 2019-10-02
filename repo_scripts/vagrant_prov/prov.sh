#!/usr/bin/env bash

## system
# getting the most up to date packages from the last package
apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -o Dpkg::Options::='--force-confnew'
sudo DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y -o Dpkg::Options::='--force-confnew'

if grep 'ID=kali' /etc/*release ; then
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::='--force-confnew' docker-compose
    ## metasploit
    # initializing the msf db
    msfdb init
    systemctl enable --now postgresql
    systemctl enable --now docker
fi

if [[ -f /var/run/reboot-required ]] ; then
    echo 'Shutdown required please vagrant up again.'
    sudo shutdown
fi