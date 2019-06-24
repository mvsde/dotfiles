# dotfiles

My collection of dotfiles, configuration files, and random settings.


## Linux

### Locale settings

```bash
# Show default settings
cat /etc/default/locale

# Update default setting
sudo update-locale LC_TIME=de_DE.UTF-8
```

### Apple keyboard

```bash
sudo nano /etc/modprobe.d/hid_apple.conf
```

```
options hid_apple fnmode=2
options hid_apple swap_opt_cmd=1
options hid_apple iso_layout=0
```

```bash
sudo update-initramfs -u
reboot
```


## macOS

### Hide directory

```bash
chflags hidden <directory>
```


## Node Version Manager

Build with full internationalization data:

```bash
nvm install -s VERSION --with-intl=full-icu --download=all
```


## npm

Enable npm completions:

```bash
npm completion > $ZSH_CUSTOM/npm.zsh
```


## Translate Shell

https://www.soimort.org/translate-shell/

```bash
sudo wget git.io/trans -O /usr/local/bin/trans
sudo chmod +x /usr/local/bin/trans
```
