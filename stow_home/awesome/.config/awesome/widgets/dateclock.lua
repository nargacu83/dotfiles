local wibox = require("wibox")

local dateclock = {
    format = "%a %d %b",
    widget = wibox.widget.textclock
}

return dateclock
