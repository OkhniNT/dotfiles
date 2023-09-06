-- awesome_mode: api-level=4:screen=on

-- @DOC_REQUIRE_SECTION@
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local ruled = require("ruled")
local hotkeys_popup = require("awful.hotkeys_popup")

local dpi = beautiful.xresources.apply_dpi

require 'binds'
require 'bar'
require 'rules'

require("awful.autofocus")

awful.spawn.once("xdg-portal-nuke")

-- {{{ Error handling
-- @DOC_ERROR_HANDLING@
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)
-- }}}

-- {{{ Garbage collection
gears.timer {
    timeout = 30,
    autostart = true,
    callback = function() collectgarbage() end
}
-- }}}

-- {{{ Variable definitions
-- @DOC_LOAD_THEME@
beautiful.init(gears.filesystem.get_xdg_cache_home() .. "wal/theme.lua")

-- {{{ Notifications

naughty.config.defaults.timeout = 2
naughty.config.defaults.border_width = dpi(3)
naughty.config.defaults.margin = dpi(6)

ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            screen           = awful.screen.preferred,
            implicit_timeout = 2,
        }
    }
end)

naughty.connect_signal("request::display", function(n)
    naughty.layout.box { notification = n }
end)

-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)
