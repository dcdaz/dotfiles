# dotfiles

This repository has some config files of my own and some dotfiles that I made/use to make my daily life easier and happier.

## LAUNCHERS
[Launchers](launchers/)

## MOZILLA
[Mozilla](mozilla/)

## REPOS
[Repos](repos/)

## VIM
[Vim](vim/)

## MISC

Some misc stuff I use on my daily driver

### DOT-LOCAL

I have some scripts and configs placed on `.local` folder, so if you want to use them you need to copy `.local` folder to your home directory

### PRIME-RUN

`prime-run` is a small shell script to allows launch any app with NVIDIA graphics card, it should work on laptops with *Optimus* technology like Intel+NVIDIA or AMD+NVIDIA, it'll work if user has NVIDIA driver installed **HARD-WAY** or directly from repos which means no Bumblebee becuase is an old tech and isn't supported, in case of using suse-prime, nvidia-prime, etc. You need to setup your graphics env to hybrid, thus you allow your laptop use integrated card for most graphic and render work but **prime-run** for dedicated stuff like video games or heavy rendering.

```sh
prime-run glxspheres
```

> It can be placed on `/usr/bin/`

### SHELL ALIASES

Some aliases and custom bashrc configs to make my terminal life easier and happier.

### TMUX

I use **tmux** as terminal multiplexer and have a 2 file configuration one for the status bar and the other for config per se, my config is for *"lazy"* people because most of the things that I use are on the same side of the keyboard.

> This configuration won't work with **Nano/Pico** text editors since *my* **TMUX** prefix is `Ctrl-X` **Nano/Pico** will never exit and user should kill them instead of exit normally, if you want this *TMUX* config feel free to change the prefix to whatever you want.

### XRESOURCES

My current terminal is **URxvt**, so in order to have a nice and beauty terminal emulator I use a custom *Xresources* file based on most ideas of [Dracula](https://draculatheme.com/) for colors and some custom fonts, behaviors, etc.

### GITCONFIG

My gitconfig has some stuff to help me like *aliases, default-editor, name, mail, etc.* and also has a `includeIf` clause to allow all of my work stuff has a different **gitconfig** to change name or email, to use it the file should be place on `$HOME` folder and replace the following variables with your own.

- username
- email
- custom-path -> this path is to have different `gitconfig` files like one for your ow personal projects and another for work, should be in form of directory like `~/work/`.

### LIGHTDM

My lightdm configuration allows to show it on external monitor rather than laptop screen only if monitor is connected it uses my `external_monitor.sh` script.

### CONFIGS

My `.config/` folder has configs for the most used apps on my side like:

App Name | Description
---------|------------
Conky | System Monitor
Dunst | Notification Daemon
Picom | Standalone compositor
Rofi | Multipurpose app [Used as a launcher]
Tint2 | Panel
Openbox | Window Manager
PCManFM | FileManager
Galculator | Simple Calculator
Flameshot | Screen Capture
Viewnior | Image viewer
Zathura | PDF Reader
Custom Scripts | My own custom *shell* and *python* scripts

#### CONKY

This Conky configuration is kinda specific for my Laptop it uses sensors to get NVIDIA, Intel GPU/CPU (AMD as commented config) and NVME adapter temperatures, so probably will not work on some other laptops/desktops, but feel free to use it if you want.

#### PICOM

Picom has a *"commented"* variable for log path, so if you want to use it you should replace **picom_log_path** with your own and enable it.

### OPENBOX
Currently, I'm using **openbox** window manager mainly for its simplicity and stability with **tint2** panel but due to a lack of things on them, I made some scripts to make it more usable and more comfortable to me, if one of them works for you too, go ahead and grab it.

My **rc.xml** has several configs related to my own hotkeys `feel free to use them if you want` and my **menu.xml** has the entire menu hardcoded because I like that, so I think that will not be very useful to anyone.

The scripts that I use are placed on `.local/bin` and are the following:

Script | Description
-------|------------
**backlight.sh** | Allows to change screen brightness and notify about it [depends on notify.sh]
**calendar.py** | Simple **Python3** script that creates a *GTK* calendar and place it where the mouse is [if user tries to execute again it will exit]
**color_picker.py** | Simple **Python3** script that create a *GTK* Color Picker, this script allows only one instance of it
**desktop.sh** | Simple **Shell** script to echoes which desktop you are
**echo_volume_icon.sh** | Only echoes volume icon rather to have a systray volume
**external_monitor.sh** | Check if laptop has external monitor connected, placed as primary activate it and deactivate laptop screen
**keyboard_backlight.sh** | Allows to change keyboard backlight and notify about it [depends on notify.sh]
**lock.sh** | **Shell** script that allows to lock screen with *autolock* and *i3lock*
**manage_volume.sh** | Allows to change volume of active sink and notify about if [depends on notify.sh]
**notes.py** | Small **Python3** script that creates a simple *GTK* notes app that reads from a plain text file and place it where the mouse is [if user tries to execute again it will exit]
**notify.py** | Simple **Python3** script for send notifications with urgency level using *gdBus* instead of dunstify/notify-send
**nvidia.py** | Small **Python3** script that checks nvidia information every time user opens it and shows that info inside a *GTK* dialog
**power_menu.sh** | Small **Shell** script that sends *"icons"* or *"emojis"* to a rofi theme to show a custom power menu, it's based on [Aditya's Rofi Themes](https://github.com/adi1090x/rofi)
**screenshooter.py** | Simple **Python3** script that creates a *GTK* dialog with some hardcoded options to allow do some screenshots with *scrot*
**toggle_notifications.sh** | Small **Shell** script that enables or disables **Dunst** notifications and inform to user
**volume_slider.py** | **Python3** script that creates a *GTK* volume slider and executes a OS command to set volume via *amixer*


> Some of those scripts are bound to a hotkey on *openbox's* **rc.xml** some others are bound to an executor or a button on *Tint2* and probably some of them needs some upgrade.

### THEMES

`.themes/` contains an **Openbox** theme of my own called *Arc-Zero* this theme takes ideas from Arc-Dark and others to have an *Arc-ish* feel with some improvements.


## RUST

I use *Rust* via [**rustup**](https://rustup.rs/), you can install it by executing the following command on a terminal:

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## CARGO

I use some custom *cargo* configs for building **Rust** apps.

## NODEJS

I use *NodeJS* via [**nvm-sh**](https://github.com/nvm-sh/nvm), you can install it by executing the following command on a terminal:

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```

## PNPM

I use [Pnpm](https://pnpm.io/installation)

```sh
curl -fsSL https://get.pnpm.io/install.sh | sh -
```