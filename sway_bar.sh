# Change this according to your device
################
# Variables
################

# Date and time
date_and_week=$(date "+%d/%m/%Y")
current_time=$(date "+%H:%M")

#############
# Commands
#############

# Audio and multimedia
audio_volume=$(pamixer --get-volume)
audio_is_muted=$(pamixer --get-mute)

# Network
network=$(ip route get 1.1.1.1 | grep -Po '(?<=dev\s)\w+' | cut -f1 -d ' ')
# interface_easyname grabs the "old" interface name before systemd renamed it
interface_easyname=$(dmesg | grep $network | grep renamed | awk 'NF>1{print $NF}')
ping=$(ping -c 1 www.google.ca | tail -1| awk '{print $4}' | cut -d '/' -f 2 | cut -d '.' -f 1)

# Others
loadavg_5min=$(cat /proc/loadavg | awk -F ' ' '{print $2}')

if ! [ $network ]
then
   network_active="Not Active"
else
   network_active="⇆"
fi

if [ $audio_is_muted = "true" ]
then
    audio_active='Muted'
else
    audio_active='Unmuted'
fi
echo "$network_active $interface_easyname ($ping ms) | Load AVG/5mins: $loadavg_5min | $audio_active Volume: $audio_volume% | $date_and_week $current_time"
