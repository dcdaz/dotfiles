#!/usr/bin/env python3
"""
Description: Simple GTK3 Calendar App
Author: Daniel Córdova A.
E-Mail : danesc87@gmail.com
Github : @danesc87
Released under GPLv3
"""

import gi

gi.require_version('Gtk', '3.0')
from gi.repository import Gtk
from gi.repository.Gdk import Screen


class Calendar(Gtk.Dialog):

    def __init__(self):
        Gtk.Dialog.__init__(self, "Calendar")
        self.set_window_properties()
        box = self.get_content_area()
        calendar = Gtk.Calendar()
        box.add(calendar)
        self.connect("destroy", Gtk.main_quit)
        self.show_all()

    def set_window_properties(self):
        self.set_skip_taskbar_hint(True)
        self.set_keep_above(True)
        self.set_decorated(False)
        screen = Screen.get_default()
        self.move(screen.get_width(), screen.get_height())


if __name__ == '__main__':
    Calendar()
    Gtk.main()
