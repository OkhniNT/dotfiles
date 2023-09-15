local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local vol = require("binds.modules.volcontrols")
local bright = require("binds.modules.brightcontrols")

-- @DOC_DEFAULT_APPLICATIONS@
terminal = "st"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
modkey = "Mod4"
-- }}}

-- {{{ Menu
-- @DOC_MENU@
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu },
                                    { "terminal", terminal }
                                  }
                        })

-- {{{ Mouse bindings
-- @DOC_ROOT_BUTTONS@
awful.mouse.append_global_mousebindings({
    awful.button({ }, 3, function () mymainmenu:toggle() end),
})

-- @DOC_CLIENT_BUTTONS@
client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click"}
        end),
        awful.button({ modkey }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"}
        end),
        awful.button({ modkey }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)

-- }}}

-- {{{ Key bindings
-- @DOC_GLOBAL_KEYBINDINGS@

-- General Awesome keys
awful.keyboard.append_global_keybindings({
    awful.key({ modkey }, "F1", hotkeys_popup.show_help, {description="show help", group="awesome"}),
    awful.key({ modkey, "Shift" }, "q", awesome.quit, {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey }, "w", function () mymainmenu:show() end, {description = "show main menu", group = "awesome"}),
    awful.key({ modkey }, "F12", awesome.restart, {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift" }, "d", function () awful.screen.focused().mypromptbox:run() end, {description = "run prompt", group = "launcher"}),
    awful.key({ modkey }, "x", function () awful.prompt.run {
        prompt = "Run Lua code: ",
        textbox = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
    }
    end, {description = "lua execute prompt", group = "awesome"}),

    awful.key({ modkey }, "Return", function () awful.spawn(terminal) end, {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift" }, "Return", function () awful.spawn(terminal .. " -c popterm") end, {description = "open a floating terminal", group = "launcher"}),
    awful.key({ modkey }, "r", function () awful.spawn(terminal .. " -e vifmrun") end, {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey }, "d", function () awful.spawn("rofi -show run") end, {description = "run rofi", group = "launcher"}),
    awful.key({ modkey }, "F2", function () awful.spawn("org.mozilla.firefox") end, {description = "open firefox", group = "launcher"}),
    awful.key({ modkey, "Shift" }, "s", function () awful.spawn("shotclip") end, {description = "screenshot selected area", group = "launcher"}),
})

-- Media keys
awful.keyboard.append_global_keybindings({
    awful.key({ }, "XF86AudioLowerVolume", function () vol.down(volnotif) end),
    awful.key({ }, "XF86AudioRaiseVolume", function () vol.up(volnotif) end),
    awful.key({ }, "XF86AudioMute", function () vol.mute(volnotif) end),
    awful.key({ }, "XF86AudioPlay", function () awful.util.spawn("playerctl play-pause") end),
    awful.key({ }, "XF86AudioNext", function () awful.util.spawn("playerctl next") end),
    awful.key({ }, "XF86AudioPrev", function () awful.util.spawn("playerctl previous") end),

    awful.key({ }, "XF86MonBrightnessUp", function () bright.up() end),
    awful.key({ }, "XF86MonBrightnessDown", function () bright.down() end),
})

-- @DOC_CLIENT_KEYBINDINGS@
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ modkey }, "q", function (c) c:kill() end, {description = "close", group = "client"}),
        awful.key({ modkey, "Shift" }, "grave", function (c) c:move_to_screen() end, {description = "move to screen", group = "client"}),

        awful.key({ modkey }, "f", function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end, {description = "toggle fullscreen", group = "client"}),
        awful.key({ modkey }, "s", awful.client.floating.toggle , {description = "toggle floating", group = "client"}),
        awful.key({ modkey }, "t", function (c) c.ontop = not c.ontop end, {description = "toggle keep on top", group = "client"}),
        awful.key({ modkey }, "p", function (c)
            c.sticky = not c.sticky
            c:raise()
        end, {description = "toggle sticky", group = "client"}),

        awful.key({ modkey }, "n",
            function (c)
                c.minimized = true
            end, {description = "minimize", group = "client"}),
        awful.key({ modkey, "Shift" }, "n", function ()
            local c = awful.client.restore()
            if c then
              c:activate { raise = true, context = "key.unminimize" }
            end
        end, {description = "restore minimized", group = "client"}),

        awful.key({ modkey }, "m", function (c)
            c.maximized = not c.maximized
            c:raise()
        end, {description = "(un)maximize", group = "client"}),
        -- awful.key({ modkey, "Control" }, "m", function (c)
        --     c.maximized_vertical = not c.maximized_vertical
        --     c:raise()
        -- end, {description = "(un)maximize vertically", group = "client"}),
    })
end)

awful.keyboard.append_global_keybindings({
    -- Layout related keybindings
    awful.key({ modkey, "Shift" }, "j", function () awful.client.swap.byidx(1) end, {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift" }, "k", function () awful.client.swap.byidx(-1) end, {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey }, "l", function () awful.tag.incmwfact( 0.05) end, {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey }, "h", function () awful.tag.incmwfact(-0.05) end, {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift" }, "h", function () awful.tag.incnmaster(1, nil, true) end, {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift" }, "l", function () awful.tag.incnmaster(-1, nil, true) end, {description = "decrease the number of master clients", group = "layout"}),
    -- awful.key({ modkey, "Control" }, "h", function () awful.tag.incncol( 1, nil, true) end, {description = "increase the number of columns", group = "layout"}),
    -- awful.key({ modkey, "Control" }, "l", function () awful.tag.incncol(-1, nil, true) end, {description = "decrease the number of columns", group = "layout"}),
    -- awful.key({ modkey }, "space", function () awful.layout.inc(1) end, {description = "select next", group = "layout"}),
    -- awful.key({ modkey, "Shift" }, "space", function () awful.layout.inc(-1) end, {description = "select previous", group = "layout"}),

    -- Focus related keybindings
    awful.key({ modkey }, "j", function () awful.client.focus.byidx( 1) end, {description = "focus next by index", group = "client"}),
    awful.key({ modkey }, "k", function () awful.client.focus.byidx(-1) end, {description = "focus previous by index", group = "client"}),
    awful.key({ modkey }, "Tab", awful.tag.history.restore, {description = "go back", group = "tag"}),
    awful.key({ modkey }, "grave", function () awful.screen.focus_relative(1) end, {description = "focus the next screen", group = "screen"}),

    -- Adjust tag gaps
    awful.key({ modkey }, "=", function (s, t) awful.tag.incgap(8, t) awful.layout.arrange(s) end, {description = "increase tag gap size by 8 pixels", group = "screen"}),
    awful.key({ modkey }, "-", function (s, t) awful.tag.incgap(-8, t) awful.layout.arrange(s) end, {description = "increase tag gap size by 8 pixels", group = "screen"}),
    awful.key({ modkey, "Shift" }, "=", function (s, t) awful.tag.setgap(8, t) awful.layout.arrange(s) end, {description = "reset tag gap size to 8 pixels", group = "screen"}),

    -- @DOC_NUMBER_KEYBINDINGS@
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control" },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { modkey, "Shift" },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control", "Shift" },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function (index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    }
})
