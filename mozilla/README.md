# Mozilla

## Firefox

I use a custom config on firefox to set up a personalized html file as a HomePage for new tabs, also set focus on page rather than URL Bar

In order to apply this configuration you need to follow a few steps

- Replace `firefox/autoconfig.cfg::newTabURL` with your own local html path
    > Unix/Mac/Linux -> `file:///home/user/.local/share/index.html`  
    > Windows -> `file:///C:/Users/yourname/yourfile.html`
- Copy `firefox/autoconfig.cfg` to your **Firefox** install directory, i.e. `/opt/firefox/`
- Copy `firefox/autoconfig.js` to your **Firefox** install directory *defaults/pref* path, i.e. `/opt/firefox/defaults/pref`
