#!/bin/bash
OPTION=$(
  dialog --title "Test Menu Dialog" --menu "Choose your option" 15 60 4 \
  "1" "Grilled Spicy Sausage" \
  "2" "Grilled Halloumi Cheese" \
  "3" "Charcoaled Chicken Wings" \
  "4" "Fried Aubergine" 3>&1 1>&2 2>&3
)

exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [$OPTION = 1]; then
    #dialog --title "CPU INFO" --gauge 5 30 27
    dialog --msgbox "${sysctl hw.model | awk -F":" '{print("CPU Model:","\t",$2)}'}"
    sysctl hw.model | awk -F":" '{print("CPU Model:","\t",$2)}'
  fi

else
  echo "You chose Cancel."
fi
