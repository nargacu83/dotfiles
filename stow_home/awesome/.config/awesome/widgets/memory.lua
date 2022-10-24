local wibox = require("wibox")
local beautiful = require("beautiful")
require("status.memory")


local memory = wibox.widget {
    widget = wibox.widget.textbox
}

local widget = {
    widget = wibox.container.place,
    layout = wibox.layout.fixed.horizontal,
    spacing = 5,
    {
        widget = wibox.container.place,
        {
            widget = wibox.widget.imagebox,
            image = os.getenv("HOME") .. "/.config/awesome/theme/icons/cpu.svg",
            forced_width = 16,
            resize = true,
        },
    },

    memory
}

awesome.connect_signal("status::memory", function(usage, total)
    memory.font = beautiful.font
    local markup = usage .. " MiB" .. " / " .. total .. " MiB"
    memory.markup = markup
end)

return widget
