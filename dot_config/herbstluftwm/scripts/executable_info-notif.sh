datetime="$(date '+%F %R, %A')"

batcap="$(cat /sys/class/power_supply/BAT0/capacity)"
battime="$(echo "scale=2; $(cat /sys/class/power_supply/BAT0/charge_now) / $(cat /sys/class/power_supply/BAT0/current_now)" | bc)"

notify-send "Info" "BAT0: $batcap%, $battime hrs\n$datetime"
