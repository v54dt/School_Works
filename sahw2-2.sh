#!/bin/bash

#dialog --menu "sys info" 15 40 4 "1" "CPU INFO" "2" "MEMORY INFO" "3" "NETWORK INFO" "4" "FILE BROWSER"

#!/bin/bash
OPTION=$(dialog --title "SYS INFO" --menu "" 15 60 4 \
"1" "CPU INFO" \
"2" "Memory INFO" \
"3" "NETWORK INFO" \
"4" "FILE BROWSER"  3>&1 1>&2 2>&3)
 
exitstatus=$?
if [ $exitstatus = 1 ]; then
    dialog --title "CPU INFO" --gauge "tt" 10 40 27
else
    echo "You chose Cancel."
fi
