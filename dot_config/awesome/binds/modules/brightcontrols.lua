local awful = require("awful")
local naughty = require("naughty")

local M = {}

local increment = 5

local function notify (icon)
    naughty.destroy_all_notifications()
    awful.spawn.easy_async("light", function (stdout)
        naughty.notification {
            title = icon,
            message = stdout,
        }
    end)
end

function M.up ()
    awful.spawn("light -A " .. increment)
    local icon = " "
    notify(icon)
end

function M.down ()
    awful.spawn("light -U " .. increment)
    local icon = " "
    notify(icon)
end

return M
