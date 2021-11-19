# dotfiles

This repository has some config files of my own and some dotfiles that I made/use to make my daily life easier and happier.

## REPOS
Check [repos](repos/)

## LAUNCHERS
Check [launchers](launchers/)

## VIM
Vim contains its own README in: [vim](vim/)

## OPENBOX
Currently, I'm using **openbox** window manager mainly for its simplicity and stability with **tint2** panel but due to a lack of things on them, I made some scripts to make it more usable and more comfortable to me, if one of them works for you too, go ahead and grab it.

My **rc.xml** has several configs related to my own hotkeys `feel free to use them if you want` and my **menu.xml** has the entire menu hardcoded because I like that, so I think that will not be very useful to anyone.

The scripts that I use are placed on `.config/custom_scripts` and are the following:

Script | Description
-------|------------
**backlight.sh** | Allows to change screen brightness and notify about it [depends on notify.sh]
**keyboard_backlight.sh** | Allows to change keyboard backlight and notify about it [depends on notify.sh]
**nvidia_info.py** | Small **Python3** script that checks nvidia information every time user opens it and shows that info inside a *GTK* dialog
**calendar.py** | Simple **Python3** script that creates a *GTK* calendar and place it where the mouse is [if user tries to execute again it will exit]
**color_picker.py** | Simple **Python3** script that create a *GTK* Color Picker, this script allows only one instance of it
**external_monitor.sh** | Check if laptop has external monitor connected, placed as primary activate it and deactivate laptop screen
**manage_volume.sh** | Allows to change volume of active sink and notify about if [depends on notify.sh]
**notes.py** | Small **Python3** script that creates a simple *GTK* notes app that reads from a plain text file and place it where the mouse is [if user tries to execute again it will exit]
**notify.py** | Simple **Python3** script for send notifications with urgency level using *gdBus* instead of dunstify/notify-send
**screenshooter.py** | Simple **Python3** script that creates a *GTK* dialog with some hardcoded options to allow do some screenshots with *scrot*


> Some of those scripts are bound to a hotkey on *openbox's* **rc.xml** some others are bound to an executor or a button on *Tint2* and probably some of them needs some upgrade.

## PRIME-RUN
`prime-run` is a small shell script to allows launch any app with NVIDIA graphics card, it should work on laptops with *Optimus* technology like Intel+NVIDIA or AMD+NVIDIA, it'll work if user has NVIDIA driver installed **HARD-WAY** or directly from repos which means no Bumblebee becuase is an old tech and isn't supported, in case of using suse-prime, nvidia-prime, etc. You need to setup your graphics env to hybrid, thus you allow your laptop use integrated card for most graphic and render work but **prime-run** for dedicated stuff like video games or heavy rendering.

```bash
prime-run glxspheres
```

> It can be placed on `/usr/bin/`

## SHELL
Some aliases and custom bashrc configs to make my terminal life easier and happier.

## TMUX
I use **tmux** as terminal multiplexer and have a 2 file configuration one for the status bar and the other for config per se, my config is for *"lazy"* people because most of the things that I use are on the same side of the keyboard.

> This configuration won't work with **Nano/Pico** text editors since *my* **TMUX** prefix is `Ctrl-X` **Nano/Pico** will never exit and user should kill them instead of exit normally, if you want this *TMUX* config feel free to change the prefix to whatever you want.

## XRESOURCES
My current terminal is **URxvt**, so in order to have a nice and beauty terminal emulator I use a custom *Xresources* file based on most ideas of [Dracula](https://draculatheme.com/) for colors and some custom fonts, behaviors, etc. 

## GITCONFIG
My gitconfig has some stuff to help me like *aliases, default-editor, name, mail, etc.* and also has a `includeIf` clause to allow all of my work stuff has a different **gitconfig** to change name or email, to use it the file should be place on `$HOME` folder and replace the following variables with your own.

- username
- email
- custom-path -> this path is to have different `gitconfig` files like one for your ow personal projects and another for work, should be in form of directory like `~/work/`.

## LIGHTDM
My lightdm configuration allows to show it on external monitor rather than laptop screen only if monitor is connected it uses my `external_monitor.sh` script.

## CONFIGS

My `.config/` folder has configs for the most used apps on my side like:

App Name | Description
---------|------------
Conky | System Monitor
Dunst | Notification Daemon
Picom | Standalone compositor
Rofi | Multipurpose app [Used as a launcher]
Tint2 | Panel
Openbox | Window Manager
Custom Scripts | My own custom *bash* and *python* scripts


### CONKY

This Conky configuration is kinda specific for my Laptop it uses sensors to get NVIDIA, Intel GPU/CPU (AMD as commented config) and NVME adapter temperatures, so probably will not work on some other laptops/desktops, but feel free to use it if you want.

### PICOM

Picom has a variable on login path, so if you want to use it you should replace **picom_log_path** with your own.

### CARGO

Some custom *cargo* configs that I use for building **Rust** apps.
