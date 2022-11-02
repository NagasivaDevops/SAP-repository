#!/bin/bash
clear
read_menu()
{
b=$(hostname -f)
echo "$host"
z=$(whoami|cut -c1-3|tr a-z A-Z)
while [ 1 ]
do
echo "========================WELCOME TO START AND STOP SCRIPT OF THE  SAP APPLICATION  SERVERS"
echo " We are exeuting the script on the server $b on the date  `date` "
echo " SID OF THE SYSTEM : $z"
echo "Enter 1. Check the Central ASCS Application services"
echo "      2. Check the Additional Dailog Application services"
echo "      3. start the ASCS Application services"
echo "      4. Start the Additonal  Dailog Application servies"
echo "      5. stop  the ASCS Application services"
echo "      6. stop  the Additonla Dailog  Application services"
echo "      7. Quit the script "
echo "      8. Chekcing the Database services"
echo "========================="
read -p "Enter your option(1-6): " opt
  case  $opt in
        1)  Check_ASCS
        ;;

        2) Check_Dailog
        ;;

        3) Check_DB
        ;;

  esac
done
}


Check_ASCS()
{
 echo "Checking Central ASCS Applcaition services are running or not"
                echo " enter the Central ASCS application instance number "
                read -p "Enter the instance number: " n
                #e=$(whoami|cut -c1-3|tr a-z A-Z)
                #cd /usr/sap/$e
                #n=(ls -ltr | grep -i ASCS | cut -d ' ' -f 13|cut -c5-7)
                VAR5=$(sapcontrol -nr $n -function GetProcessList | cut -d ',' -f 2,3 | tail -4 | grep -i "MessageServer"|cut -d ',' -f 2|cut -d ' ' -f 2)
                VAR6="GREEN"
                 if [ "$VAR5" = "$VAR6" ]; then
                    echo "Messageserver  Service is  running"
                 else
                     echo "Messagserver  Service is not running."
                 fi
                 VAR7=$(sapcontrol -nr $n -function GetProcessList | cut -d ',' -f 2,3 | tail -4 | grep -i "enserver"| cut -d ',' -f 2 | cut -d ' ' -f 2)
                 VAR8="GREEN"
                 if [ "$VAR7" = "$VAR8" ]; then
                    echo "Enqueue Server  Service is  running ."
                 else
                    echo "Enqueue Server  Service is not  running."
                 fi
}
Check_Dailog()
{
                echo "Checking Additional Dailog Application services are running or not"
                echo " enter the Additional Dailog Application services instance number "
                read -p "Enter the instance number: " n
                VAR5=$(sapcontrol -nr $n -function GetProcessList | cut -d ',' -f 2,3 | tail -4 | grep -i "Dispatcher"|cut -d ',' -f 2|cut -d ' ' -f 2)
                VAR6="GREEN"
                 if [ "$VAR5" = "$VAR6" ]; then
                    echo "Dispatcher Service is  running"
                    echo -e "${GREEN}Dispatcher Service is  running${ENDCOLOR}"
                 else
                     echo "Dispatcher Service is not running."
                     echo -e "${RED}HDBDispatcher  Service is not running, ${ENDCOLOR}"
                 fi
                 VAR7=$(sapcontrol -nr $n -function GetProcessList | cut -d ',' -f 2,3 | tail -4 | grep -i "IGS Watchdog"|cut -d ',' -f 2|cut -d ' ' -f 2)
                 VAR8="GREEN"
                 if [ "$VAR7" = "$VAR8" ]; then
                    echo "IGS Watchdog Service is  running ."
                    echo -e "${GREEN}Watchdog Service is  running${ENDCOLOR}"
                 else
                    echo "IGS Watchdog Service is not  running."
                    echo -e "${RED}Watchdog  Service is not running, ${ENDCOLOR}"
                 fi
                 VAR3=$(sapcontrol -nr $n -function GetProcessList | cut -d ',' -f 2,3 | tail -4 | grep -i "Gateway"|cut -d ',' -f 2|cut -d ' ' -f 2)
                 VAR4="GREEN"
                 if [ "$VAR3" = "$VAR4" ]; then
                     echo "Gateway Service is running ."
                     echo -e "${GREEN}HDB Gateway Service is  running${ENDCOLOR}"
                 else
                     echo "Gateway service is not  running."
                     echo -e "${RED}Gateway  Service is not running, ${ENDCOLOR}"
                 fi
                 VAR1=$(sapcontrol -nr $n -function GetProcessList | cut -d ',' -f 2,3 | tail -4 | grep -i "ICM"|cut -d ',' -f 2|cut -d ' ' -f 2)
                 VAR2="GREEN"
                 if [ "$VAR1" = "$VAR2" ]; then
                    echo "ICM service is running."
                    echo -e "${GREEN}ICM Service is  running${ENDCOLOR}"
                 else
                    echo "ICM service is not running ."
                    echo -e "${RED}ICM  Service is not running, ${ENDCOLOR}"
                 fi

}

Check_DB()
{
    ssh vmweutessdb02 <'/sapsw/ENoSIX/scripts/db_script.sh'
}
read_menu
