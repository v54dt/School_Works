#!/bin/bash

dialog --menu "sys info" 15 40 4 "1" "CPU INFO" "2" "MEMORY INFO" "3" "NETWORK INFO" "4" "FILE BROWSER"



# sys info
#   1. CPU info  
#   2.memory info
#   3.network info
#   4. file browser

dialog --title "Backup" --msgbox "Time for backup \ of home directory. \
Insert formatted 3-1/2\" floppy and press <Enter> \ to start backup or \
<Esc> to cancel." 10 50
# Return status of non-zero indicates cancel
if [ "$?" != "0" ]; then
  dialog --title "Backup" --msgbox "Backup was \ canceled at your
  request." 10 50
else
  dialog --title "Backup" --infobox "Backup in \ process..." 10 50
  cd ~
  # Backup using tar; redirect any errors to a
  # temporary file
  # For multi-disk support, you can use the
  # -M option to tar
  tar -czf /dev/fd1 . >|/tmp/ERRORS$$ 2>&1
  # zero status indicates backup was successful
  if [ "$?" = "0" ]; then
    dialog --title "Backup" --msgbox "Backup \
completed successfully." 10 50
    # Mark script with current date and time
    touch ~/.backup
  else
    # Backup failed, display error log
    dialog --title "Backup" --msgbox "Backup failed \ -- Press
<Enter>
    to see error log." 10 50
    dialog --title "Error Log" --textbox /tmp/ERRORS$$ 22 72
  fi
fi

clear
