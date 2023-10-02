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
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%
        icon=""
        ;;
esac

val=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d' ' -f2)
echo VOL: ${val#0.}% >> ~/.cache/volume.cache
