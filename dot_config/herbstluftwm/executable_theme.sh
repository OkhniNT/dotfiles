# import xresources
background="$(xrdb -get background)"
foreground="$(xrdb -get foreground)"

color0="$(xrdb -get color0)"
color1="$(xrdb -get color1)"
color2="$(xrdb -get color2)"
color3="$(xrdb -get color3)"
color4="$(xrdb -get color4)"
color5="$(xrdb -get color5)"
color6="$(xrdb -get color6)"
color7="$(xrdb -get color7)"
color8="$(xrdb -get color8)"
color9="$(xrdb -get color9)"
color10="$(xrdb -get color10)"
color11="$(xrdb -get color11)"
color12="$(xrdb -get color12)"
color13="$(xrdb -get color13)"
color14="$(xrdb -get color14)"
color15="$(xrdb -get color15)"

# theme
hc attr theme.tiling.reset 1
hc attr theme.floating.reset 1

hc set gapless_grid true
hc set smart_window_surroundings false
hc set smart_frame_surroundings false
hc set mouse_recenter_gap 0

hc set frame_border_active_color "$color2"
hc set frame_border_normal_color "$color8"

hc set frame_border_width 2
hc set show_frame_decorations 'all'
hc set frame_bg_transparent true
hc set frame_transparent_width 0
hc set frame_gap 0
hc set frame_padding 2

hc attr theme.active.color "$color2"
hc attr theme.normal.color "$color8"
hc attr theme.urgent.color "$color1"
hc attr theme.outer_color "$background"

hc set window_gap 2
hc attr theme.border_width 2

hc attr theme.title_font "monospace:pixelsize=0"
hc attr theme.tab_color "$color0"
hc attr theme.title_color "$color0"
hc attr theme.tab_outer_color "$color8"
hc attr theme.active.tab_color "$color8"
hc attr theme.active.title_color "$color2"

hc attr theme.title_height 6
hc attr theme.tab_outer_width 2
hc attr theme.title_when one_tab
