#!/usr/bin/env python3
"""
Description: Simple GTK3 Calendar App
Author: Daniel Cordova
E-Mail : danesc87@gmail.com
Github : @dcdaz
"""

import gi

gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, Gdk


class Calendar(Gtk.Dialog):
    CSS_CONFIG = """
        .calendar-window {
            border-radius: 5px;
        }
        .calendar-widget {
            font-size: 15px;
        }
        .calendar-widget.view, .calendar-widget.header {
            border: none;
        }
    """

    def __init__(self):
        if self.is_already_running():
            self.kill_instances()
        Gtk.init_check()
        Gtk.Dialog.__init__(self, title='Calendar')
        self.set_window_properties()
        box = self.get_content_area()
        calendar = Gtk.Calendar(show_week_numbers=False)
        calendar.get_style_context().add_class('calendar-widget')
        from datetime import date
        calendar.mark_day(date.today().day)
        box.add(calendar)
        self.connect("destroy", Gtk.main_quit)
        self.connect('notify::is-active', self.exit_on_focus_out)
        self.show_all()
        # Config for getting Calendar focused when user opens it
        self.set_urgency_hint(True)
        Gtk.main()

    def exit_on_focus_out(self, _, _1):
        if not self.is_active():
            Gtk.main_quit()

    def set_window_properties(self):
        self.get_style_context().add_class('calendar-window')
        self.set_default_size(320, 0)
        self.set_position(Gtk.WindowPosition.MOUSE)
        self.set_skip_taskbar_hint(True)
        self.set_keep_above(True)
        self.stick()
        self.set_decorated(False)
        css_provider = Gtk.CssProvider()
        css_provider.load_from_data(self.CSS_CONFIG)
        context = Gtk.StyleContext()
        screen = Gdk.Screen.get_default()
        context.add_provider_for_screen(
            screen,
            css_provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        )
        Gtk.Settings.get_default().set_property('gtk-application-prefer-dark-theme', True)

    @staticmethod
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

    @staticmethod
    def kill_instances():
        import os
        command_to_search_processes = 'ps h -eo pid:1,command  | grep -i calendar.py'
        # Nasty way of doing things, check if we can do it in a better way
        processes = [
            (int(process), command) for process, command in [
                ps_output.rstrip('\n').split(' ', 1) for ps_output in os.popen(command_to_search_processes)
            ]
        ]
        for current_process in processes:
            # Signal 15 is SIGTERM related to terminate action
            os.kill(current_process[0], 15)


if __name__ == '__main__':
    Calendar()
