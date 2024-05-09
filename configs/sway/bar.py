#!/usr/bin/env python
import sys
from datetime import datetime
#from psutil import disk_usage
from psutil import sensors_battery
#from psutil._common import bytes2human
#from socket import gethostname, gethostbyname
#from subprocess import check_output
from sys import stdout
from time import sleep
from colorama import Back, Style, Fore, init
from termcolor import colored, cprint

def write(data):
    stdout.write('%s\n' % data)
    stdout.flush()

def refresh():
    #disk = bytes2human(disk_usage('/').free)
    #ip = gethostbyname(gethostname())
    #try:
    #    ssid = check_output("iwgetid -r", shell=True).strip().decode("utf-8")
    #    ssid = "(%s)" % ssid
    #except Exception:
    #    ssid = "None"
    battery = int(sensors_battery().percent)
    status = "(charging)" if sensors_battery().power_plugged else "(discharging)"
    date = datetime.now().strftime('%h %d %A %H:%M')
    #format = "Space: %s | Internet: %s %s | Battery: %s%% %s | Date: %s"
    bat_color = colored('hello', 'red', attrs=['reverse','blink'])
    format = "Battery: %s%% %s %s | Date: %s"
    write(format % (battery, status, bat_color, date))

while True:
    refresh()
    print(Back.GREEN + 'The text with Green background' + Back.RESET + Style.DIM + 'The text is DIM now' + Fore.RED + 'red text')
    sleep(1)
