increment=5

case $1 in
    inc)
        light -A $increment
        icon=" "
        ;;
    dec)
        light -U $increment
        icon=" "
        ;;
esac

notify-send -r 1 "$icon" "$(light)"
