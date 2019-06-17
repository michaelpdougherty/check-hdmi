#!/bin/bash

currentConfig=/boot/config.txt
hdmiConfig=/home/pi/LCD-show/boot/config-nomal.txt
diffResult=$(diff $currentConfig $hdmiConfig)
hdmiResult=$(/opt/vc/bin/tvservice -d edid.dat)

if [[ "$hdmiResult" == "Nothing written!" ]]
then
	if [[ "$diffResult" -eq 0 ]]
	then
		echo "HDMI disconnected and enabled"
		echo "Enabling LCD display..."
		cd /home/pi/LCD-show
		sudo ./MHS35-show
	else
		echo "HDMI disconnected and disabled"
		echo "Continuing with LCD display..."
	fi
else
	if [[ "$diffResult" -eq 0 ]]
	then
		echo "HDMI connected and enabled"
		echo "Continuing with HDMI display..."
	else
		echo "HDMI connected and disabled"
		echo "Enabling HDMI display..."
		cd /home/pi/LCD-show
		sudo ./LCD-hdmi
	fi
fi
