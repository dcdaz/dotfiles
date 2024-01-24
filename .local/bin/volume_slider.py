#!/usr/bin/env python3
"""
Description: Simple GTK3 Volume Slider App
Author: Daniel Cordova
E-Mail : danesc87@gmail.com
Github : @dcdaz
"""

import gi

gi.require_version('Gtk', '3.0')
from gi.repository import Gtk


class VolumeSlider(Gtk.Dialog):

    def __init__(self):
        if self.is_already_running():
            self.kill_instances()
        self.volume_level = 0
        self.get_volume_level()
        Gtk.init_check()
        Gtk.Dialog.__init__(self, title='Volume Slider')
        self.set_window_properties()
        box = self.get_content_area()
        adjustment = Gtk.Adjustment(
            value=self.volume_level,
            lower=0,
            upper=100,
            step_increment=1,
            page_increment=1,
            page_size=0
        )
        scale = Gtk.Scale(orientation=Gtk.Orientation.VERTICAL, adjustment=adjustment)
        scale.get_style_context().add_class('primary-toolbar')
        scale.set_value_pos(Gtk.PositionType.BOTTOM)
        scale.set_vexpand(True)
        scale.set_hexpand(True)
        scale.set_inverted(True)
        box.add(scale)
        scale.connect("value-changed", self.set_volume_level)
        self.connect("destroy", Gtk.main_quit)
        self.connect('notify::is-active', self.exit_on_focus_out)
        self.show_all()
        # Config for getting Volume Slider focused when user opens it
        self.set_urgency_hint(True)
        Gtk.main()

    def exit_on_focus_out(self, _, _1):
        if not self.is_active():
            Gtk.main_quit()

    def set_window_properties(self):
        self.get_style_context().add_class('primary-toolbar')
        self.set_default_size(40, 200)
        self.set_position(Gtk.WindowPosition.MOUSE)
        self.set_skip_taskbar_hint(True)
        self.set_keep_above(True)
        self.stick()
        self.set_decorated(False)

    def get_volume_level(self):
        import subprocess
        cmd = "amixer get Master | grep 'Left' | awk '$0~/%/{print $5}' | tr -d '[]' | cut -d '%' -f 1"
        p = subprocess.run(cmd, stdout=subprocess.PIPE, shell=True)
        try:
            self.volume_level = int(p.stdout.strip().decode('ascii'))
        except ValueError:
            self.kill_instances()

    @staticmethod
    def set_volume_level(volume_level):
        import subprocess
        cmd = "amixer set -q Master {}% > /dev/null".format(str(int(volume_level.get_value())))
        subprocess.run(cmd, shell=True)

    @staticmethod
    def is_already_running():
        import psutil

        exists_process = [' '.join(p.cmdline()) for p in psutil.process_iter() if
                          (len(p.cmdline()) > 0 and ' '.join(p.cmdline()).__contains__('volume_slider.py'))]

        # Greater than 1 because one of them is the current process
        if len(exists_process) > 1:
            return True

        return False

    @staticmethod
    def kill_instances():
        import os
        command_to_search_processes = 'ps h -eo pid:1,command  | grep -i volume_slider.py'
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
    VolumeSlider()
