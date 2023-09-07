local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local pc = os.getenv("PC")

beautiful.init(gears.filesystem.get_xdg_cache_home() .. "wal/theme.lua")

-- Tag layout
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        awful.layout.suit.tile,
        awful.layout.suit.tile.left,
        awful.layout.suit.tile.bottom,
        awful.layout.suit.tile.top,
        awful.layout.suit.spiral.dwindle,
        awful.layout.suit.floating,
        awful.layout.suit.max,
        awful.layout.suit.max.fullscreen,
    })
end)

-- Create a padding widget
mypadding = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    wibox.widget.separator {
        orientation = "vertical",
        thickness = 0,
        forced_width = 8,
    },
    wibox.widget.separator {
        orientation = "vertical",
        thickness = 2,
        forced_width = 2,
    },
    wibox.widget.separator {
        orientation = "vertical",
        thickness = 0,
        forced_width = 8,
    },
}

-- Create a textclock widget
mytextclock = wibox.widget.textclock()

if ( pc == "laptop" ) then
    -- Create a battery widget
    mybattery = awful.widget.watch('sh -c "~/.config/awesome/bar/scripts/batcheck"', 60)
end

-- @DOC_FOR_EACH_SCREEN@
screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ "", "", "", "", "" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = wibox.container.margin (awful.widget.layoutbox {
            screen  = s,
            buttons = {
                awful.button({ }, 1, function () awful.layout.inc( 1) end),
                awful.button({ }, 3, function () awful.layout.inc(-1) end),
                awful.button({ }, 4, function () awful.layout.inc(-1) end),
                awful.button({ }, 5, function () awful.layout.inc( 1) end),
            }}, 3, 3, 3, 3)

    if ( pc == "laptop" ) then
        -- Define variables
        tag_width = 18
        wibar_height = 22

        -- Define wibar right-side widgets
        wibar_right_widgets = wibox.widget {
            wibox.widget.systray(),
            mypadding,
            mybattery,
            mypadding,
            mytextclock,
            mypadding,
            s.mylayoutbox,
            mypadding,
            layout = wibox.layout.fixed.horizontal,
        }
    else
        -- Define variables
        tag_width = 17
        wibar_height = 21

        -- Define wibar right-side widgets
        wibar_right_widgets = wibox.widget {
            wibox.widget.systray(),
            mypadding,
            mytextclock,
            mypadding,
            s.mylayoutbox,
            mypadding,
            layout = wibox.layout.fixed.horizontal,
        }
    end

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        style   = {
            shape       = function (cr, w, h) gears.shape.partial_squircle (cr, w, h, false, true, true, true, 3) end,
            shape_empty = function (cr, w, h) gears.shape.squircle (cr, w, h, 3) end,
        },
        buttons = taglist_buttons,
        widget_template = {{{
                    id = "text_role",
                    valign = "center",
                    halign = "center",
                    widget = wibox.widget.textbox,
                },
                forced_width = tag_width,
                id = "background_role",
                widget = wibox.container.background,
            },
            margins = 2,
            widget = wibox.container.margin,
        },
    }

    -- @TASKLIST_BUTTON@
    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
            screen  = s,
            filter  = awful.widget.tasklist.filter.currenttags,
            buttons = {
                awful.button({ }, 1, function (c)
                    c:activate { context = "tasklist", action = "toggle_minimization" }
                end),
                awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
                awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
                awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
            },
    }

    -- @DOC_WIBAR@
    -- Create the wibox
    if ( pc == "laptop" ) then
        s.mywibox = awful.wibar {
            position = "bottom",
            screen   = s,
            height = wibar_height,
            -- @DOC_SETUP_WIDGETS@
            widget   = {
                { -- Left widgets
                    mypadding,
                    s.mytaglist,
                    mypadding,
                    s.mypromptbox,
                    layout = wibox.layout.fixed.horizontal,
                },
                { -- Middle widget
                    s.mytasklist,
                    layout = wibox.layout.fixed.horizontal,
                },
                wibar_right_widgets,
                expand = "none",
                layout = wibox.layout.align.horizontal,
            }
        }
    else
        s.mywibox = awful.wibar {
            position = "bottom",
            screen   = s,
            height = wibar_height,
            -- @DOC_SETUP_WIDGETS@
            widget   = {
                { -- Left widgets
                    mypadding,
                    s.mytaglist,
                    mypadding,
                    s.mypromptbox,
                    layout = wibox.layout.fixed.horizontal,
                },
                { -- Middle widget
                    s.mytasklist,
                    layout = wibox.layout.fixed.horizontal,
                },
                wibar_right_widgets,
                expand = "none",
                layout = wibox.layout.align.horizontal,
            }
        }
    end
end)
