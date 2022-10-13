local wibox = require("wibox")
local beautiful = require("beautiful")
require("status.memory")

local memory = wibox.widget {
    widget = wibox.widget.textbox
}

awesome.connect_signal("status::memory", function(usage, total)
    memory.font = beautiful.font
    local markup = usage .. " MiB" .. " / " .. total .. " MiB"
    memory.markup = markup
end)

return memory
