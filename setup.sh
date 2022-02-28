#!/usr/bin/env bash


REPO_DIR=~/Projects/github/mvsde/dotfiles
APPS_DIR=~/Projects/apps


# Tilix
# https://gnunn1.github.io/tilix-web/

ln --symbolic $REPO_DIR/tilix-theme.json ~/.config/tilix/schemes/Light.json


# Git

ln --symbolic $REPO_DIR/.gitconfig ~/.gitconfig


# Oh My Zsh
# https://ohmyz.sh/#install

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cd $ZSH_CUSTOM/plugins

git clone git@github.com:zsh-users/zsh-syntax-highlighting.git
git clone git@github.com:zsh-users/zsh-autosuggestions.git

cd $REPO_DIR

ln --symbolic $REPO_DIR/.zshrc ~/.zshrc


# Starship
# https://starship.rs/

sh -c "$(curl -fsSL https://starship.rs/install.sh)"
ln --symbolic $REPO_DIR/starship.toml ~/.config/starship.toml


# Node.js
# https://github.com/nvm-sh/nvm/blob/master/README.md

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

nvm install
npm completion > $ZSH_CUSTOM/npm.zsh

# npm saves auth tokens to the config file, so this can’t be linked.
cp $REPO_DIR/.npmrc ~/.npmrc

ln --symbolic $REPO_DIR/.nuxtrc ~/.nuxtrc
ln --symbolic $REPO_DIR/nvm-default-packages $NVM_DIR/default-packages


## Flatpak

flatpak install flathub com.github.liferooter.textpieces
flatpak install flathub com.github.maoschanz.drawing
flatpak install flathub com.rafaelmardojai.WebfontKitGenerator
flatpak install flathub io.github.seadve.Kooha
flatpak install flathub org.gimp.GIMP
flatpak install flathub org.gnome.DejaDup
flatpak install flathub org.gnome.design.Contrast
flatpak install flathub org.gnome.design.Lorem
flatpak install flathub org.gnome.Geary
flatpak install flathub org.gnome.gitg
flatpak install flathub org.gustavoperedo.FontDownloader
flatpak install flathub org.inkscape.Inkscape
flatpak install flathub org.mozilla.Thunderbird
flatpak install flathub org.signal.Signal


# Enpass
# https://www.enpass.io/support/kb/general/how-to-install-enpass-on-linux/

# Distro-specific installation steps…


# Docker
# https://docs.docker.com/engine/install/ubuntu/

# Distro-specific installation steps…


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
ln --symbolic $APPS_DIR/JetBrainsMono/fonts/variable/"JetBrainsMono[wght].ttf" ~/.local/share/fonts/"JetBrainsMono[wght].ttf"
ln --symbolic $APPS_DIR/JetBrainsMono/fonts/variable/"JetBrainsMono-Italic[wght].ttf" ~/.local/share/fonts/"JetBrainsMono-Italic[wght].ttf"
cd $REPO_DIR

ln --symbolic $REPO_DIR/ubuntu-emoji.xml ~/.config/fontconfig/conf.d/01-emoji.conf
sudo fc-cache -fv

# Disable USB peripheral wakeup

sudo cp $REPO_DIR/disable-usb-wakeup.service /lib/systemd/system/disable-usb-wakeup.service
systemctl enable disable-usb-wakeup.service
systemctl start disable-usb-wakeup.service
