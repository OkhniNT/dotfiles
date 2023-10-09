capacity="$(cat /sys/class/power_supply/BAT0/capacity)"
timeremain="$(echo "scale=2; $(cat /sys/class/power_supply/BAT0/charge_now) / $(cat /sys/class/power_supply/BAT0/current_now)" | bc)"

echo "$capacity%, $timeremain hrs"
