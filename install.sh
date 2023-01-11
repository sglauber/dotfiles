#! /bin/bash
set -eu -o pipefail

# Pre install
# For some reason this key wasnt signed when I tried to install openssl 
# Here im signing this key locally, maybe the best thing to do would be greping all "unstrusted" keys from pacman-keys and signing all 
pacman-key -l Shcmitz | grep -i 3E80CA | xargs -a '{}' pacman-key --lsign-key '{}'

pacman --noconfirm -S archlinux-keyring >/dev/null 2>&1
pacman --noconfirm --needed -S && pacman -Sy >/dev/null 2>&1
pacman-key --populate archlinux >/dev/null 2>&1

username=""
hostname=""
password=""
yayrepo="https://aur.archlinux.org/yay.git"
EFIDIR="/boot/EFI"

# Install base packages
pacman -S --noconfirm grub efibootmgr os-prober dosfstools

#adduserandpass() {
  # Adds user `$name` with password `$password`.
  #useradd -m -g wheel -s /bin/zsh "$username" >/dev/null 2>&1 ||
  #usermod -a -G wheel "$username" && mkdir -p /home/"$username" && chown "$username":wheel /home/"$username"
  #echo "$username:$password" | chpasswd
  #unset password 
#}


# Set hostname
echo $hostname > /etc/hostname

# Hosts
tee -a /etc/hosts << EOF
127.0.0.1	localhost
::1		localhost
127.0.1.1	localdomain.$hostname	$hostname
EOF

# Install zsh
pacman -S --noconfirm zsh

# Add user
useradd -m -g users -G users,audio,lp,optical,storage,video,wheel,games,power,scanner,network -s /bin/zsh $username

# sed -i '/%wheel ALL=(ALL) ALL/s/^#//' /etc/sudoers
echo $password | sudo -u $username

# Please wait...
sleep 1 
mount /dev/sdb1 /boot/

# echo "Installing grub..."
mkdir -vp $EFIDIR \
	&& grub-install --target="x86_64-efi" --efi-directory=$EFIDIR --bootloader-id="GRUB" \
	&& grub-mkconfig -o /boot/grub/grub.cfg

# Install yay
cd /tmp && git clone $yayrepo \
&& cd yay && makepkg --noconfirm -si

# Download utilities packages
yay -S --noconfirm  bluez \
	tmux \
	freerdp \
	brave-bin  \
	qutebrowser \
	bluez-utils  \
	rustdesk-bin  \
	networkmanager \

# Install audio and media packages
yay -S --noconfirm pipewire \
	mpv \
	wireplumber  \
	pipewire-jack \
	pipewire-pulse

# Install Xorg, wm, bg managers and compositors
yay -S --noconfirm xorg-server \
	feh \
	xorg-apps \
	xorg-xinit \
	xorg-xmessage \
	picom-jonaburg-git

# Install XMonad packages and dependencies
yay -S --noconfirm xmonad \
	ibx11 \
	xmobar \
	libxft \
	libxss \
	libxrandr \
 	libxinerama \
	xmonad-contrib \

# Enable sytemd services

# Enable Network Manager
sudo systemctl enable NetworkManager

# Enable Bluetoothctl
sudo systemctl enable bluetooth

# Enable Pipewire
sudo systemctl --user enable pipewire
sudo systemctl --user enable pipewire-pulse

# Reboot
sudo reboot
