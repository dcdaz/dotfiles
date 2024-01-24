#!/usr/bin/env python3
"""
Description: Simple Script that delivers Notifications to DBUS
Author: Daniel Cordova
E-Mail : danesc87@gmail.com
Github : @dcdaz
"""

import dbus
import sys

URGENCY_LOW = 0
URGENCY_NORMAL = 1
URGENCY_CRITICAL = 2
URGENCY_LEVELS = [URGENCY_LOW, URGENCY_NORMAL, URGENCY_CRITICAL]

MESSAGE = """
This application takes 5 parameters:
    - App Name
    - Icon Name
    - Title
    - Body
    - Urgency
        - Low = 0
        - Normal = 1
        - Critical = 2
Example:
    python3 notify.py Battery battery-empty-symbolic "Battery Notification" "Battery low" 2
"""


class Notification(object):
    def __init__(self):
        destination = 'org.freedesktop.Notifications'
        object_path = '/org/freedesktop/Notifications'
        interface = 'org.freedesktop.Notifications'
        self.bus = dbus.SessionBus()
        notification_object = self.bus.get_object(destination, object_path)
        self.notification = dbus.Interface(notification_object, interface)

    def notify(self, app_name, icon_name, title, body, urgency):
        time = 3000  # Time in Millis
        if urgency not in URGENCY_LEVELS:
            print('Unknown urgency level: ' + str(urgency) + '\n')
            print(MESSAGE)
            sys.exit(1)
        urgency_hint = {'urgency': dbus.Byte(urgency)}
        self.notification.Notify(app_name, 42, icon_name, title, body, [], urgency_hint, time)

    def close_connection(self):
        self.bus.close()


if __name__ == '__main__':
    if len(sys.argv) < 6:
        print(MESSAGE)
        sys.exit(1)
    else:
        app_name = sys.argv[1]
        icon_name = sys.argv[2]
        title = sys.argv[3]
        body = sys.argv[4]
        try:
            urgency = int(sys.argv[5])
        except ValueError:
            print("Urgency must be a number!\n")
            print(MESSAGE)
            sys.exit(1)
        notification = Notification()
        notification.notify(app_name, icon_name, title, body, urgency)
        notification.close_connection()
