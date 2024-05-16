#!/usr/bin/env python3
"""
Description: Simple GTK3 Notes App
Author: Daniel Cordova
E-Mail : danesc87@gmail.com
Github : @dcdaz
"""

import gi

gi.require_version('Gtk', '3.0')

from gi.repository import Gtk, Gdk


class Config(object):
    DEFAULT_CONFIG = """[General]
    # Window size default is 300 x 500
    Width = 300
    Height = 500
    # Use Dark Theme if possible
    DarkTheme = True
    # This will be used as title tag for notes on file and will allow app to create tabs from them with its content
    TitleTag = ###
    # Notes filepath by default is ~/.local/share/notes
    NotesPath = ~/.local/share/notes
    # Time in seconds for auto save
    AutoSaveTime = 20

    [Positions]
    # NotesPosition allow to put the notes and its tabs above or below buttons, values -> Top, Bottom
    Notes = Top
    # TabsPosition values -> Left, Right, Top, Bottom
    Tabs = Top

    [Behavior]
    # HintType is the behavior of notes window app ->
    #   - Normal (Normal behavior),
    #   - Dock (Will be above other windows all the time and will be static)
    #   - Desktop (Will be below other windows all the time but will keep sticky on the desktop)
    HintType = Normal
    # If Hint is Normal we can choose if we want the app above other windows or not
    KeepAbove = False
    """

    APP_WIDTH = 300
    APP_HEIGHT = 500
    USE_DARK_THEME = True
    TITLE_TAG = '###'
    NOTES_PATH = '~/local/share/notes'
    AUTOSAVE_TIME = 20
    NOTES_POSITION = (0, 1)
    TABS_POSITION = 3
    HINT_TYPE = 0
    KEEP_ABOVE = True

    NOTES_POSITION_MAP = {'TOP': (0, 1), 'BOTTOM': (1, 0)}
    TABS_POSITION_MAP = {'LEFT': 0, 'RIGHT': 1, 'TOP': 2, 'BOTTOM': 3}
    HINT_TYPE_MAP = {'NORMAL': 0, 'DOCK': 6, 'DESKTOP': 7}

    def __init__(self):
        import configparser
        from os.path import expanduser
        config_file_path = expanduser('~/.config/notes.conf')
        config = configparser.ConfigParser()
        config.read(config_file_path)
        if len(config.sections()) == 0:
            config.read_string(self.DEFAULT_CONFIG)
            with open(config_file_path, 'w') as cf:
                cf.write(self.DEFAULT_CONFIG)
        else:
            if config.has_section('General'):
                self.add_general_config(config['General'])
            if config.has_section('Positions'):
                self.add_positions_config(config['Positions'])
            if config.has_section('Behavior'):
                self.add_behavior_config(config['Behavior'])

        self.validate_map_properties(
            {
                'Notes': self.NOTES_POSITION,
                'Tabs': self.TABS_POSITION,
                'HintType': self.HINT_TYPE
            }
        )

    def add_general_config(self, general):
        Config.APP_WIDTH = general.getint('Width') if general.get('Width') else self.APP_WIDTH
        Config.APP_HEIGHT = general.getint('Height') if general.get('Height') else self.APP_HEIGHT
        Config.USE_DARK_THEME = general.getboolean('DarkTheme') if general.get('DarkTheme') else self.USE_DARK_THEME
        Config.TITLE_TAG = general.get('TitleTag') if general.get('TitleTag') else self.TITLE_TAG
        Config.NOTES_PATH = general.get('NotesPath') if general.get('NotesPath') else self.NOTES_PATH
        Config.AUTOSAVE_TIME = general.getint('AutoSaveTime') if general.get('AutoSaveTime') else self.AUTOSAVE_TIME

    def add_positions_config(self, positions):
        Config.NOTES_POSITION = \
            self.NOTES_POSITION_MAP.get(positions.get('Notes').upper()) if positions.get(
                'Notes') else self.NOTES_POSITION
        Config.TABS_POSITION = \
            self.TABS_POSITION_MAP.get(positions.get('Tabs').upper()) if positions.get('Tabs') else self.TABS_POSITION

    def add_behavior_config(self, behavior):
        Config.HINT_TYPE = \
            self.HINT_TYPE_MAP.get(behavior.get('HintType').upper()) if behavior.get('HintType') else self.APP_WIDTH
        try:
            from distutils.util import strtobool
            Config.KEEP_ABOVE = strtobool(behavior.get('KeepAbove')) if behavior.get('KeepAbove') else self.KEEP_ABOVE
        except ValueError:
            print("'{type} = {value}' is not a valid Boolean".format(value=behavior.get('KeepAbove'), type='KeepAbove'))
            import sys
            sys.exit(1)

    @staticmethod
    def validate_map_properties(properties):
        for key, value in properties.items():
            if value is None:
                print("{type} property has an invalid value, please fix it".format(type=key))
                import sys
                sys.exit(1)


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
                if Config.TITLE_TAG in line:
                    paged_data = ''
                    title = data.split(Config.TITLE_TAG, 1)[1].strip()
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

    def __init__(self):
        if self.is_already_running():
            self.kill_instances()
        Config()
        Gtk.init_check()
        from os.path import expanduser
        self.file_handler = FileHandler(expanduser(Config.NOTES_PATH))
        self.file_handler.read_data()
        self.win = NoteBookWindow()
        self.win.create_notebooks(self.file_handler.get_file_data())
        self.win.connect('destroy', self.on_destroy)
        self.win.connect('notify::is-active', self.save_on_focus_out_and_exit)
        self.win.show_all()
        # Config for getting Notes focused when user opens it
        self.win.set_urgency_hint(True)
        from multiprocessing import Process
        thread = Process(target=self.auto_save, args=())
        thread.start()
        Gtk.main()
        thread.terminate()
        thread.join()

    def on_destroy(self, _):
        self.file_handler.write_data(self.win.get_notebook_data())
        Gtk.main_quit()

    def save_on_focus_out_and_exit(self, _, _1):
        if not self.win.is_active():
            self.on_destroy(_)

    def auto_save(self):
        from time import sleep
        while True:
            self.file_handler.write_data(self.win.get_notebook_data())
            sleep(Config.AUTOSAVE_TIME)

    @staticmethod
    def is_already_running():
        import psutil

        exists_process = [' '.join(p.cmdline()) for p in psutil.process_iter() if
                          (len(p.cmdline()) > 0 and ' '.join(p.cmdline()).__contains__('notes.py'))]

        # Greater than 1 because one of them is the current process
        if len(exists_process) > 1:
            return True

        return False

    @staticmethod
    def kill_instances():
        import os
        command_to_search_processes = 'ps h -eo pid:1,command  | grep -i notes.py'
        # Nasty way of doing things, check if we can do it in a better way
        processes = [
            (int(process), command) for process, command in [
                ps_output.rstrip('\n').split(' ', 1) for ps_output in os.popen(command_to_search_processes)
            ]
        ]
        for current_process in processes:
            # Signal 15 is SIGTERM related to terminate action
            os.kill(current_process[0], 15)


class NoteBookWindow(Gtk.Window):
    CSS_CONFIG = """
        .tabbed-notes {
            border-radius: 5px;
        }
        .tabbed-notes notebook > header {
            border: none;
            border-radius: 5px 5px 0px 0px;
        }
        .tabbed-notes notebook > stack, .tabbed-notes notebook.frame {
            border: none;
        }
        .tabbed-notes notebook tab {
            border: none;
            border-radius: 5px 5px 0px 0px;
        }
    """

    def __init__(self):
        Gtk.Window.__init__(self, title='NoteBook')
        self.set_window_properties()
        notebook_grid = Gtk.Grid()
        self.add(notebook_grid)
        self.notebook = Gtk.Notebook(vexpand=True, hexpand=True)
        self.notebook.set_tab_pos(Config.TABS_POSITION)
        self.notebook.set_scrollable(True)
        self.notebook.set_show_border(False)
        buttons_box = self.create_buttons_box_and_return()
        notebook_grid.attach(self.notebook, 0, Config.NOTES_POSITION[0], 1, 1)
        notebook_grid.attach(buttons_box, 0, Config.NOTES_POSITION[1], 1, 1)

    def set_window_properties(self):
        self.get_style_context().add_class('tabbed-notes')
        self.set_position(Gtk.WindowPosition.MOUSE)
        self.set_skip_taskbar_hint(True)
        self.set_keep_above(Config.KEEP_ABOVE)
        self.set_type_hint(Config.HINT_TYPE)
        self.set_decorated(False)
        self.set_default_size(Config.APP_WIDTH, Config.APP_HEIGHT)
        self.stick()
        css_provider = Gtk.CssProvider()
        css_provider.load_from_data(self.CSS_CONFIG)
        context = Gtk.StyleContext()
        screen = Gdk.Screen.get_default()
        context.add_provider_for_screen(
            screen,
            css_provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        )
        Gtk.Settings.get_default().set_property('gtk-application-prefer-dark-theme', Config.USE_DARK_THEME)
        # Gtk.Settings.get_default().set_property('gtk-application-prefer-dark-theme', False)
        icon_theme_name = Gtk.Settings.get_default().get_property('gtk-icon-theme-name')
        if Config.USE_DARK_THEME:
            from os.path import exists, expanduser
            dark_icon_theme_general = exists('/usr/share/icons/' + icon_theme_name + '-Dark')
            dark_icon_theme_user_on_local = exists('~/.local/share/icons/' + icon_theme_name + '-Dark')
            dark_icon_theme_user = exists('~/.icons/' + icon_theme_name + '-Dark')
            if dark_icon_theme_general or dark_icon_theme_user or dark_icon_theme_user_on_local:
                Gtk.Settings.get_default().set_property('gtk-icon-theme-name', icon_theme_name + '-Dark')

    def create_buttons_box_and_return(self):
        button_box = Gtk.Box()
        button_box.set_homogeneous(False)
        notebook_page_add_button = Gtk.Button.new_from_icon_name(icon_name='add', size=Gtk.IconSize.BUTTON)
        notebook_page_remove_button = Gtk.Button.new_from_icon_name(icon_name='remove', size=Gtk.IconSize.BUTTON)
        close_button = Gtk.Button.new_from_icon_name(icon_name='dialog-ok', size=Gtk.IconSize.BUTTON)
        notebook_page_add_button.set_relief(Gtk.ReliefStyle.NONE)
        notebook_page_remove_button.set_relief(Gtk.ReliefStyle.NONE)
        close_button.set_relief(Gtk.ReliefStyle.NONE)

        notebook_page_add_button.connect('clicked', self.add_notebook_page)
        notebook_page_remove_button.connect('clicked', self.remove_notebook_page)
        close_button.connect('clicked', self.on_quit)

        button_box.pack_start(notebook_page_add_button, False, True, 0)
        button_box.pack_start(notebook_page_remove_button, False, True, 0)
        button_box.pack_end(close_button, False, True, 0)
        return button_box

    def create_notebooks(self, data):
        for title, value in data.items():
            notebook_page = NoteBookPage(title, value)
            self.notebook.append_page(notebook_page, Gtk.Label(label=title))
            self.notebook.set_tab_reorderable(notebook_page, True)

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
            self.notebook.get_nth_page(self.notebook.get_n_pages() - 1).show_all()

    def remove_notebook_page(self, _):
        self.notebook.remove_page(self.notebook.get_current_page())

    def on_quit(self, _):
        self.destroy()


class NewTabWindow(Gtk.Dialog):
    def __init__(self, parent):
        Gtk.Dialog.__init__(self, title='Tab Name', transient_for=parent, flags=0)
        self.add_button(Gtk.STOCK_OK, Gtk.ResponseType.OK).set_relief(Gtk.ReliefStyle.NONE)
        self.get_style_context().add_class('tabbed-notes-add-note')
        self.set_default_icon_name('mynotes')
        box = self.get_content_area()
        self.entry = Gtk.Entry()
        box.add(self.entry)
        self.show_all()

    def get_tab_name(self):
        return self.entry.get_text()


class NoteBookPage(Gtk.Box):
    def __init__(self, name, data):
        Gtk.Box.__init__(self, name=name, vexpand=True, hexpand=True)
        self.tex_view = NoteBookPageData(data)
        self.add(self.tex_view)

    def get_notebook_page_data_and_title(self):
        return Config.TITLE_TAG + ' ' + self.get_name() + '\n' + self.tex_view.get_text_view_data() + '\n'


class NoteBookPageData(Gtk.ScrolledWindow):
    def __init__(self, data):
        Gtk.ScrolledWindow.__init__(self, vexpand=True, hexpand=True)
        self.text_buffer = None
        self.text_view = None
        self.set_border_width(5)
        self.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)  # scroll only if needed
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


if __name__ == '__main__':
    NoteBook()
