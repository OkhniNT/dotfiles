local awful = require("awful")
local naughty = require("naughty")

local M = {}

local increment = 5

local function notify (notif, icon)
    naughty.destroy_all_notifications()
    awful.spawn.easy_async("wpctl get-volume @DEFAULT_AUDIO_SINK@", function(stdout)
        naughty.notification {
            title = icon,
            message = string.sub(stdout, 8),
        }
    end)
end

function M.up (notif)
    awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. increment .. "%+")
    local icon = ""
    notify(notif, icon)
end

function M.down (notif)
    awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. increment .. "%-")
    local icon = ""
    notify(notif, icon)
end

function M.mute (notif)
    awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")

    awful.spawn.easy_async("wpctl get-volume @DEFAULT_AUDIO_SINK@", function(stdout)
        if stdout == "^.*[MUTED]$" then
            local icon = ""
            notify(notif, icon)
        else
            local icon = ""
            notify(notif, icon)
        end
    end)
end

return M
