local wibox = require("wibox")

local hourclock = {
    format = "%H:%M",
    widget = wibox.widget.textclock
}

return hourclock
