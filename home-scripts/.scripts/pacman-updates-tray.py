#!/usr/bin/python
import os
from gi.repository import Gtk as gtk, AppIndicator3 as appindicator

def main():
  updates_indicator = appindicator.Indicator.new("noktray", "software-update-available", appindicator.IndicatorCategory.APPLICATION_STATUS)
  are_there_updates = getUpdateStatus()

  if are_there_updates == False:
      updates_indicator.set_status(appindicator.IndicatorStatus.PASSIVE)
  else:
      updates_indicator.set_status(appindicator.IndicatorStatus.ACTIVE)

  updates_indicator.set_menu(menu())
  gtk.main()

def getUpdateStatus():
    exit_code = os.system("checkupdates")
    if exit_code == 512:
        return False
    else:
        return True



def menu():
  menu = gtk.Menu()

  command_one = gtk.MenuItem('Quit')
  command_one.connect('activate', quit)
  menu.append(command_one)

  menu.show_all()
  return menu

def quit(_):
  gtk.main_quit()

if __name__ == "__main__":
  main()
