# Configuration

## Linux

### Locale settings

```bash
# Show default settings
cat /etc/default/locale

# Update default setting
sudo update-locale LC_TIME=de_DE.UTF-8
```

### Ubuntu keybindings

#### Free up <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>Arrows</kbd>

```bash
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "[]"
```

#### Free up <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>D</kbd>

```bash
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Primary><Super>d', '<Super>d']"
```

### Apple keyboard

```bash
sudo nano /etc/modprobe.d/hid_apple.conf
```

```conf
options hid_apple fnmode=2
options hid_apple swap_opt_cmd=1
options hid_apple iso_layout=0
```

```bash
sudo update-initramfs -u
reboot
```

### Google Chrome Dark Mode

```bash
google-chrome-stable --force-dark-mode --enable-features=WebUIDarkMode
```

## macOS

### Hide directory

```bash
chflags hidden <directory>
```

## Git

### Signed commits (PGP)

https://help.github.com/en/articles/generating-a-new-gpg-key

```bash
# Setup Git
git config --global user.signingkey <id>
git config --global commit.gpgsign true

# Get public key
gpg --armor --export <id>
```

#### VSCode

```json
{
  "git.enableCommitSigning": true
}
```

## npm

Enable npm completions:

```bash
npm completion > $ZSH_CUSTOM/npm.zsh
```
