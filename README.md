# dotsAndConfs

This reposository has some config files of my own and some dotfiles that I do to make my daily life easier.

## CONKY
Conky configuration executes hddtemp without sudo, but before to execute it's necessary to run the following command: 
```
sudo chmod u+s /usr/sbin/hddtemp
``` 
This allows conky works properly with hddtemp

## VIM
Vim contains its own README in: [vim](vim/)

## LIGHTDM
LightDM uses a bash script called `external_monitor.sh` located on `~/.config/openbox/external_monitor.sh` to be active only on primary monitor ir order to have this functionality `lightdm.conf` should be placed on `/etc/lightdm/lightdm.conf`, before put conf in its place read comment on it related to replace with your bash script path

## OPENBOX
Currently I'm using **openbox** window manager mainly for it's simplicity and stability with **tint2** panel but due to a lack of things on them I made some scripts to make it more usable and more comfortable to me, if one of them works for you too go ahead and grab it.

My **rc.xml** has several configs related to my own hotkeys `feel free to use them if you want` and my **menu.xml** has the entire menu hardcoded because I like that so I think that will not be very useful to any one.

The scripts that I use are placed on `.config/custom_scripts` and are the following:

- **notify.sh** -> Send notifications using *gdBus* instead on dunstify/notify-send
- **backlight.sh** -> Allows to change screen brightness and notify about it [depends on notify.sh]
- **bumblebee.sh** -> *Tint2* script that runs every X sec, to fetch data of a *NVIDIA* card using bumblebee [depends on nvidia.sh]
- **calendar.sh** -> Executes/Terminates process called calendar.py when user clicks on *Tint2* clock
- **calenda.py** -> Simple **Python3** script that creates a *GTK* calendar and place it on bottom right of screen
- **external_monitor.sh** -> Check if laptop has external monitor connected, placed as primary activate it and deactivate laptop screen
- **manage_volume.sh** -> Allows to change volume of active sink and notify about if [depends on notify.sh]
- **notes.sh** -> Executes/Terminates process called notes.py to show a *GTK* simple notes app when user clicks on Notes icon of *Tint2*
- **notes.py** -> Small **Python3** script that creates a simple notes app that reads from a plain text file and it's placed on bottom right of screen
- **nvidia.sh** -> Bash script that fetches *NVIDIA* info, taken from (https://github.com/bxabi/bumblebee-indicator)
- **screen_capture.sh** -> Bash script with *Zenity* to allow have some screen capture options and perform them with *scrot*
- **select_audio_sink.sh** -> Bash script that shows all audio sinks on a *Zenity* dialog and allows to change current sound stream to a different sink
- **volume_echo.sh** -> Bash script that it's executed every X sec on *Tint2* to get current volume of current master channel and echo it to panel


> Some of those scripts are binded to a hotkey on *openbox's* **rc.xml** some other are binded to an executor or a button on *Tint2* and propably some of them needs some upgrade  
> **notify.sh** script needs an upgrade to allow send *variant* value related to urgency on *gdBus* but I didn't found how to do it, when I found it I'll update it

