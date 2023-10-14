getworkspaces() {
    tags="$(herbstclient tag_status | sed 's/\s//g;s/[0-9]/&\n/g;s/\.//g')"
    echo -n "(box :class 'workspaces'"
    for tag in $tags; do
        case $tag in
            \#*)
                echo -n "(box :class 'tag_active' '${tag:1}')"
                ;;
            -*)
                echo -n "(box :class 'tag_focused' '${tag:1}')"
                ;;
            !*)
                echo -n "(box :class 'tag_urgent' '${tag:1}')"
                ;;
            :*)
                echo -n "(box :class 'tag_occupied' '${tag:1}')"
                ;;
            *)
                ;;
        esac
    done
    echo -n ")"
    echo
}

getworkspaces
{ herbstclient -i tag_changed & herbstclient -i tag_flags & } | while read line; do
    getworkspaces
done
