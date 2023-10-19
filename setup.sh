#!/usr/bin/env bash


REPO_DIR=~/Projects/github/mvsde/dotfiles
APPS_DIR=~/Projects/apps
FONTS_DIR=~/.local/share/fonts


# ------------------------------------------------------------------------------
# Git
# ------------------------------------------------------------------------------

ln --symbolic $REPO_DIR/configs/.gitconfig ~/.gitconfig
ln --symbolic $REPO_DIR/configs/.gitignore ~/.gitignore


# ------------------------------------------------------------------------------
# bat
# ------------------------------------------------------------------------------

# https://github.com/sharkdp/bat

mkdir --parents ~/.config/bat/
ln --symbolic $REPO_DIR/configs/bat.ini ~/.config/bat/config


# ------------------------------------------------------------------------------
# zsh
# ------------------------------------------------------------------------------

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


# ------------------------------------------------------------------------------
# Node.js
# ------------------------------------------------------------------------------

# https://github.com/nvm-sh/nvm/blob/master/README.md

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

nvm install

# npm saves auth tokens to the config file, so this can’t be linked.
cp $REPO_DIR/configs/.npmrc ~/.npmrc

ln --symbolic $REPO_DIR/configs/nvm-default-packages $NVM_DIR/default-packages


# ------------------------------------------------------------------------------
# Flatpak
# ------------------------------------------------------------------------------

flatpak install flathub com.belmoussaoui.Obfuscate
flatpak install flathub com.felipekinoshita.Wildcard
flatpak install flathub com.github.finefindus.eyedropper
flatpak install flathub com.github.jeromerobert.pdfarranger
flatpak install flathub com.github.liferooter.textpieces
flatpak install flathub com.github.maoschanz.drawing
flatpak install flathub com.rafaelmardojai.SharePreview
flatpak install flathub com.rafaelmardojai.WebfontKitGenerator
flatpak install flathub com.raggesilver.BlackBox
flatpak install flathub com.tomjwatson.Emote
flatpak install flathub fr.romainvigier.MetadataCleaner
flatpak install flathub io.github.fabrialberio.pinapp
flatpak install flathub io.github.seadve.Kooha
flatpak install flathub it.mijorus.smile
flatpak install flathub me.iepure.devtoolbox
flatpak install flathub org.gimp.GIMP
flatpak install flathub org.gnome.design.Contrast
flatpak install flathub org.gnome.Epiphany
flatpak install flathub org.gnome.Extensions
flatpak install flathub org.gnome.Geary
flatpak install flathub org.gnome.gitg
flatpak install flathub org.gnome.seahorse.Application
flatpak install flathub org.inkscape.Inkscape
flatpak install flathub org.mozilla.Thunderbird
flatpak install flathub org.nickvision.tubeconverter
flatpak install flathub org.signal.Signal


# ------------------------------------------------------------------------------
# Black Box
# ------------------------------------------------------------------------------

ln --symbolic $REPO_DIR/themes/tomorrow+.json ~/.var/app/com.raggesilver.BlackBox/data/blackbox/schemes/tomorrow+.json


# ------------------------------------------------------------------------------
# 1Password
# ------------------------------------------------------------------------------

# Distro-specific installation steps:
# https://1password.com/downloads/linux/


# ------------------------------------------------------------------------------
# Docker
# ------------------------------------------------------------------------------

# Distro-specific installation steps:
# https://docs.docker.com/engine/install/


# `docker-compose` passthrough to `docker compose`
sudo ln --symbolic $REPO_DIR/apps/docker-compose /usr/local/bin/docker-compose


# ------------------------------------------------------------------------------
# Stuff and things
# ------------------------------------------------------------------------------

mkdir --parents $APPS_DIR


# Fonts

mkdir --parents $FONTS_DIR

cd $APPS_DIR

# https://github.com/JetBrains/JetBrainsMono
git clone git@github.com:JetBrains/JetBrainsMono.git
ln --symbolic $APPS_DIR/JetBrainsMono/fonts/variable/*.ttf $FONTS_DIR

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
