#!/usr/bin/env python3
"""
Description: Simple GTK3 Calendar App
Author: Daniel Cordova A.
E-Mail : danesc87@gmail.com
Github : @dcdaz
Released under GPLv3
"""

import dbus
from gi.repository import GLib
from dbus.mainloop.glib import DBusGMainLoop
from dataclasses import dataclass


@dataclass
class BakaRuru():
    app_name: str
    app_id: str
    props: list
    app_workspace: int = 0


props_dict = {
        'vim': ['maximized'],
        'thunderbird': ['1']
    }


def signal_handler(*args, **kwargs):
    import psutil
    import subprocess

    out, err = subprocess.Popen(
        'wmctrl -l',
        shell=True,
        stderr=subprocess.PIPE,
        stdout=subprocess.PIPE
    ).communicate()

    if err is not None and err.decode() != '':
        import sys
        sys.exit(1)

    apps = out.decode().split('\n')

    controllable_apps = []

    for app, props in props_dict.items():
        wmctrl_full_app_name = list(
            filter(
                None,
                set(app_name for app_name in apps if app.lower() in app_name.lower()).pop().split(' '))
        )

        controllable_apps.append(
            BakaRuru(
                app_name=app,
                app_id=wmctrl_full_app_name[0],
                props=props,
                app_workspace=int(wmctrl_full_app_name[1])
            )
        )

    for app in controllable_apps:
        for p in app.props:
            if p == 'maximized':
                subprocess.run('wmctrl -ir ' + app.app_id + ' -b add,maximized_vert,maximized_horz', shell=True)
            else:
                subprocess.run('wmctrl -ir ' + app.app_id + ' -d ' + p, shell=True)



    procs = list(map(lambda proc: proc.name(), psutil.process_iter()))

    mousepad = "\n".join(s for s in procs if 'mousepad'.lower() in s.lower())
    thunar = "\n".join(s for s in procs if 'thunar'.lower() in s.lower())
    gvim = "\n".join(s for s in procs if 'vim'.lower() in s.lower())
    ferdium = "\n".join(set(s for s in procs if 'ferdium'.lower() in s.lower()))
    thunderbird = "\n".join(s for s in procs if 'thunderbird'.lower() in s.lower())

    print('--------------------------')
    print('--- Names from Session ---')
    print('--------------------------')
    print('Mousepad: ' + mousepad)
    print('Thunar: ' + thunar)
    print('GVim: ' + gvim)
    print('Ferdium: ' + ferdium)
    print('Thunderbird: ' + thunderbird)

    # for service in names:
    #     print(service)
    #     break
    # for i, arg in enumerate(args):
    #     print("arg:%d        %s" % (i, str(arg)))
    # print('kwargs:')
    # print(kwargs)
    # print('---end----')

DBusGMainLoop(set_as_default=True)
bus = dbus.SessionBus()
# register your signal callback
bus.add_signal_receiver(signal_handler)
# bus.add_signal_receiver(signal_handler,
#                         bus_name='org.bluez',
#                         interface_keyword='interface',
#                         member_keyword='member',
#                         path_keyword='path',
#                         message_keyword='msg')

loop = GLib.MainLoop()
loop.run()


#!/bin/sh

# ACTIVE_WINDOW=$(xprop -root | grep "_NET_ACTIVE_WINDOW(WINDOW)" | awk '{print $5}')
# IS_MAXIMIZED=$(xprop -id $ACTIVE_WINDOW | grep _NET_WM_STATE)
#
# MAXIMIZED_PROPERTY="_NET_WM_STATE(ATOM) = _NET_WM_STATE_MAXIMIZED_VERT, _NET_WM_STATE_MAXIMIZED_HORZ"
# #, _OB_WM_STATE_UNDECORATED
#
#
# if [ "$ACTIVE_WINDOW" == "0x0" ] || [ "$IS_MAXIMIZED" != "$MAXIMIZED_PROPERTY" ]; then
# 	echo ""
# else
# 	if [ "$1" == "x" ]; then
# 		echo "x"
# 	elif [ "$1" == "_" ]; then
# 		echo "_"
# 	elif [ "$1" == "close" ]; then
# 		wmctrl -ic $ACTIVE_WINDOW
# 	elif [ "$1" == "hide" ]; then
# 			wmctrl -ir $ACTIVE_WINDOW -b add,hidden
# 	fi
# fi
#
# exit 0
