#!/usr/local/bin/bash
OPTION=$(
  dialog --title "SYS INFO" --menu "" 15 60 4 \
  "1" "CPU INFO" \
  "2" "MEMORY INFO" \
  "3" "NETWORK INFO" \
  "4" "FILE BROWSER" 3>&1 1>&2 2>&3
)

exitstatus=$?
if [ $exitstatus = 0 ]; then
  case ${OPTION} in
  "1")
    #dialog --title "CPU INFO" --gauge 5 30 27
    #dialog --msgbox "${sysctl hw.model | awk -F":" '{print("CPU Model:","\t",$2)}'}"
    result_model=$(sysctl hw.model | awk -F":" '{print("CPU Model:","\t",$2)}')
    result_machine=$(sysctl hw.machine | awk -F":" '{print("CPU Machine:","\t",$2)}')
    result_ncpu=$(sysctl hw.ncpu | awk -F":" '{print("CPU Core:","\t",$2)}')
    result_title="CPU INFO"
    dialog --msgbox "
    ${result_title}
    ${result_model} 
    ${result_machine} 
    ${result_ncpu}" 15 60
    ;;

  "2")

    #result_total_mem=$(sysctl hw.realmem | awk '{print("Total: %.2f", $2/1024/1024/1024}' )
    #result_used_mem=$(sysctl hw.usermem | awk '{print("Used: $.2f", $2/1024/1024/1024}' )
    #result_free_mem=$(sysctl hw.realmem hw.usermem | awk 'NR==1{resut=$2;}NR==2{result=result-$2}END{print("%.2f",result/1024/1024/1024)}')
    #sysctl hw.realmem hw.usermem | awk 'NR==1{resut=$2;}NR==2{result=result-$2}END{print(result)}'

    #result_parcent=$(syctl hw.realmem hw.usermem hw.realmem | awk 'NR==1{result=$2}NR==2{result=result-$1}NR==3{result')
    
    declare -i result_total_mem
    declare -i result_free_mem
    declare -i result_persent
    result_total_mem=$(sysctl hw.realmem | cut -d' ' -f2 | bc)
    result_used_mem=$(sysctl hw.usermem | cut -d' ' -f2 | bc)



    result_free_mem=result_total_mem-result_used_mem
    result_persent=${result_free_mem}*100/${result_total_mem}
    result_title="Memory Info and Usage"

    dialog --title "" --gauge "
    ${result_title}
    Total: ${result_total_mem}
    Used: ${result_used_mem}
    Free: ${result_free_mem}
    " 15 60 ${result_persent}
    ;;

  "3")

    net_OPTION=$(
      dialog --title "SYS INFO" --menu "" 15 60 4 \
      "em0" "*" \
      "em1" "*" \
      "lo0" "*" \
      "pflog0" "*" 3>&1 1>&2 2>&3
    )

    net_exitstatus=$?
    if [ $net_exitstatus = 0 ]; then
      case $net_OPTION in
      "em0")
        em0_title="Interface Name: em0"
        em0_ipv4=IPv4___: $(ifconfig -a | grep em0 | grep inet | cut -d' ' -f2)
        em0_netmask=Netmask: $(ifconfig-a | grep em0 | grep inet | cut -d' ' -f4)
        em0_mac=MAC____: $(ifconfig-a | grep em0 | grep inet | head -1 | cut -d' ' -f2)
        dialog --msgbox "
            ${em0_title}

            ${em0_ipv4}
            ${em0_netmask}
            ${em0_mac}
            " 15 60
        echo "em0"
        ;;
        #elif [ net_OPTION = em1 ]; then
      "em1")
        em1_title="Interface Name: em1"
        em1_ipv4=IPv4___: $(ifconfig -a | grep inet | head -1 | cut -d' ' -f2)
        em1_netmask=Netmask: $(ifconfig -a | grep inet | head -1 | cut -d' ' -f4)
        em1_mac=MAC____: $(ifconfig -a | grep ether | head -1 | cut -d' ' -f2)

        dialog --msgbox "
            ${em1_title}

            ${em1_ipv4}
            ${em1_netmask}
            ${em1_mac}
            " 15 60
        echo "em1"
        ;;
        #elif [ net_OPTION = lo0 ]; then
      "lo0")
        lo0_title=Interface Name: lo0
        lo0_ipv4=IPv4___: $(ifconfig -a | grep inet | tail -1 | cut -d' ' -f2)
        lo0_netmask=Netmask: $(ifconfig -a | grep inet | tail -1 | cut -d' ' -f4)
        lo0_mac=MAC____: $(ifconfig -a | grep ether | head -1 | cut -d' ' -f2)
        dialog --msgbox "
            ${lo0_title}

            ${lo0_ipv4}
            ${lo0_netmask}
            ${lo0_mac}
            " 15 60

        echo "lo0"
        ;;
        #elif [ net_OPTION = pflo0 ]; then
      "pflo0")
        pflo0_title=Interface Name: em1
        pflo0_ipv4=IPv4___: $(ifconfig -a | grep pflo0 | tail -1 | cut -d' ' -f2)
        pflo0_netmask=Netmask: $(ifconfig -a | grep pflo0 | tail -1 | cut -d' ' -f4)
        pflo0_mac=MAC____: $(ifconfig -a | grep pflo0 | head -1 | cut -d' ' -f2)
        dialog --msgbox "
            ${pflo0_title}

            ${pflo0_ipv4}
            ${pflo0_netmask}
            ${pflo0_mac}
            " 15 60
        echo "pflo0"
        ;;
      "*")
        echo "false"
        ;;
      esac

    else
      echo "you choose net canncel "
    fi

    ;;
  "4")
    dialog --msgbox "file browser" 15 60
    ;;
  esac

else
  echo "you choose cancel"
fi
