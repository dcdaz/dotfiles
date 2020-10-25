# Launchers

This folder contains several launchers for apps that I download from its websites and use it, instead of using from the repos. Most of them has two files placed on `/usr/bin` for **launcher/executable** and \*.desktop files on `/usr/share/applications` for having a *menu entry*.

Currently I have launchers for:

- Android Studio
- Atom
- DBeaver
- Firefox
- Firefox Developer Edition
- Insomnia REST Client
- Intellij IDEA
- JDownloader
- KDevelop
- Pycharm
- Rambox
- Robo3T
- Thunderbird
- Tor Browser
- VS Code
- Zoom [Only desktop file]

All of these apps are placed on `/opt/` directory

> Zoom executable should be a symlink from `/opt/zoom/ZoomLauncher` and should be placed as `/usr/bin` with name **zoomapp**, also we have a *XML* file called **zoom.xml** which has a mime stuff and should be place on `/usr/share/mime/packages/`
