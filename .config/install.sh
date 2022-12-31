#!/bin/bash
set -eu -o pipefail

# Glauber Santana <glauber.silva14@gmail.com>

# Needed packages
pacman -S networkmanager git neovim zsh pipewire pipewire-pulse pipewire-jack

# local vars
username = "sglauber"
hostname = "anchor"

# Network settings
echo '$hostname' >> /etc/hostname

tee -a /etc/hosts << EOF
127.0.0.1   localhost
::1         localhost
127.0.1.1   localdomain.anchor anchor
EOF

# User settings
setUser() {
  useradd -m -g users -G users,audio,lp,optical,storage,video,wheel,power,scanner -s /bin/zsh $username
  sed -i '/%wheel ALL=(ALL) ALL/s/^#//' /etc/sudoers
  sudo -u $username
}

getYay() {
  cd /tmp
  git clone https://aur.archlinux.org/yay.git && cd yay
  makepkg -si
}

installPackages(){
  # Xorg
  yay -S --no-confirm xorg-apps \
  alacritty \
  xorg-xinit \
  xorg-server \
  xorg-xmessage \

  # XMonad libs
  yay -S --no-confirm libxft \
  libx11 \
  libxss \
  libxrandr \
  libxinerama \
  pkgconf 

  # XMonad & Compositions
  yay -S --no-confirm picom-jonaburg-git \
  feh \
  xmonad \
  xmobar  \
  xmonad-contrib \
  # browser & media
  yay -S mpv qutebrowser google-chrome-stable
}



