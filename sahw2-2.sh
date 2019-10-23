#!/bin/bash
OPTION=$(
  dialog --title "SYS INFO" --menu "" 15 60 4 \
  "1" "CPU INFO" \
  "2" "MEMORY INFO" \
  "3" "NETWORK INFO" \
  "4" "FILE BROWSER" 3>&1 1>&2 2>&3
)

exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ $OPTION = 1 ]; then
    #dialog --title "CPU INFO" --gauge 5 30 27
    #dialog --msgbox "${sysctl hw.model | awk -F":" '{print("CPU Model:","\t",$2)}'}"
    result_model=$(sysctl hw.model | awk -F":" '{print("CPU Model:","\t",$2)}')
    result_machine=$(sysctl hw.machine | awk -F":" '{print("CPU Machine:","\t",$2)}')
    result_ncpu=$(sysctl hw.ncpu | awk -F":" '{print("CPU Core:","\t",$2)}')
    dialog --msgbox "CPU INFO
    ${result_model} 
    ${result_machine} 
    ${result_ncpu}" 15 60

  elif [ $OPTION = 2 ]; then
    #result_total_mem=$(sysctl hw.realmem | awk '{print("Total: %.2f", $2/1024/1024/1024}' )
    #result_used_mem=$(sysctl hw.usermem | awk '{print("Used: $.2f", $2/1024/1024/1024}' )
    #result_free_mem=$(sysctl hw.realmem hw.usermem | awk 'NR==1{resut=$2;}NR==2{result=result-$2}END{print("%.2f",result/1024/1024/1024)}')
    #sysctl hw.realmem hw.usermem | awk 'NR==1{resut=$2;}NR==2{result=result-$2}END{print(result)}'



    #result_parcent=$(syctl hw.realmem hw.usermem hw.realmem | awk 'NR==1{result=$2}NR==2{result=result-$1}NR==3{result')
    
    result_total_mem=$(sysctl hw.realmem | cut -d' ' -f2 | bc)
    result_used_mem=$(sysctl hw.usermem | cut -d' ' -f2 | bc)
    result_free_mem=result_total_mem-result_used_mem
    result_persent=int(100*result_free_mem/result_total_mem)
    
    
    dialog --msgbox "
    Memory Info and USage\
    \
    Total: ${result_total_mem}\
    Used: ${result_used_mem}\
    Free: ${result_free_mem}\
    " 15 60
    --gauge "Overall Progress" 5 40 ${result_persent}
  

  
  fi;
else
  echo "You chose Cancel."
fi
