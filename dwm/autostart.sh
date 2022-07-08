#!/bin/bash
picom -b
xrandr --output HDMI-1-0 --auto --left-of eDP-1
feh --bg-scale ~/.config/wallpaper.image
setxkbmap -layout us,it -option grp:win_space_toggle
/usr/lib/notification-daemon-1.0/notification-daemon & disown
#raxpaper

cpu_now=($(head -n1 /proc/stat))
cpu_sum="${cpu_now[@]:1}"
cpu_sum=$((${cpu_sum// /+}))
cpu_last=("${cpu_now[@]}")
cpu_last_sum=$cpu_sum
sleep 1

while true; do
	vol=$(pactl get-sink-volume 0 | grep -o '[0-9]\{1,3\}%' | head -1)

	bat=$(cat /sys/class/power_supply/BAT0/capacity)
	bat_discharge=$(cat /sys/class/power_supply/BAT0/hwmon2/curr1_input)
	bat_current=$(cat /sys/class/power_supply/BAT0/charge_now)
	bat_time=$((bat_current/1000))
	if [ $bat_discharge == 0 ]
	then
		bat_time=260
	else
		bat_time=$((bat_time*60/bat_discharge))

	fi
	if [ $(grep "Charging" /sys/class/power_supply/BAT0/status) ]
	then
		bat_status="🗲 "
	else
		bat_status="⭭ "
	fi

	date=$(date +"%H:%M:%S | %a %d %b %Y")
	

	cpu_now=($(head -n1 /proc/stat))
	cpu_sum="${cpu_now[@]:1}"
	cpu_sum=$((${cpu_sum// /+}))
	cpu_delta=$((cpu_sum - cpu_last_sum))
	cpu_idle=$((cpu_now[4] - cpu_last[4]))
	cpu_used=$((cpu_delta - cpu_idle))
	cpu_usage=$((100 * cpu_used / cpu_delta))
	cpu_last=("${cpu_now[@]}")
	cpu_last_sum=$cpu_sum
	cpu_temp=$(cat /sys/class/pci_bus/0000:05/device/0000:05:00.0/hwmon/hwmon6/temp1_input)
	cpu_temp=$((cpu_temp/1000))

	gpu_usage=$(nvidia-smi --format=csv,noheader --query-gpu=utilization.gpu | grep -o "[0-9]\{1,3\}")
	gpu_temp=$(nvidia-smi --format=csv,noheader --query-gpu=temperature.gpu)

	ram_total=$(free | grep -o  "[0-9]\{1,\}" | head -n 1)
	ram_total_plus_used=$(free | grep -o  "[0-9]\{1,\}" | head -n 2 | awk '{n += $1}; END{print n}')
	ram_used=$(($ram_total_plus_used-$ram_total));
	ram_usage=$(bc <<< "scale=2;$ram_used*100/$ram_total")

	brightness_val=$(brightnessctl g)
	brightness_max=$(brightnessctl m)
	brightness=$(($brightness_val / $brightness_max))
	brightness=$(bc <<< "scale=0;$brightness_val*100/$brightness_max")

	xsetroot -name "| GPU:${gpu_usage}% ${gpu_temp}°C | CPU:${cpu_usage}% ${cpu_temp}°C | RAM:${ram_usage}% | Vol:${vol} | Bright:${brightness}% | Bat:${bat}% ${bat_time}m ${bat_status}| ${date}"

	sleep 1
done
