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

val=$(light)
echo BRIGHT: ${val%.00}% >> ~/.cache/brightness.cache
