#!/usr/bin/env bash


REPO_DIR=~/Projects/github/mvsde/dotfiles
APPS_DIR=~/Projects/apps


# Git

ln --symbolic $REPO_DIR/configs/.gitconfig ~/.gitconfig


# bat
# https://github.com/sharkdp/bat

mkdir --parents ~/.config/bat/
ln --symbolic $REPO_DIR/configs/bat.ini ~/.config/bat/config


# Oh My Zsh
# https://ohmyz.sh/#install

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cd $ZSH_CUSTOM/plugins

git clone git@github.com:zsh-users/zsh-syntax-highlighting.git
git clone git@github.com:zsh-users/zsh-autosuggestions.git

cd $REPO_DIR

ln --symbolic $REPO_DIR/configs/.zshrc ~/.zshrc


# Starship
# https://starship.rs/

sh -c "$(curl -fsSL https://starship.rs/install.sh)"
ln --symbolic $REPO_DIR/configs/starship.toml ~/.config/starship.toml


# Node.js
# https://github.com/nvm-sh/nvm/blob/master/README.md

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

nvm install

# npm saves auth tokens to the config file, so this can’t be linked.
cp $REPO_DIR/configs/.npmrc ~/.npmrc

ln --symbolic $REPO_DIR/configs/.nuxtrc ~/.nuxtrc
ln --symbolic $REPO_DIR/configs/nvm-default-packages $NVM_DIR/default-packages


# Flatpak

flatpak install com.github.jeromerobert.pdfarranger
flatpak install com.rafaelmardojai.SharePreview
flatpak install flathub com.belmoussaoui.Obfuscate
flatpak install flathub com.github.liferooter.textpieces
flatpak install flathub com.github.maoschanz.drawing
flatpak install flathub com.rafaelmardojai.WebfontKitGenerator
flatpak install flathub com.raggesilver.BlackBox
flatpak install flathub dev.geopjr.Tuba
flatpak install flathub io.github.seadve.Kooha
flatpak install flathub me.iepure.devtoolbox
flatpak install flathub org.gimp.GIMP
flatpak install flathub org.gnome.design.Contrast
flatpak install flathub org.gnome.Geary
flatpak install flathub org.gnome.gitg
flatpak install flathub org.inkscape.Inkscape
flatpak install flathub org.mozilla.Thunderbird
flatpak install flathub org.nickvision.tubeconverter
flatpak install flathub org.signal.Signal
flatpak install fr.romainvigier.MetadataCleaner
flatpak install org.gnome.seahorse.Application

ln --symbolic $REPO_DIR/themes/tomorrow+.json ~/.var/app/com.raggesilver.BlackBox/data/blackbox/schemes/tomorrow+.json


# 1Password
# https://1password.com/downloads/linux/

# Distro-specific installation steps…


# Docker
# https://docs.docker.com/engine/install/

# Distro-specific installation steps…

# `docker-compose` passthrough to `docker compose`
sudo ln --symbolic $REPO_DIR/apps/docker-compose /usr/local/bin/docker-compose


# Stuff and things

mkdir --parents $APPS_DIR

# Emoji Selector
# https://github.com/maoschanz/emoji-selector-for-gnome

cd $APPS_DIR
git clone git@github.com:maoschanz/emoji-selector-for-gnome.git

cd $APPS_DIR/emoji-selector-for-gnome
./install.sh

cd $REPO_DIR


# JetBrains Mono
# https://github.com/JetBrains/JetBrainsMono

cd $APPS_DIR
git clone git@github.com:JetBrains/JetBrainsMono.git
mkdir --parents ~/.local/share/fonts
ln --symbolic $APPS_DIR/JetBrainsMono/fonts/variable/"JetBrainsMono[wght].ttf" ~/.local/share/fonts/"JetBrainsMono[wght].ttf"
ln --symbolic $APPS_DIR/JetBrainsMono/fonts/variable/"JetBrainsMono-Italic[wght].ttf" ~/.local/share/fonts/"JetBrainsMono-Italic[wght].ttf"
cd $REPO_DIR


# Disable USB peripheral wakeup

sudo cp $REPO_DIR/services/disable-usb-wakeup.service /lib/systemd/system/disable-usb-wakeup.service
systemctl enable disable-usb-wakeup.service
systemctl start disable-usb-wakeup.service

# Multimedia codecs
# https://docs.fedoraproject.org/en-US/quick-docs/assembly_installing-plugins-for-playing-movies-and-music/

sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf install lame\* --exclude=lame-devel
sudo dnf group upgrade --with-optional Multimedia
