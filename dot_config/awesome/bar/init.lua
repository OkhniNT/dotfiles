local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local pc = os.getenv("PC")

beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- Tag layout
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({ awful.layout.suit.tile })
end)

-- Create a padding widget
mypadding = wibox.widget {
    wibox.widget.separator {
        orientation = "vertical",
        thickness = 0,
        forced_width = 7,
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
    layout = wibox.layout.fixed.horizontal,
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
    awful.tag({ "I", "II", "III", "IV", "V" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    if ( pc == "laptop" ) then
        -- Define variables
        wibar_height = 24
        tag_margin = 3
        tag_width = wibar_height

        -- Define wibar right-side widgets
        wibar_right_widgets = wibox.widget {
            wibox.widget.systray(),
            mypadding,
            mybattery,
            mypadding,
            mytextclock,
            mypadding,
            layout = wibox.layout.fixed.horizontal,
        }
    else
        -- Define variables
        wibar_height = 25
        tag_margin = 3
        tag_width = wibar_height

        -- Define wibar right-side widgets
        wibar_right_widgets = wibox.widget {
            wibox.widget.systray(),
            mypadding,
            mytextclock,
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
            margins = tag_margin,
            widget = wibox.container.margin,
        },
        -- update_callback = function () end,
    }

    -- @TASKLIST_BUTTON@
    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
            screen  = s,
            filter  = awful.widget.tasklist.filter.currenttags,
            style   = {
                shape = function (cr, w, h) gears.shape.rounded_rect (cr, w, h, 5) end,
            },
            buttons = {
                awful.button({ }, 1, function (c)
                    c:activate { context = "tasklist", action = "toggle_minimization" }
                end),
                awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
                awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
                awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
            },
            widget_template = {{{{{
                                id = "text_role",
                                widget = wibox.widget.textbox,
                            },
                            valign = "center",
                            halign = "center",
                            forced_height = wibar_height - tag_margin * 2,
                            widget = wibox.container.place,
                        },
                        left = tag_margin,
                        right = tag_margin,
                        widget = wibox.container.margin,
                    },
                    id = "background_role",
                    widget = wibox.container.background,
                },
                margins = tag_margin,
                widget = wibox.container.margin,
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
                s.mytasklist, -- Middle widget
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
                s.mytasklist, -- Middle widget
                wibar_right_widgets,
                expand = "none",
                layout = wibox.layout.align.horizontal,
            }
        }
    end
end)
