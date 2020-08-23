#!/usr/bin/env python3
"""
Description: Simple GTK3 Calendar App
Author: Daniel Córdova A.
E-Mail : danesc87@gmail.com
Github : @danesc87
08/08/2020Released under GPLv3
"""

import gi

gi.require_version('Gtk', '3.0')
from gi.repository import Gtk


class Calendar(Gtk.Dialog):

    def __init__(self):
        Gtk.Dialog.__init__(self, "Calendar")
        self.set_window_properties()
        box = self.get_content_area()
        calendar = Gtk.Calendar(show_week_numbers=True)
        calendar.get_style_context().add_class('primary-toolbar')
        box.add(calendar)
        self.connect("destroy", Gtk.main_quit)
        self.show_all()

    def set_window_properties(self):
        self.get_style_context().add_class('primary-toolbar')
        self.set_position(Gtk.WindowPosition.MOUSE)
        self.set_skip_taskbar_hint(True)
        self.set_keep_above(True)
        self.stick()
        self.set_decorated(False)


if __name__ == '__main__':
    Calendar()
    Gtk.main()
