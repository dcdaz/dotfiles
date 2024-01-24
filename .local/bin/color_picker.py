#!/usr/bin/env python3
"""
Description: Simple GTK3 Color Picker App
Author: Daniel Cordova
E-Mail : danesc87@gmail.com
Github : @dcdaz
"""

import gi

gi.require_version('Gtk', '3.0')
from gi.repository import Gtk


class ColorPicker(Gtk.ColorSelectionDialog):

    def __init__(self):
        Gtk.init_check()
        Gtk.Dialog.__init__(self, title='Color Picker')
        self.set_window_properties()
        self.connect("destroy", Gtk.main_quit)
        self.show_all()
        Gtk.main()

    def set_window_properties(self):
        self.set_default_icon_name('color-picker')
        self.set_position(Gtk.WindowPosition.CENTER_ALWAYS)
        self.set_resizable(False)
        self.fix_buttons()

    def fix_buttons(self):
        buttons_box = self.vbox.get_children()[1]
        if isinstance(buttons_box, Gtk.Box):
            for button in buttons_box.get_children():
                Gtk.Box.remove(buttons_box, button)
            ok_button = Gtk.Button.new_from_icon_name(icon_name='exit', size=Gtk.IconSize.BUTTON)
            help_button = Gtk.Button.new_from_icon_name(icon_name='help', size=Gtk.IconSize.BUTTON)
            ok_button.connect('clicked', Gtk.main_quit)
            help_button.connect('clicked', self.run_about_dialog)
            buttons_box.pack_start(help_button, False, True, 0)
            buttons_box.pack_end(ok_button, False, True, 0)

    def run_about_dialog(self, _):
        AboutDialog(self)


class AboutDialog(Gtk.Dialog):
    DEVS_DATA = """<big><b><u>Color Picker About</u></b></big>
    
    <b>Developers:</b><small>
    \t<b>Name:</b> Daniel Cordova
    \t<b>E-mail:</b> danesc87@gmail.com
    </small>"""

    def __init__(self, parent):
        Gtk.Dialog.__init__(self, title='About', transient_for=parent)
        self.set_default_size(250, 150)
        self.set_border_width(5)
        self.set_resizable(False)
        self.set_type_hint(2)  # Number 2 is to disable minimize button
        box = self.get_content_area()
        devs_info = Gtk.Label()
        devs_info.set_markup(self.DEVS_DATA)
        box.add(devs_info)
        self.show_all()


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


if __name__ == '__main__':
    if not is_already_running():
        ColorPicker()
