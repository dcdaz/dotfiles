# dotfiles

This repository has some scripts and config files of my own to make my daily life easier and happier.

- [Mozilla](mozilla/)
- [Repos](repos/)
- [Misc](#misc)
- [Dev-Tools](#dev-tools)
- [Vim](#vim)

## MISC

Some miscellanea stuff for daily driver

### DOT-LOCAL

Some scripts, configs and launchers are placed on `.local` folder, so if you want to use them you need to copy `.local` folder to your home directory

Script | Description
-------|------------
**backlight.sh** | Allows to change screen brightness and notify about it [depends on notify.sh]
**calendar.py** | Simple **Python3** script that creates a *GTK* calendar and place it where the mouse is [if user tries to execute again it will exit]
**color_picker.py** | Simple **Python3** script that create a *GTK* Color Picker, this script allows only one instance of it
**desktop.sh** | Simple **Shell** script to echoes which desktop you are
**echo_volume_icon.sh** | Only echoes volume icon rather to have a systray volume
**external_monitor.sh** | Check if laptop has external monitor connected, placed as primary activate it and deactivate laptop screen
**firefox** | Firefox launcher
**firefox-dev** | Firefox Developer Edition launcher
**jdownloader** | Jdownloader launcher
**keyboard_backlight.sh** | Allows to change keyboard backlight and notify about it [depends on notify.sh]
**lock.sh** | **Shell** script that allows to lock screen with *autolock* and *i3lock*
**manage_volume.sh** | Allows to change volume of active sink and notify about if [depends on notify.sh]
**notes.py** | Small **Python3** script that creates a simple *GTK* notes app that reads from a plain text file and place it where the mouse is [if user tries to execute again it will exit]
**notify.py** | Simple **Python3** script for send notifications with urgency level using *gdBus* instead of dunstify/notify-send
**nvidia.py** | Small **Python3** script that checks nvidia information every time user opens it and shows that info inside a *GTK* dialog
**power_menu.sh** | Small **Shell** script that sends *"icons"* or *"emojis"* to a rofi theme to show a custom power menu, it's based on [Aditya's Rofi Themes](https://github.com/adi1090x/rofi)
**prime-run** | Small **Shell** script that allows to launch any app with NVIDIA graphics card, it should work on laptops with *Optimus* technology like Intel+NVIDIA or AMD+NVIDIA, it'll work if user has NVIDIA driver installed **HARD-WAY** or directly from repos which means no Bumblebee becuase is an old tech and isn't supported, in case of using suse-prime, nvidia-prime, etc. You need to setup your graphics env to hybrid, thus you allow your laptop use integrated card for most graphic and render work but **prime-run** for dedicated stuff like video games or heavy rendering.
**screenshooter.py** | Simple **Python3** script that creates a *GTK* dialog with some hardcoded options to allow do some screenshots with *scrot*
**thunderbird** | Thunderbird launcher
**toggle_notifications.sh** | Small **Shell** script that enables or disables **Dunst** notifications and inform to user
**volume_slider.py** | **Python3** script that creates a *GTK* volume slider and executes a OS command to set volume via *amixer*

> It's probably that some of them needs updates
> Dependencies to make them work `python3-psutil python3-dbus wmctrl`

### SHELL ALIASES

Some aliases and custom bashrc configs to make my terminal life easier and happier.

### TMUX

**tmux** as terminal multiplexer and have a 2 file configuration one for the status bar and the other for config per se, it's a config for *"lazy"* people because most of the hotkeys are on the same side of the keyboard.

> This configuration won't work with **Nano/Pico** text editors since *my* **TMUX** prefix is `Ctrl-X`, **Nano/Pico** will never exit and user should kill them instead of exit normally, if you want this *TMUX* config feel free to change the prefix to whatever you want.

### XRESOURCES

Xresources config to make **URxvt** terminal nice and beauty as terminal emulator, most ideas came from [Dracula](https://draculatheme.com/) for colors and some custom fonts, behaviors, etc.

### GITCONFIG

gitconfig with some *aliases, default-editor, name, mail, etc.* and also it has an `includeIf` clause to allow use different name or email for pushing commits, specially when same device it's used for personal and work purposes, to use it place the file on `$HOME` folder and replace the following variables with your own.

- username
- email
- custom-path -> this path is to have different `gitconfig` files like one for your own personal projects and another one for work, should be in form of directory like `~/work/`.

### LIGHTDM

Configuration that allows LightDM to check graphical and to have a GTK theme, icons, etc

### CONFIGS

`.config/` folder has some configs like:

App Name | Description
---------|------------
Alacritty | Terminal
Dunst | Notification Daemon
Flameshot | Screenshot tool
Galculator | Calculator
Openbox | Window Manager
PCManFM | FileManager
Rofi | Multipurpose app [Used as a launcher]
Sakura | Terminal
Tint2 | Panel
Viewnior | Image viewer
Zathura | PDF Reader
Conky | System Monitor
Picom | Standalone compositor
Mime | Mimeapp list
UserDirs | User directories

#### CONKY

This Conky configuration is kinda specific for laptops that has Intel+Nvidia, it uses `sensors` to get Intel GPU/CPU (AMD as commented config), and NVME adapter temperatures and `nvidia-smi` to get data from NVIDIA card, so probably will not work on some other laptops/desktops, but feel free to use it if you want.

#### PICOM

Picom has a *"commented"* variable for log path, so if you want to use it you should replace **picom_log_path** with your own and enable it.

### OPENBOX
**openbox** along with **tint2** brings simplicity and stability, but due to a lack of things on them, I made some scripts to make it more usable and more comfortable to me, if one of them works for you too, go ahead and grab it.  
**rc.xml** has several configs related to my own hotkeys and scripts `feel free to use them if you want` and my **menu.xml** has the entire menu hardcoded because I like that, so I think that will not be very useful to anyone.

### THEMES

`.themes/` contains an **Openbox** theme of my own called *Arc-Zero* this theme takes ideas from Arc-Dark and others to have an *Arc-ish* feel with some improvements.

### ZOOM MIME
**zoom.xml** file should be placed on `/usr/share/mime/packages/`

### NUPHY CONFIG

Copy `hid_apple.conf` to `/etc/modprobe.d` and regenerate modules on you current Kernel.

> For openSuSe you can do it with `sudo dracut -f --regenerate-all `

## DEV TOOLS

### RUST

*Rust* it's installed via [**rustup**](https://rustup.rs/), you can install it by executing the following command on a terminal:

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### CARGO

Some custom *cargo* configs for building **Rust** apps.

### NODEJS

*NodeJS* it's installed via [**nvm-sh**](https://github.com/nvm-sh/nvm), you can install it by executing the following command on a terminal:

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```

### PNPM

*PNPM* it's installed via [Pnpm](https://pnpm.io/installation), you can install it by executing the following command on a terminal:

```sh
curl -fsSL https://get.pnpm.io/install.sh | sh -
```

## VIM
Some useful configurations to make VIM very powerful and pretty

To use it properly you need some fonts like:
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) installed on your system
- [Devicons](https://vorillaz.github.io/devicons/#/main)

> If you see NERDTree folders and files vertically stretched it's because your terminal needs **Mono** version of the patched font you're currently using

### Installation

```bash
cp -r .vim* ~/
```

> That's it, now on the first run vim will install automatically `vim-plug` and use it to install all plugins configured on `vimrc`

### Plugins
The following plugins are used by this **vim** config

- NERDTree (It loads on NerdTreeToggle)
- NERDCommenter
- NERDTree Git Plugin (It loads on NerdTreeToggle)
- NERDTree Syntax Highlight (It loads on NerdTreeToggle)
- Vim Gutter
- Ctrl-P
- Tagbar (It loads on TagBarToggle)
- Lightline
- Vim Devicons
- Dracula Theme
- Vim Minimap
- Vim LSP
- Vim LSP Settings
- Asyncomplete
- Asyncomplete LSP
- Vim Vsnip
- Vim Vsnip Integration
- Vimspector (It loads only for Rust, C, CPP, Python and JS)
