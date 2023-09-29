herbstclient tag_status | sed 's/\s//g' | sed 's/[0-9]/& /g'

herbstclient -i focus_changed | while read line; do
    herbstclient tag_status | sed 's/\s//g' | sed 's/[0-9]/& /g'
done
