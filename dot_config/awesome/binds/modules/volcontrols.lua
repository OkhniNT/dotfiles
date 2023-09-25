local awful = require("awful")
local naughty = require("naughty")

local M = {}

local increment = 5

local function notify (icon)
    naughty.destroy_all_notifications()
    awful.spawn.easy_async("wpctl get-volume @DEFAULT_AUDIO_SINK@", function(stdout)
        naughty.notification {
            title = icon,
            message = stdout,
        }
    end)
end

function M.up ()
    awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. increment .. "%+")
    local icon = ""
    notify(icon)
end

function M.down ()
    awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. increment .. "%-")
    local icon = ""
    notify(icon)
end

function M.mute ()
    awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")

    awful.spawn.easy_async("wpctl get-volume @DEFAULT_AUDIO_SINK@", function(stdout)
        if stdout:match(".*[MUTED].*") then
            local icon = ""
            notify(icon)
        else
            local icon = ""
            notify(icon)
        end
    end)
end

return M
