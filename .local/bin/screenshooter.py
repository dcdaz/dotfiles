#!/usr/bin/env python3
"""
Description: Simple GTK3 Screenshooter App
Author: Daniel Cordova A.
E-Mail : danesc87@gmail.com
Github : @dcdaz
Released under GPLv3
"""

import gi

gi.require_version('Gtk', '3.0')
from gi.repository import Gtk


class Screenshooter(Gtk.Dialog):

    IMAGES_PATH = '~/Pictures'
    TEMPLATE = 'Screenshot_{dt:%Y}{dt:%m}{dt:%d}_{dt:%H}{dt:%M}{dt:%S}.png'
    NOTIFICATION = 'notify.py Screenshooter applets-screenshooter "Screen Capture" "Screenshot captured successfully ' \
                   'on: {}" 1 '
    AVAILABLE_OPTIONS = {
        'Rectangular Area': 'scrot -l style=solid,width=1,color="#2f343f" -s -q 100 ',
        'Whole Screen': 'scrot -d 1 -q 100 ',
        'Whole Screen with Pointer': 'scrot -d 1 -p -q 100 ',
        'Focused Window': 'scrot -d 1 -u -q 100 '
    }

    def __init__(self):
        Gtk.init_check()
        Gtk.Dialog.__init__(self, title='Simple Screenshooter')
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
        import datetime
        from inspect import getsourcefile
        from os.path import abspath, dirname

        screenshot_name = self.TEMPLATE.format(dt=datetime.datetime.now())
        screenshot_path = os.path.expanduser(self.IMAGES_PATH) + '/' + screenshot_name

        self_path = abspath(getsourcefile(lambda: 0))
        notification = 'python3 ' + dirname(self_path) + '/' + self.NOTIFICATION.format(screenshot_path)
        command = self.AVAILABLE_OPTIONS[option_button.get_label()] + screenshot_path + " -e '" + notification + "'"
        os.popen(command)
        self.destroy()


def is_already_running():
    import psutil

    exists_process = [' '.join(p.cmdline()) for p in psutil.process_iter() if
                      (len(p.cmdline()) > 0 and ' '.join(p.cmdline()).__contains__('screenshooter.py'))]

    # Greater than 1 because one of them is the current process
    if len(exists_process) > 1:
        return True

    return False


if __name__ == '__main__':
    if not is_already_running():
        Screenshooter()

