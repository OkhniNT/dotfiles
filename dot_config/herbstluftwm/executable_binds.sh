# remove all existing keybindings
hc keyunbind --all

# keybindings
Super=Mod4
Alt=Mod1

hc keybind $Super-Shift-q   quit
hc keybind $Super-F12       reload
hc keybind $Super-q         close
hc keybind $Super-F1        spawn ~/.config/herbstluftwm/scripts/info-notif.sh
hc keybind $Super-End       spawn dpms-standby

hc keybind $Super-Return        spawn st
hc keybind $Super-Shift-Return  spawn st -c 'popterm'
hc keybind $Super-d             spawn rofi -show run
hc keybind $Super-F2            spawn xdg-wrapper firefox
hc keybind $Super-Shift-s       spawn shotclip

# media keys
hc keybind XF86AudioRaiseVolume     spawn ~/.config/herbstluftwm/scripts/volume.sh inc
hc keybind XF86AudioLowerVolume     spawn ~/.config/herbstluftwm/scripts/volume.sh dec
hc keybind XF86AudioMute            spawn ~/.config/herbstluftwm/scripts/volume.sh mute
hc keybind XF86AudioPlay            spawn playerctl play-pause
hc keybind XF86AudioNext            spawn playerctl next
hc keybind XF86AudioPrev            spawn playerctl previous
hc keybind XF86MonBrightnessUp      spawn ~/.config/herbstluftwm/scripts/bright.sh inc
hc keybind XF86MonBrightnessDown    spawn ~/.config/herbstluftwm/scripts/bright.sh dec

# focus clients
hc keybind $Super-h     focus left
hc keybind $Super-j     focus down
hc keybind $Super-k     focus up
hc keybind $Super-l     focus right

# moving clients
hc keybind $Super-Shift-h       shift left
hc keybind $Super-Shift-j       shift down
hc keybind $Super-Shift-k       shift up
hc keybind $Super-Shift-l       shift right

hc keybind $Super-Shift-grave   shift_to_monitor +1

# misc focus
hc keybind $Super-grave     cycle_monitor
hc keybind $Alt-Tab         cycle
hc keybind $Alt-Shift-Tab   cycle -1
hc keybind $Alt-a           cycle_all
# hc keybind $Super-i         jumpto urgent

# tags
hc set default_frame_layout 'horizontal'
tag_names=( {1..9} 0 )
tag_keys=( {1..9} 0 )
hc set_layout horizontal

hc rename default "${tag_names[0]}" || true
for i in "${!tag_names[@]}" ; do
    hc add "${tag_names[$i]}"
    key="${tag_keys[$i]}"
    if [ -n "$key" ] ; then
        hc keybind "$Super-$key" use_index "$i"
        hc keybind "$Super-Shift-$key" move_index "$i"
    fi
done

# splitting frames
# create an empty frame at the specified direction
hc keybind $Super-u         split       bottom  0.5
hc keybind $Super-o         split       right   0.5
hc keybind $Super-Shift-o   chain ,     split left 0.3 , split right 0.5714
# let the current frame explode into subframes
hc keybind $Super-Shift-semicolon split explode

# layouting
hc keybind $Super-i remove
# hc keybind $Super-Shift-s floating toggle
hc keybind $Super-f             fullscreen toggle
hc keybind $Super-s             set_attr clients.focus.floating toggle
hc keybind $Super-Shift-d       set_attr clients.focus.decorated toggle
hc keybind $Super-p             set_attr clients.focus.sticky toggle
hc keybind $Super-Shift-m       set_attr clients.focus.minimized true
hc keybind $Super-Control-m     jumpto last-minimized
hc keybind $Super-Shift-p       pseudotile toggle
hc keybind $Super-semicolon cycle_layout +1 vertical horizontal
hc keybind $Super-t set_layout max

# resizing frames and floating clients
resizestep=0.02
hc keybind $Super-Control-h       resize left +$resizestep
hc keybind $Super-Control-j       resize down +$resizestep
hc keybind $Super-Control-k       resize up +$resizestep
hc keybind $Super-Control-l       resize right +$resizestep

# focus previous tag
hc keybind $Super-Tab use_previous

# mouse
hc mouseunbind --all
hc mousebind $Super-Button1 move
hc mousebind $Super-Button2 zoom
hc mousebind $Super-Button3 resize
