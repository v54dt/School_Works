#!/bin/bash

#dialog --menu "sys info" 15 40 4 "1" "CPU INFO" "2" "MEMORY INFO" "3" "NETWORK INFO" "4" "FILE BROWSER"

#!/bin/bash
OPTION=$(dialog --title "Test Menu Dialog" --menu "Choose your option" 15 60 4 \
"1" "Grilled Spicy Sausage" \
"2" "Grilled Halloumi Cheese" \
"3" "Charcoaled Chicken Wings" \
"4" "Fried Aubergine"  3>&1 1>&2 2>&3)
 
exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "Your chosen option:" $OPTION
else
    echo "You chose Cancel."
fi
