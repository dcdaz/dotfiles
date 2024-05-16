#!/usr/bin/env python3
"""
Description: Simple GTK3 App that shows info from NVIDIA cards
Author: Daniel Cordova
E-Mail : danesc87@gmail.com
Github : @dcdaz
"""

import gi
from xml.etree import ElementTree

gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, Gdk


class NvidiaInfo(Gtk.Dialog):
    CSS_CONFIG = """
        .nvidia-monitor {
            border-radius: 5px;
        }
    """

    def __init__(self, nvidia_markup_data):
        if self.is_already_running():
            self.kill_instances()
        Gtk.init_check()
        Gtk.Dialog.__init__(self, title='Nvidia Info')
        self.set_window_properties()
        label = Gtk.Label()
        label.set_markup(nvidia_markup_data)
        self.get_content_area().pack_start(label, False, True, 0)
        self.connect("destroy", Gtk.main_quit)
        self.connect('notify::is-active', self.exit_on_focus_out)
        self.show_all()
        # Config for getting Nvidia Info focused when user opens it
        self.set_urgency_hint(True)
        Gtk.main()

    def exit_on_focus_out(self, _, _1):
        if not self.is_active():
            Gtk.main_quit()

    def set_window_properties(self):
        self.get_style_context().add_class('nvidia-monitor')
        self.set_border_width(10)
        self.set_position(Gtk.WindowPosition.MOUSE)
        self.set_resizable(False)
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
        command_to_search_processes = 'ps h -eo pid:1,command  | grep -i nvidia.py'
        # Nasty way of doing things, check if we can do it in a better way
        processes = [
            (int(process), command) for process, command in [
                ps_output.rstrip('\n').split(' ', 1) for ps_output in os.popen(command_to_search_processes)
            ]
        ]
        for current_process in processes:
            # Signal 15 is SIGTERM related to terminate action
            os.kill(current_process[0], 15)


def get_nvidia_info():
    import os
    nvidia_raw_data = os.popen('nvidia-smi -q -x').read()
    if nvidia_raw_data == '' or 'NVIDIA-SMI has failed' in nvidia_raw_data:
        print('Nvidia Card is not ready!')
        import sys
        sys.exit(1)
    try:
        nvidia_xml_data = ElementTree.fromstring(nvidia_raw_data)
    except ElementTree.ParseError:
        print('Cannot parse NVIDIA-SMI data')
        import sys
        sys.exit(1)
    card_name = nvidia_xml_data.find('.//product_name')
    driver_version = nvidia_xml_data.find('.//driver_version')
    total_memory = nvidia_xml_data.find('.//fb_memory_usage/total')
    used_memory = nvidia_xml_data.find('.//fb_memory_usage/used')
    free_memory = nvidia_xml_data.find('.//fb_memory_usage/free')
    temperature = nvidia_xml_data.find('.//temperature/gpu_temp')
    graphics_clock = nvidia_xml_data.find('.//clocks/graphics_clock')
    sm_clock = nvidia_xml_data.find('.//clocks/sm_clock')
    mem_clock = nvidia_xml_data.find('.//clocks/mem_clock')
    video_clock = nvidia_xml_data.find('.//clocks/video_clock')

    return """<b><u>{}</u></b>\n
    \t<b>- Driver:</b>\t\t\t\t\t\t{}
    \t<b>- Memory:</b>
    \t\t<b>- Total:</b>\t\t\t\t\t\t{}
    \t\t<b>- Used:</b>\t\t\t\t\t\t{}
    \t\t<b>- Free:</b>\t\t\t\t\t\t{}
    \t<b>- Clocks:</b>
    \t\t<b>- Graphics:</b>\t\t\t\t{}
    \t\t<b>- SM:</b>\t\t\t\t\t\t{}
    \t\t<b>- Mem:</b>\t\t\t\t\t\t{}
    \t\t<b>- Video:</b>\t\t\t\t\t{}
    \t<b>- Temperature:</b>\t\t\t\t\t{}""".format(
        card_name.text,
        driver_version.text,
        total_memory.text,
        used_memory.text,
        free_memory.text,
        graphics_clock.text,
        sm_clock.text,
        mem_clock.text,
        video_clock.text,
        temperature.text
    )


if __name__ == '__main__':
    NvidiaInfo(get_nvidia_info())
