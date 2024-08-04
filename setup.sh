#!/usr/bin/env bash


REPO_DIR=~/Projects/github/mvsde/dotfiles
APPS_DIR=~/Projects/apps
FONTS_DIR=~/.local/share/fonts


# ------------------------------------------------------------------------------
# Git
# ------------------------------------------------------------------------------

ln --symbolic $REPO_DIR/configs/.gitconfig ~/.gitconfig


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

(
	cd "$ZSH_CUSTOM/plugins" || exit

	git clone git@github.com:zsh-users/zsh-syntax-highlighting.git
	git clone git@github.com:zsh-users/zsh-autosuggestions.git
)

ln --symbolic $REPO_DIR/configs/.zshrc ~/.zshrc

# Create completions folder
mkdir "$ZSH/completions"

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


# ------------------------------------------------------------------------------
# Apps
# ------------------------------------------------------------------------------

sudo dnf install bat
sudo dnf install eza
sudo dnf install jq
sudo dnf install trash-cli


# ------------------------------------------------------------------------------
# Flatpak
# ------------------------------------------------------------------------------

flatpak install flathub com.belmoussaoui.Obfuscate
flatpak install flathub com.felipekinoshita.Wildcard
flatpak install flathub com.github.finefindus.eyedropper
flatpak install flathub com.github.jeromerobert.pdfarranger
flatpak install flathub io.gitlab.liferooter.TextPieces
flatpak install flathub com.github.maoschanz.drawing
flatpak install flathub com.mattermost.Desktop
flatpak install flathub com.rafaelmardojai.SharePreview
flatpak install flathub com.raggesilver.BlackBox
flatpak install flathub com.slack.Slack
flatpak install flathub de.schmidhuberj.Flare
flatpak install flathub fr.romainvigier.MetadataCleaner
flatpak install flathub io.github.fabrialberio.pinapp
flatpak install flathub io.missioncenter.MissionCenter
flatpak install flathub it.mijorus.smile
flatpak install flathub org.gimp.GIMP
flatpak install flathub org.gnome.design.Contrast
flatpak install flathub org.gnome.Extensions
flatpak install flathub org.gnome.Geary
flatpak install flathub org.gnome.gitg
flatpak install flathub org.gnome.gitlab.YaLTeR.Identity
flatpak install flathub org.gnome.seahorse.Application
flatpak install flathub org.inkscape.Inkscape
flatpak install flathub org.mozilla.Thunderbird
flatpak install flathub org.nickvision.tubeconverter
flatpak install flathub org.remmina.Remmina
flatpak install flathub org.signal.Signal


# ------------------------------------------------------------------------------
# Black Box
# ------------------------------------------------------------------------------

ln --symbolic $REPO_DIR/themes/tomorrow+.json ~/.var/app/com.raggesilver.BlackBox/data/blackbox/schemes/tomorrow+.json


# ------------------------------------------------------------------------------
# 1Password
# ------------------------------------------------------------------------------

# https://1password.com/downloads/linux/

sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
sudo dnf install 1password


# ------------------------------------------------------------------------------
# Docker
# ------------------------------------------------------------------------------

# https://docs.docker.com/engine/install/

sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker

# Use without root
sudo groupadd docker
sudo usermod -aG docker "$USER"
newgrp docker
docker run hello-world

# Start on boot
sudo systemctl enable docker.service
sudo systemctl enable containerd.service


# `docker-compose` passthrough to `docker compose`
sudo ln --symbolic $REPO_DIR/apps/docker-compose /usr/local/bin/docker-compose


# ------------------------------------------------------------------------------
# Stuff and things
# ------------------------------------------------------------------------------

mkdir --parents $APPS_DIR


# Fonts

mkdir --parents $FONTS_DIR

(
	cd "$APPS_DIR" || exit

	# https://github.com/JetBrains/JetBrainsMono
	git clone git@github.com:JetBrains/JetBrainsMono.git
	ln --symbolic $APPS_DIR/JetBrainsMono/fonts/variable/*.ttf $FONTS_DIR
)


# Disable USB peripheral wakeup

sudo cp $REPO_DIR/services/disable-usb-wakeup.service /lib/systemd/system/disable-usb-wakeup.service
systemctl enable disable-usb-wakeup.service
systemctl start disable-usb-wakeup.service


# Multimedia codecs
# https://docs.fedoraproject.org/en-US/quick-docs/installing-plugins-for-playing-movies-and-music/

sudo dnf group install Multimedia
