# dotfiles

My collection of dotfiles and configuration files.


## macOS

### Hide directory

```bash
chflags hidden <directory>
```


## Apple keyboard for Linux

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
