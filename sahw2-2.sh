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
    #dialog --msgbox "${sysctl hw.model | awk -F":" '{print("CPU Model:","\t",$2)}'}"
    result_model=$(sysctl hw.model | awk -F":" '{print("CPU Model:","\t",$2)}')
    result_machine=$(sysctl hw.machine | awk -F":" '{print("CPU Machine:","\t",$2)}')
    result_ncpu=$(sysctl hw.ncpu | awk -F":" '{print("CPU Core:","\t",$2)}')
    dialog --msgbox "CPU INFO \ ${result_model} \ ${result_machine} \ ${result_ncpu}" 15 60



  fi

else

  echo "You chose Cancel."
fi
