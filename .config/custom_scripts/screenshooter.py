#!/usr/bin/env python3
"""
Description: Simple GTK3 Screenshooter App
Author: Daniel Córdova A.
E-Mail : danesc87@gmail.com
Github : @danesc87
Released under GPLv3
"""

import gi

import notify

gi.require_version('Gtk', '3.0')
from gi.repository import Gtk


class Screenshooter(Gtk.Dialog):

    IMAGES_PATH = '~/Pictures'
    TEMPLATE = 'Screenshot_%Y-%m-%d_%H-%M-%S.png'
    AVAILABLE_OPTIONS = {
        'Rectangular Area': 'scrot -l style=solid,width=1,color="#2f343f" -s -q 100 ' + TEMPLATE + " -e 'mv $f '" + IMAGES_PATH,
        'Whole Screen': 'scrot -d 1 -q 100 ' + TEMPLATE + " -e 'mv $f '" + IMAGES_PATH,
        'Whole Screen with Pointer': 'scrot -d 1 -p -q 100 ' + TEMPLATE + " -e 'mv $f '" + IMAGES_PATH,
        'Focused Window': 'scrot -d 1 -u -q 100 ' + TEMPLATE + " -e 'mv $f '" + IMAGES_PATH
    }
    WAS_CAPTURED = False

    def __init__(self):
        Gtk.Dialog.__init__(self, "Simple Screenshooter")
        self.set_window_properties()
        label = Gtk.Label()
        label.set_markup('<big><b><u>Select your option</u></b></big>\n')
        self.get_content_area().pack_start(label, False, True, 0)
        self.add_screenshooter_buttons()
        self.connect('destroy', Gtk.main_quit)
        self.show_all()
        Gtk.main()

    def set_window_properties(self):
        self.set_default_icon_name('applets-screenshooter')
        self.set_position(Gtk.WindowPosition.CENTER_ALWAYS)
        self.set_default_size(250, 0)
        self.set_resizable(False)
        self.stick()

    def add_screenshooter_buttons(self):
        box = self.get_content_area()
        for option in self.AVAILABLE_OPTIONS.keys():
            button = Gtk.Button.new_with_label(label=option)
            button.set_relief(Gtk.ReliefStyle.NONE)
            button.connect('clicked', self.execute_command_and_exit)
            box.pack_start(button, False, True, 0)

    def execute_command_and_exit(self, option_button):
        import os
        os.popen(self.AVAILABLE_OPTIONS[option_button.get_label()])
        Screenshooter.WAS_CAPTURED = True
        self.destroy()


def is_already_running():
    import fcntl
    import os

    lock_file_pointer = os.open(os.path.realpath(__file__), os.O_WRONLY)
    try:
        fcntl.lockf(lock_file_pointer, fcntl.LOCK_EX | fcntl.LOCK_NB)
        already_running = False
    except IOError:
        already_running = True

    return already_running


def notify_capture():
    import os
    notify.Notification().notify(
        'Screen Capture',
        'applets-screenshooter',
        'Screen Capture',
        'Screen captured succesfully on: ' + os.path.expanduser(Screenshooter.IMAGES_PATH),
        notify.URGENCY_NORMAL
    )


if __name__ == '__main__':
    if not is_already_running():
        Screenshooter()
        if Screenshooter.WAS_CAPTURED:
            # Not the proper way but it works
            import time
            time.sleep(1)
            notify_capture()
