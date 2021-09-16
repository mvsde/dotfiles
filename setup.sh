#!/usr/bin/env bash


REPO_DIR=~/Projects/github/mvsde/dotfiles
APPS_DIR=~/Projects/apps


# Tilix
# https://launchpad.net/~webupd8team/+archive/ubuntu/terminix

sudo apt install tilix
sudo update-alternatives --config x-terminal-emulator
ln --symbolic $REPO_DIR/tilix-theme.json ~/.config/tilix/schemes/Light.json


# Git
# https://launchpad.net/~git-core/+archive/ubuntu/ppa

sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt upgrade

ln --symbolic $REPO_DIR/.gitconfig ~/.gitconfig


# Oh My Zsh
# https://ohmyz.sh/#install

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cd $ZSH_CUSTOM/plugins

git clone git@github.com:zsh-users/zsh-syntax-highlighting.git
git clone git@github.com:zsh-users/zsh-autosuggestions.git

cd $ZSH_CUSTOM/themes

git clone git@github.com:spaceship-prompt/spaceship-prompt.git
ln --symbolic $ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme $ZSH_CUSTOM/themes/spaceship.zsh-theme

cd $REPO_DIR

ln --symbolic $REPO_DIR/.zshrc ~/.zshrc


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
# https://flatpak.org/setup/Ubuntu/

sudo add-apt-repository ppa:alexlarsson/flatpak
sudo apt update
sudo apt install flatpak

flatpak install flathub com.github.maoschanz.drawing
flatpak install flathub io.github.seadve.Kooha
flatpak install flathub org.gimp.GIMP
flatpak install flathub org.gnome.DejaDup
flatpak install flathub org.gnome.design.Contrast
flatpak install flathub org.gnome.design.Lorem
flatpak install flathub org.gnome.Geary
flatpak install flathub org.gnome.gitg
flatpak install flathub org.gustavoperedo.FontDownloader
flatpak install flathub org.inkscape.Inkscape
flatpak install flathub org.libreoffice.LibreOffice
flatpak install flathub org.mozilla.Thunderbird
flatpak install flathub org.signal.Signal
flatpak install flathub re.sonny.OhMySVG
flatpak install flathub us.zoom.Zoom


# Enpass
# https://www.enpass.io/support/kb/general/how-to-install-enpass-on-linux/

sudo echo "deb https://apt.enpass.io/ stable main" > /etc/apt/sources.list.d/enpass.list
wget -O - https://apt.enpass.io/keys/enpass-linux.key | sudo apt-key add -
sudo apt update
sudo apt install enpass


# Docker
# https://docs.docker.com/engine/install/ubuntu/

sudo apt update
sudo apt install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

docker run hello-world


# Stuff and things

mkdir --parents $APPS_DIR
cd $APPS_DIR

git clone git@github.com:maoschanz/emoji-selector-for-gnome.git
cd $APPS_DIR/emoji-selector-for-gnome
./install.sh
cd $APPS_DIR

git clone git@github.com:gnome-pomodoro/gnome-pomodoro.git
cd $APPS_DIR/gnome-pomodoro
git switch gnome-3.38
./autogen.sh --prefix=/usr --datadir=/usr/share
make
sudo make install
cd $APPS_DIR

git clone git@github.com:JetBrains/JetBrainsMono.git
ln --symbolic $APPS_DIR/JetBrainsMono/fonts/variable/"JetBrainsMono[wght].ttf" ~/.local/share/fonts/"JetBrainsMono[wght].ttf"
ln --symbolic $APPS_DIR/JetBrainsMono/fonts/variable/"JetBrainsMono-Italic[wght].ttf" ~/.local/share/fonts/"JetBrainsMono-Italic[wght].ttf"

cd $REPO_DIR

ln --symbolic $REPO_DIR/ubuntu-emoji.xml ~/.config/fontconfig/conf.d/01-emoji.conf
sudo fc-cache -fv

sudo ln --symbolic $REPO_DIR/disable-usb-wakeup.sh /lib/systemd/system-sleep/disable-usb-wakeup
