#!/usr/bin/env python
"""
Description: Simple GTK3 notes App
Author: Daniel Córdova A.
E-Mail : danesc87@gmail.com
Github : @danesc87
Released under GPLv3
"""

import os
import sys
import gi

gi.require_version('Gtk', '3.0')
gi.require_version('AppIndicator3', '0.1')

from gi.repository import Gtk
from gi.repository.Gdk import Screen

TITLE_TAG = '###'


class NoteBookWindow(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title='NoteBook')
        self.set_window_properties()
        notebook_grid = Gtk.Grid()
        self.add(notebook_grid)
        self.notebook = Gtk.Notebook(vexpand=True, hexpand=True)
        self.notebook.set_tab_pos(3)
        buttons_box = self.create_buttons_box_and_return()
        notebook_grid.attach(self.notebook, 0, 0, 1, 1)
        notebook_grid.attach(buttons_box, 0, 1, 1, 1)

    def set_window_properties(self):
        self.set_border_width(5)
        self.set_default_size(300, 500)
        self.set_skip_taskbar_hint(True)
        self.set_keep_above(True)
        self.set_decorated(False)
        screen = Screen.get_default()
        self.move(screen.get_width(), screen.get_height())

    def create_buttons_box_and_return(self):
        button_box = Gtk.Box()
        notebook_page_add_button = Gtk.Button.new_with_label('+')
        notebook_page_remove_button = Gtk.Button.new_with_label('-')
        close_button = Gtk.Button.new_with_label('Save')

        notebook_page_add_button.connect('clicked', self.add_notebook_page)
        notebook_page_remove_button.connect('clicked', self.remove_notebook_page)
        close_button.connect('clicked', self.on_quit)

        button_box.pack_start(notebook_page_add_button, True, True, 0)
        button_box.pack_start(notebook_page_remove_button, True, True, 0)
        button_box.pack_start(close_button, True, True, 0)
        return button_box

    def create_notebooks(self, data):
        for title, value in data.items():
            self.notebook.append_page(NoteBookPage(title, value), Gtk.Label(label=title))

    def get_notebook_data(self):
        notebook_data = ''
        for page_number in range(self.notebook.get_n_pages()):
            notebook_data += self.notebook.get_nth_page(page_number).get_notebook_page_data_and_title()
        return notebook_data

    def add_notebook_page(self, _):
        new_tab_window = NewTabWindow(self)
        response = new_tab_window.run()
        tab_name = ''

        if response == Gtk.ResponseType.OK:
            tab_name = new_tab_window.get_tab_name()
        new_tab_window.destroy()

        if tab_name is not None or tab_name != '':
            self.notebook.append_page(NoteBookPage(tab_name, ''), Gtk.Label(label=tab_name))
            self.notebook.get_nth_page(self.notebook.get_n_pages()-1).show_all()

    def remove_notebook_page(self, _):
        self.notebook.remove_page(self.notebook.get_current_page())

    def on_quit(self, _):
        self.destroy()


class NewTabWindow(Gtk.Dialog):
    def __init__(self, parent):
        Gtk.Dialog.__init__(self, title='Tab Name', transient_for=parent, flags=0)
        self.add_button(Gtk.STOCK_OK, Gtk.ResponseType.OK)
        box = self.get_content_area()
        self.entry = Gtk.Entry()
        box.add(self.entry)
        self.show_all()

    def get_tab_name(self):
        return self.entry.get_text()


class NoteBookPage(Gtk.Box):
    def __init__(self, name, data):
        Gtk.Box.__init__(self, name=name, vexpand=True, hexpand=True)
        self.set_border_width(5)
        self.tex_view = NoteBookPageData(data)
        self.add(self.tex_view)

    def get_notebook_page_data_and_title(self):
        return TITLE_TAG + ' ' + self.get_name() + '\n' + self.tex_view.get_text_view_data() + '\n'


class NoteBookPageData(Gtk.ScrolledWindow):
    def __init__(self, data):
        self.text_buffer = None
        self.text_view = None
        Gtk.ScrolledWindow.__init__(self, vexpand=True, hexpand=True)
        self.set_border_width(5)
        self.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)  # we scroll only if needed
        self.load_text_buffer(data)
        self.load_text_view()
        self.add(self.text_view)

    def load_text_buffer(self, data):
        self.text_buffer = Gtk.TextBuffer()
        end_iter = self.text_buffer.get_end_iter()
        # stores text on text buffer
        self.text_buffer.insert(end_iter, data)

    def load_text_view(self):
        # put text buffer on text view
        self.text_view = Gtk.TextView(buffer=self.text_buffer, vexpand=True, hexpand=True)
        self.text_view.set_wrap_mode(Gtk.WrapMode.WORD)

    def get_text_view_data(self):
        start_iter = self.text_buffer.get_start_iter()
        end_iter = self.text_buffer.get_end_iter()
        text_view_data = self.text_buffer.get_text(start_iter, end_iter, True)

        if len(text_view_data) > 1 and text_view_data[-1] != '\n':
            text_view_data += '\n'
        return text_view_data


class FileHandler(object):

    def __init__(self, file_path):
        self.data = {}
        self.file_path = file_path

    def read_data(self):
        title = ''
        paged_data = ''
        try:
            file = open(self.file_path, 'r+')
        except FileNotFoundError:
            file = open(self.file_path, 'w+')

        with file as opened_file:
            for line in opened_file:
                data = line.strip().split('\n', 1)[0]
                if line == '\n':
                    continue
                if TITLE_TAG in line:
                    paged_data = ''
                    title = data.split(TITLE_TAG, 1)[1].strip()
                else:
                    paged_data += data.strip() + '\n'
                self.data[title] = paged_data
        file.close()

    def get_file_data(self):
        return self.data

    def write_data(self, data):
        file = open(self.file_path, 'w')
        file.write(data)
        file.close()


class NoteBook(object):
    def __init__(self, file_path):
        self.file_handler = FileHandler(file_path)
        self.file_handler.read_data()
        self.win = NoteBookWindow()
        self.win.create_notebooks(self.file_handler.get_file_data())
        self.win.connect('destroy', self.on_quit)
        self.win.show_all()
        Gtk.main()

    def on_quit(self, _):
        self.file_handler.write_data(self.win.get_notebook_data())
        Gtk.main_quit()


if __name__ == '__main__':
    if len(sys.argv) > 1:
        app = NoteBook(os.path.abspath(sys.argv[1]))
    else:
        print("This application takes full file path of notes")
