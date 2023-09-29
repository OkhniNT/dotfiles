increment=5

case $1 in
    inc)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ $increment%+
        icon=""
        ;;
    dec)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ $increment%-
        icon=""
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        icon=""
        ;;
esac

notify-send -r 1 "$icon" "$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"
