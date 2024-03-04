#!/bin/sh

hostname='placeholder'
username='placeholder'
password='placeholder'

ln -sf /usr/share/zoneinfo/America/Bahia > /etc/localtime

hwclock --systohc

echo $hostname > /etc/hostname
echo 'LANG=en_US.UTF-8' > etc/locale.conf

useradd -mG groups -s /bin/zsh $username

file_path="/etc/NetworkManager/conf.d/wifi-powersave.conf"
echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $file_path

systemctl enable sshd
systemctl enable Networkmanager
systemctl enable bluetooth
systemctl enable --user pipewire
systemctl enable --user wireplumber