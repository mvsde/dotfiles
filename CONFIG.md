# Configuration

## GNOME keybindings

### Free up <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>Arrows</kbd>

```bash
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "[]"
```

### Free up <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>D</kbd>

```bash
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Primary><Super>d', '<Super>d']"
```

### Free up <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>E</kbd>

```bash
gsettings set org.freedesktop.ibus.panel.emoji hotkey "[]"
```
