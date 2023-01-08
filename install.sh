#! /bin/bash
set -eu -o pipefail

# Pre install
# For some reason this key wasnt signed when I tried to install openssl 
# Here im signing this key locally, maybe the best thing to do would be greping all "unstrusted" keys from pacman-keys and signing all 
# pacman-key -l Shcmitz | grep -i 3E80CA | xargs -a '{}' pacman-key --lsign-key '{}'

refreshkeys() {
	case "$(readlink -f /sbin/init)" in
	*systemd*)
		whiptail --infobox "Refreshing Arch Keyring..." 7 40
		pacman --noconfirm -S archlinux-keyring >/dev/null 2>&1
		;;
	*)
		whiptail --infobox "Enabling Arch Repositories..." 7 40
		if ! grep -q "^\[universe\]" /etc/pacman.conf; then
			echo "[universe]
Server = https://universe.artixlinux.org/\$arch
Server = https://mirror1.artixlinux.org/universe/\$arch
Server = https://mirror.pascalpuffke.de/artix-universe/\$arch
Server = https://artixlinux.qontinuum.space/artixlinux/universe/os/\$arch
Server = https://mirror1.cl.netactuate.com/artix/universe/\$arch
Server = https://ftp.crifo.org/artix-universe/" >>/etc/pacman.conf
			pacman -Sy --noconfirm >/dev/null 2>&1
		fi
		pacman --noconfirm --needed -S \
			artix-keyring artix-archlinux-support >/dev/null 2>&1
		for repo in extra community; do
			grep -q "^\[$repo\]" /etc/pacman.conf ||
				echo "[$repo]
Include = /etc/pacman.d/mirrorlist-arch" >>/etc/pacman.conf
		done
		pacman -Sy >/dev/null 2>&1
		pacman-key --populate archlinux >/dev/null 2>&1
		;;
	esac
}

username=""
hostname=""
password=""
yayrepo="https://aur.archlinux.org/yay.git"
EFIDIR="/boot/EFI"

# Install base packages
# pacman -S --noconfirm grub efibootmgr os-prober dosfstools

adduserandpass() {
	# Adds user `$name` with password $pass1.
	whiptail --infobox "Adding user \"$username\"..." 7 50
	useradd -m -g wheel -s /bin/zsh "$username" >/dev/null 2>&1 ||
		usermod -a -G wheel "$username" && mkdir -p /home/"$username" && chown "$username":wheel /home/"$username"
	export repodir="/home/$name/.local/src"
	mkdir -p "$repodir"
	chown -R "$name":wheel "$(dirname "$repodir")"
	echo "$username:$password" | chpasswd
	unset pass1 pass2
}

# echo "Installing grub..."
# mkdir -vp $EFIDIR && grub-install --target="x86_64-efi" --efi-directory=$EFIDIR --bootloader-id="GRUB" && grub-mkconfig -o /boot/grub/grub.cfg

# Set hostname
#echo $hostname > /etc/hostname

# Hosts

#tee -a /etc/hosts << EOF
#127.0.0.1	localhost
#::1		localhost
#127.0.1.1	localdomain.$hostname	$hostname
#EOF

# Install Zshell 
# pacman -S zsh --noconfirm

# Add user
# useradd -m -g users -G users,audio,lp,optical,storage,video,wheel,games,power,scanner,network -s /bin/zsh $username

# n funcionou sed -i '/%wheel ALL=(ALL) ALL/s/^#//' /etc/sudoers

# sudo -u $username -s

# Install yay
# cd /tmp && git clone $yayrepo \
# && cd yay && makepkg --noconfirm -si


# Download packages
# yay -S --noconfirm networkmanager bluez bluez-utils

# Install audio packages
yay -S --noconfirm pipewire \
	wireplumber \
	pipewire-jack \
	pipewire-pulse

# Install Xorg, wm, bg managers and compositors
yay -S --noconfirm xorg-server \
	xorg-apps \
	xorg-xinit \
	xorg-xmessage

# Install XMonad packages and dependencies
yay -S --noconfirm xmonad \
	feh \
	xmobar \
	xmonad-contrib \
	picom-jonaburg-git

# Enable things 
# Need to check if isnt already enabled

# Enable Network Manager
# sudo systemctl enable NetworkManager

# Enable Bluetoothctl
# sudo systemctl enable bluetooth

# Enable Pipewire
sudo systemctl --user enable pipewire
sudo systemctl --user enable pipewire-pulse

# Reboot
# sudo reboot
