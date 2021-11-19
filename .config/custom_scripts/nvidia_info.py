#!/usr/bin/env python3
"""
Description: Simple GTK3 App that shows info from NVIDIA cards
Author: Daniel Córdova A.
E-Mail : danesc87@gmail.com
Github : @danesc87
Released under GPLv3
"""

import gi
from xml.etree import ElementTree

gi.require_version('Gtk', '3.0')
from gi.repository import Gtk


class NvidiaInfo(Gtk.Dialog):

    def __init__(self, nvidia_markup_data):
        Gtk.Dialog.__init__(self, "Nvidia Info")
        self.set_window_properties()
        label = Gtk.Label()
        label.set_markup(nvidia_markup_data)
        self.get_content_area().pack_start(label, False, True, 0)
        self.connect("destroy", Gtk.main_quit)
        self.connect('notify::is-active', self.save_on_focus_out_and_exit)
        self.show_all()
        # Config for getting Notes focused when user opens it
        self.set_urgency_hint(True)
        Gtk.main()

    def save_on_focus_out_and_exit(self, _, _1):
        if not self.is_active():
            Gtk.main_quit()

    def set_window_properties(self):
        self.get_style_context().add_class('primary-toolbar')
        self.set_border_width(10)
        self.set_position(Gtk.WindowPosition.MOUSE)
        self.set_resizable(False)
        self.set_skip_taskbar_hint(True)
        self.set_keep_above(True)
        self.stick()
        self.set_decorated(False)


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


def kill_instances():
    import os
    command_to_search_processes = 'ps h -eo pid:1,command  | grep -i nvidia_info.py'
    # Nasty way of doing things, check if we can do it in a better way
    notes_processes = [
        (int(process), command) for process, command in [
            ps_output.rstrip('\n').split(' ', 1) for ps_output in os.popen(command_to_search_processes)
        ]
    ]
    for note_process in notes_processes:
        # Signal 15 is SIGTERM related to terminate action
        os.kill(note_process[0], 15)


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

    return """<b>- Name:</b> <u>{}</u>\n
    \t\t<b>- Driver:</b>\t\t\t\t\t{}
    \t\t<b>- Memory:</b>
    \t\t\t\t<b>- Total:</b>\t\t\t\t{}
    \t\t\t\t<b>- Used:</b>\t\t\t\t{}
    \t\t\t\t<b>- Free:</b>\t\t\t\t{}
    \t\t<b>- Clocks:</b>
    \t\t\t\t<b>- Graphics:</b>\t\t{}
    \t\t\t\t<b>- SM:</b>\t\t\t\t{}
    \t\t\t\t<b>- Mem:</b>\t\t\t\t{}
    \t\t\t\t<b>- Video:</b>\t\t\t{}
    \t\t<b>- Temperature:</b>\t\t\t{}""".format(
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
    if is_already_running():
        kill_instances()
    nvidia_data = get_nvidia_info()
    NvidiaInfo(nvidia_data)
